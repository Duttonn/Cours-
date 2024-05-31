import random

defaultgladiatorAP=20       # passive last stand si HP<40 +10AP
defaultgladiatorRange=4

defaultBlackPriorAP=30      #optionnal/active critical hit : x2 mais -30HP
defaultBlackPriorRange=4

defaultWardenAP=15        
defaultWardenRange=7


defaultShamanMP=20 
defaultShamaRange=5         # takes damage while healing can heal self +20 -10

defaultElfMP=30             
defaultElfRange=2


defaultAngelMP=10         
defaultAngelRange=3


defaultExorcistAP=15
defaultExorcistMP=10 
defaultExorcistRange=3


defaultExecutorAP=15    #good range to spam
defaultExecutorMP=30
defaultExecutorRange=5


defaultGamblerAP=40
defaultGamblerMP=15
defaultGamblerRange=2

def turnpass():
    for char in Character.allchar:
        char.Setpos(random.randint(0,10))

class Character :
    allchar=[]
    def __init__(self,name):
        self.__name=name
        self.__HP=80+random.randint(0, 20)
        self.__MaxHP=self.__HP
        self.__position=random.randint(0, 9)
        if self not in Character.allchar:
            Character.allchar.append(self)
        self.__range=0
        # self.toutes_classes=["guerrier","soigneurs","paladins"]
        # self.classe=self.toutes_classes[classe]
    #TODO: do add and substrack instead of get and set 
    def GetMaxHP(self):
        return self.__MaxHP   
    def SetMaxHP(self,newmaxhp):
        if (self.GetHP()>newmaxhp):
            self.SetHP(newmaxhp)
        self.__MaxHP=newmaxhp
    def GetRange(self):
        return self.__range
    def SetRange(self,range):
        self.__range=range
    def Getpos(self):
        return self.__position
    def Setpos(self,pos):
        self.__position=pos
    def GetHP(self):
        return self.__HP
    def SetHP(self,newHP):
        if(newHP<self.GetMaxHP()):
            self.__HP=newHP
        else:
            self.__HP=self.GetMaxHP()
    def GetName(self):
        return self.__name
    def SetName(self,newName):
        self.__name=newName




class Fighter(Character):

    def __init__(self,name,attack):
        Character.__init__(self,name)
        self.__AP=attack
        #self.AttackMode
    def GetAP(self):
        return self.__AP
    def SetAP(self,newAP):
        self.__AP=newAP
    def Attack(self,hits,player):
        for k in range(hits):
            newhp=player.GetHP() - self.GetAP()
            if (newhp<=0):
                print(self.GetName(), "killed", player.GetName())
                player.SetHP(0)
                break
            else :
                if abs(self.Getpos()-player.Getpos()) <= self.GetRange(): #if self and opponent in range of self 
                    player.SetHP(newhp)
                    print(self.GetName(),"at position", self.Getpos(),"attacks player",player.GetName(),"at position", player.Getpos(),"with", self.GetAP(), "damage and puts",player.GetName(),"to", player.GetHP(), "HP")
                else:
                    print("player not in range ")
            turnpass()

class Healer(Character):
    def __init__(self,name,magic):
        super().__init__(name)
        self.__MP=magic
    def GetMP(self):
        return self.__MP
    def SetMP(self,newMP):
        self.__MP=newMP
    def Heal(self,castNumber,player):
        # ajouter if dist respectée 
        # ajouter random dist after heal 
        # stun si trop greedy et heal 3 fois dans le vide ? sinon perte de MP temporaire  
        if (player.GetHP()!=0): #check if dead
            for k in range(castNumber):
                newhp = player.GetHP() + self.GetMP()  # Utilisation de GetMP() pour obtenir la valeur de l'attribut privé
                if (newhp>player.GetMaxHP()): #check if healed to full 
                    print(self.GetName(), "Healed to full", player.GetName())
                    player.SetHP(player.GetMaxHP())
                else :
                    if abs(self.Getpos()-player.Getpos()) <= self.GetRange():  #if self and opponent in range of self
                        player.SetHP(newhp)
                        print(self.GetName(),"at position", self.Getpos(), "heals player", player.GetName(),"at position", player.Getpos(), "of", self.GetMP(), "health back up to", player.GetHP(), "HP")
                    else:
                        print("player not in range")
                turnpass()
        else:
            print(self.GetName(), " can't heal ", player.GetName(), " because ", player.GetName(), " is dead")

class Warrior(Fighter):    
    def __init__(self,name,attack):
        super().__init__(name,attack)
        


class Paladin(Fighter, Healer):
    def __init__(self,name,attack,magic):
        # Appeler le constructeur de la classe parente Fighter
        Fighter.__init__(self,name, attack)
        # Appeler le constructeur de la classe parente Healer
        Healer.__init__(self,name, magic)




