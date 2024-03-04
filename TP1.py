import random

defaultgladiatorAP=20       #medium range 1->5 last stand si HP<40 +10AP
defaultBlackPriorAP=30      #short range 0->2 coup critique : 60AP mais -30HP
defaultWardenAP=15          #scaling damage 10AP 0->3, 15AP 3->5, 25AP 5->8
defaultShamanMP=20 
defaultShamaRange=6         #long range 0->6 takes damage while healing can heal self +20 -10
defaultElfMP=30             #short range heal 0->2
defaultAngelMP=10           #medium range 0->4

#paladin Executor execute : si a la fin de sa derniere attaque joueur.__HP<10 ->execute +  gagne 30HP low attack long range spam type 
#paladin TheGambler has a 50/50 chance of healing himself or dealing damage when attacking small heal big damage 
#paladin alchemsit good base sttats can heal and deal damage 



class Character :
    allchar=[]
    def __init__(self,name,position):
        self.__name=name
        self.__HP=80+random.randint(0, 20)
        self.__MaxHP=self.__HP
        self.__position=position
        Character.allchar.append(self)
        # self.toutes_classes=["guerrier","soigneurs","paladins"]
        # self.classe=self.toutes_classes[classe]
    def GetMaxHP(self):
        return self.__MaxHP   
    def SetMaxHP(self,newmaxhp):
        if (self.GetHP()<newmaxhp):
            self.SetHP(newmaxhp)
        self.__MaxHP=newmaxhp
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
    def __init__(self,name,position):
        super().__init__(name,position)


class Healer(Character):
    def __init__(self,name,magic,position):
        super().__init__(name,position)
        self.__MP=magic
    def GetMP(self):
        return self.__MP
    def SetMP(self,newMP):
        self.__MP=newMP
    def Heal(self,castNumber,player):
        # ajouter if dist respectée 
        # ajouter random dist after heal 
        # stun si trop greedy et heal 3 fois dans le vide ? sinon perte de MP temporaire  
        if (player.GetHP()!=0):
            for k in range(castNumber):
                newhp = player.GetHP() + self.GetMP()  # Utilisation de GetMP() pour obtenir la valeur de l'attribut privé
            
                if (newhp>=player.GetMaxHP()):
                    print(self.GetName(), "Healed to full", player.GetName())
                    player.SetHP(player.GetMaxHP())
                else :
                    player.SetHP(newhp)
                    print(self.GetName(), "heals player", player.GetName(), "of", self.GetMP(), "health back up to", player.GetHP(), "HP")
        else:
            print(self.GetName(), " can't heal ", player.GetName(), " because ", player.GetName(), " is dead")


class Paladin(Fighter):

    def __init__(self,name,position):
        super().__init__(name,position)


class Warrior(Fighter):

    def __init__(self,name,attack,position):
        super().__init__(name,position)
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
                player.SetHP(newhp)
                print(self.GetName()," attacks player ",player.GetName()," with ", self.GetAP(), "damage and puts",player.GetName()," to ", player.GetHP(), " HP") 





class Gladiator(Warrior):

    def __init__(self,name,position):
        super().__init__(name,defaultgladiatorAP,position)
        # self.SetAP(defaultgladiatorAP)

class BlackPrior(Warrior):
    def __init__(self,name,position):
        super().__init__(name,defaultBlackPriorAP,position)
        self.SetMaxHP(self.GetHP() - 10)
        self.SetHP(self.GetHP() - 10)

class Warden(Warrior):
    def __init__(self,name,position):
        super().__init__(name,defaultWardenAP,position)
        # self.SetAP(defaultWardenAP)
        self.SetMaxHP(self.GetHP() + 30)
        self.SetHP(self.GetHP() + 30) #more tanky ?

    

class Shaman(Healer):
    def __init__(self, name,position):
        super().__init__(name, defaultShamanMP,position)
        # self.SetMP(defaultShamanMP) # Cette ligne n'est pas nécessaire car c'est déjà fait dans le constructeur de la classe parente
    def Heal(self,castNumber,player):
        # ajouter if dist respectée
        if(abs(player.Getpos()-self.Getpos()) )
        # ajouter random dist after heal 
        # stun si trop greedy et heal 3 fois dans le vide ? sinon perte de MP temporaire  
        if (player.GetHP()!=0):
            for k in range(castNumber):
                newhp = player.GetHP() + self.GetMP()  # Utilisation de GetMP() pour obtenir la valeur de l'attribut privé
            
                if (newhp>=player.GetMaxHP()):
                    print(self.GetName(), "Healed to full", player.GetName())
                    player.SetHP(player.GetMaxHP())
                else :
                    player.SetHP(newhp)
                    print(self.GetName(), "heals player", player.GetName(), "of", self.GetMP(), "health back up to", player.GetHP(), "HP")
        else:
            print(self.GetName(), " can't heal ", player.GetName(), " because ", player.GetName(), " is dead")

class Elf(Healer):
    def __init__(self, name,position):
        super().__init__(name, defaultElfMP,position)
        self.SetMaxHP(self.GetHP() - 10)
        self.SetHP(self.GetHP() - 10)

class Angel(Healer):
    def __init__(self, name,position):
        super().__init__(name, defaultAngelMP,position)
        self.SetMaxHP(self.GetHP() - 20)
        #self.SetHP(self.GetHP() - 20)
    def Heal(self,castNumber,player):
        if (player.GetHP()==0):
            print("it's a miracle !!!",self.GetName()," is reviving", player.GetName(), " !!!!!!")
        for k in range(castNumber):
            newhp = player.GetHP() + self.GetMP()  # Utilisation de GetMP() pour obtenir la valeur de l'attribut privé
            if (newhp>=player.GetMaxHP()):
                print(self.GetName(), "Healed to full", player.GetName())
                player.SetHP(player.GetMaxHP())
            else :
                player.SetHP(newhp)
                print(self.GetName(), "heals player", player.GetName(), "of", self.GetMP(), "health back up to", player.GetHP(), "HP")



def printallchar():
    for char in Character.allchar:
        print(vars(char))




if __name__ == "__main__":
    print(defaultgladiatorAP)
    gab=BlackPrior("Gabriel",0)
    me=Gladiator("Natao",0)
    nessa=Angel("Inessa",0)
    me.Attack(5,gab)
    nessa.Heal(4,gab)
    printallchar()