class Gladiator(Warrior):
     # passive last stand si HP<40 +10AP
    def __init__(self,name):
        super().__init__(name,defaultgladiatorAP)
        # self.SetAP(defaultgladiatorAP)
        self.SetRange(defaultgladiatorRange)
    def Attack(self,hits,player):
        if self.GetHP()<=40:
            print(self.GetName(),"is in last stand and damage is boosted")
            self.SetAP(defaultgladiatorAP+10)
        else:
            self.SetAP(defaultgladiatorAP)
        for k in range(hits):
            newhp=player.GetHP() - self.GetAP()
            if (newhp<=0):
                print(self.GetName(), "killed", player.GetName())
                player.SetHP(0)
                break
            else :
                if abs(self.Getpos()-player.Getpos()) <= self.GetRange(): #if self and opponent in range of self 
                    player.SetHP(newhp)
                    print(self.GetName(),"at position", self.Getpos(),"attacks player",player.GetName(),"at position", player.Getpos(),"with", self.GetAP(), "damage and puts",player.GetName(),"to", player.GetHP(), "HP")
                else:
                    print("player not in range ") 
                    
            turnpass()



class BlackPrior(Warrior):
    def __init__(self,name):
        super().__init__(name,defaultBlackPriorAP)
        self.SetRange(defaultBlackPriorRange)
        self.SetMaxHP(self.GetHP() - 10)
        self.SetHP(self.GetHP() - 10)
    def criticalhit(self,player):
        self.SetAP(defaultBlackPriorAP*2)
        self.SetHP(self.GetHP()-15)
        if self.GetHP()>0:
            print("player", self.GetName(),"sacrificed 15hp to deal a critical hit")
            self.Attack(1,player)
        else: 
            print("player", self.GetName(),"sacrificed 15hp and died trying to deal a critical hit, lol")
        self.SetAP(defaultBlackPriorAP)

class Warden(Warrior):
    def __init__(self,name):
        super().__init__(name,defaultWardenAP)
        # self.SetAP(defaultWardenAP)
        self.SetRange(defaultWardenRange)

        self.SetMaxHP(self.GetHP() + 30)
        self.SetHP(self.GetHP() + 30) #more tanky ?

    

class Shaman(Healer):
    def __init__(self, name):
        super().__init__(name, defaultShamanMP)
        self.SetRange(defaultShamaRange)  # takes damage while healing can heal self +20 -10
        # self.SetMP(defaultShamanMP) # Cette ligne n'est pas nécessaire car c'est déjà fait dans le constructeur de la classe parente
    def Heal(self,castNumber,player):
        if (player.GetHP()!=0): #check if dead
            for k in range(castNumber):
                if abs(self.Getpos()-player.Getpos()) <= self.GetRange():
                    self.SetHP(self.GetHP()-10)
                    if self.GetHP()<=0:
                        print(self.GetName(),"succombed to dark magic trying to heal", player.GetName())
                        break
                    else :
                        newhp = player.GetHP() + self.GetMP()  # Utilisation de GetMP() pour obtenir la valeur de l'attribut privé
                        if (newhp>player.GetMaxHP()): #check if healed to full 
                            print(self.GetName(), "Healed to full", player.GetName())
                            player.SetHP(player.GetMaxHP())
                        else :
                            #if self and opponent in range of self
                            player.SetHP(newhp)
                            print(self.GetName(),"at position", self.Getpos(), "heals player", player.GetName(),"at position", player.Getpos(), "of", self.GetMP(), "health back up to", player.GetHP(), "HP in exchange for 10 of his hp putting him to",self.GetHP())
                                

                else:
                    print("player not in range")
                        
                turnpass()
        else:
            print(self.GetName(), " can't heal ", player.GetName(), " because ", player.GetName(), " is dead")

class Elf(Healer):
    def __init__(self, name):
        super().__init__(name, defaultElfMP)
        self.SetRange(defaultElfRange)
        self.SetMaxHP(self.GetHP() - 10)
        self.SetHP(self.GetHP() - 10)
    def Heal(self,castNumber,player):
        # ajouter if dist respectée 
        # ajouter random dist after heal 
        # stun si trop greedy et heal 3 fois dans le vide ? sinon perte de MP temporaire  
        if (player.GetHP()!=0): #check if dead
            for k in range(castNumber):
                newhp = player.GetHP() + self.GetMP()  # Utilisation de GetMP() pour obtenir la valeur de l'attribut privé
                if (newhp>player.GetMaxHP()): #check if healed to full 
                    print(self.GetName(), "Healed to full", player.GetName(),"and overheals giving5 extra max health")
                    player.SetMaxHP(player.GetMaxHP()+5)
                    player.SetHP(player.GetMaxHP())
                else :
                    if abs(self.Getpos()-player.Getpos()) <= self.GetRange():  #if self and opponent in range of self
                        player.SetHP(newhp)
                        print(self.GetName(),"at position", self.Getpos(), "heals player", player.GetName(),"at position", player.Getpos(), "of", self.GetMP(), "health back up to", player.GetHP(), "HP")
                    else:
                        print("player not in range")
                turnpass()
        else:
            print(self.GetName(), " can't heal ", player.GetName(), " because ", player.GetName(), " is dead")



class Angel(Healer):
    def __init__(self, name):
        super().__init__(name, defaultAngelMP)
        self.SetMaxHP(self.GetHP() - 20)
        self.SetRange(defaultAngelRange)
        #self.SetHP(self.GetHP() - 20)
    def Heal(self,castNumber,player):
        if (player.GetHP()==0):
            print("it's a miracle !!!",self.GetName()," is reviving", player.GetName(), " !!!!!!")
        for k in range(castNumber):
            newhp = player.GetHP() + self.GetMP()  # Utilisation de GetMP() pour obtenir la valeur de l'attribut privé
            if (newhp>player.GetMaxHP()): #check if healed to full 
                print(self.GetName(), "Healed to full", player.GetName())
                player.SetHP(player.GetMaxHP())
            else :
                if abs(self.Getpos()-player.Getpos()) <= self.GetRange():  #if self and opponent in range of self
                    player.SetHP(newhp)
                    print(self.GetName(),"at position", self.Getpos(), "heals player", player.GetName(),"at position", player.Getpos(), "of", self.GetMP(), "health back up to", player.GetHP(), "HP")
                else:
                    print("player not in range")
            turnpass()

class Executor(Paladin):
    def __init__(self, name):
        super().__init__(name,defaultExecutorAP,defaultExecutorMP)
        self.SetRange(defaultExecutorRange)
    #paladin Executor execute : si a la fin de sa derniere attaque joueur.__HP<15 ->execute +  gagne 30HP low attack long range spam type 
    def Attack(self,hits,player):
        for k in range(hits):
            newhp=player.GetHP() - self.GetAP()
            if (newhp<=15):
                print(self.GetName(), "executed", player.GetName(),"and healed",self.GetMP(),"HP from it")
                player.SetHP(0)
                self.Heal(1,self)
                break
            else :
                if abs(self.Getpos()-player.Getpos()) <= self.GetRange(): #if self and opponent in range of self 
                    player.SetHP(newhp)
                    print(self.GetName(),"at position", self.Getpos(),"attacks player",player.GetName(),"at position", player.Getpos(),"with", self.GetAP(), "damage and puts",player.GetName(),"to", player.GetHP(), "HP")
                else:
                    print("player not in range ")
                    
            turnpass()

class Gambler(Paladin):
    def __init__(self, name):
        super().__init__(name,defaultGamblerAP,defaultGamblerMP)
        self.SetRange(defaultGamblerRange)
    #paladin TheGambler has a 50/50 chance of healing the opponent or dealing damage when attacking small heal big damage 
    def Attack(self,hits,player):
        for k in range(hits):
            newhp=player.GetHP() - self.GetAP()
            if (newhp<=0):
                print(self.GetName(), "killed", player.GetName())
                player.SetHP(0)
                break
            else :
                print("rolling the dices.....")
                if random.randint(0,1)==0:
                    print("Hit !!!")
                    if abs(self.Getpos()-player.Getpos()) <= self.GetRange(): #if self and opponent in range of self 
                        player.SetHP(newhp)
                        print(self.GetName(),"at position", self.Getpos(),"attacks player",player.GetName(),"at position", player.Getpos(),"with", self.GetAP(), "damage and puts",player.GetName(),"to", player.GetHP(), "HP")
                    else:
                        print("and it's a miss.... try again next time i'm sure you'll hit !!! it's called dedication for a reason")

                        
                else:
                    self.Heal(1,player)
            turnpass()

class Exorcist(Paladin):
    def __init__(self, name):
        super().__init__(name,defaultExorcistAP,defaultExorcistMP)
        self.SetRange(defaultExorcistRange)
        self.__range=defaultExorcistRange
    #paladin alchemsit good base sttats can heal and deal damage 







def printallchar():
    for char in Character.allchar:
        print(vars(char))



if __name__ == "__main__":



    # print(defaultgladiatorAP)
    #Ali=Exorcist("Ali",10,10,5)
    gab=BlackPrior("Gabriel")
    nessa=BlackPrior("Inessa")
    moi=Angel("Natao")
    # nessa.Attack(5,gab)
    # moi.Heal(12,gab)
    gamb=Gambler("gambler")
    gamb.Attack(3,moi)
    exe=Executor("executor")
    exe.Attack(10,gamb)
    exo=Exorcist("exorcist")
    exo.Attack(3,gab)
    exo.Heal(8,gab)
    Ali=Elf("Ali")
    Ali.Heal(100,moi)
    Ali.GetHP()
    printallchar()
