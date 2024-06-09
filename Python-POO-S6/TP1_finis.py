import random
import tkinter as tk
from tkinter import messagebox





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


class InvalidAttackError(Exception):
    """Exception raised when trying to attack with a fighter who has 0 HP."""

    def __init__(self, fighter_name):
        self.fighter_name = fighter_name
        super().__init__(f"Cannot attack with '{fighter_name}' because the fighter has 0 HP.")


class InvalidHealTargetError(Exception):
    """Exception raised when trying to heal a character who is dead."""

    def __init__(self, target_name):
        self.target_name = target_name
        super().__init__(f"Cannot heal '{target_name}' because the character is dead.")

#TODO:add outofrange Exception ?



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
    #TODO: do add and substrack instead of get and set, do the all info
    def __str__(self) -> str:
        return str(self.GetName()) +" HP : " +str(self.GetHP())
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
    def Allinfo(self) :
        print("the carracter is ", self.__name, "he has",self.__HP,"hp", "out of", self.__MaxHP,"max hp", "and he is at position :", self.__position)



class Fighter(Character):
    def __init__(self,name,attack):
        Character.__init__(self,name)
        self.__AP=attack
        #self.AttackMode
    def GetAP(self):
        return self.__AP
    def SetAP(self,newAP):
        self.__AP=newAP
    def Allinfo(self) :
        print("the carracter is ", self.GetName(),"is type Fighter,", "he has ",self.GetHP(),"hp", "out of", self.GetMaxHP(),"max hp",", has", self.GetAP(), "attack power", "and he is at position :", self.Getpos())
    def Attack(self,hits,player):
        if self.GetHP() <= 0:
            raise InvalidAttackError(self.GetName())
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
    def __lt__(self, other) :
        if self.GetMP() <= other.GetMP() :
            return self 
        else :
            return other
    def __str__(self) -> str:
        return str(self.GetName()) +" HP : " +str(self.GetHP())+" MP : " +str(self.GetMP())
    def Allinfo(self) :
        print("the carracter is ", self.GetName(),"is type Healer,", "he has ",self.GetHP(),"hp", "out of",  self.GetMaxHP(),"max hp",", has", self.GetMP(), "healing/magic power", "and he is at position :", self.Getpos())
    def Heal(self,castNumber,player):
        # ajouter if dist respectée 
        # ajouter random dist after heal 
        # stun si trop greedy et heal 3 fois dans le vide ? sinon perte de MP temporaire  
        if player.GetHP() == 0:
            raise InvalidHealTargetError(player.GetName())
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

class Warrior(Fighter):    
    def __init__(self,name,attack):
        super().__init__(name,attack)
    def Allinfo(self) :
        print("the carracter is ", self.GetName(),"is type Warior,", "he has ",self.GetHP(),"hp", "out of", self.GetMaxHP(),"max hp",", has", self.GetAP(), "attack power", "and he is at position :", self.Getpos())
    def __lt__(self, other) :
        if self.GetAP() <= other.GetAP() :
            return self 
        else :
            return other
    def __str__(self) -> str:
        return str(self.GetName()) +" HP : " +str(self.GetHP())+" AP : " +str(self.GetAP())
        


class Paladin(Fighter, Healer):
    def __init__(self,name,attack,magic):
        # Appeler le constructeur de la classe parente Fighter
        Fighter.__init__(self,name, attack)
        # Appeler le constructeur de la classe parente Healer
        Healer.__init__(self,name, magic)
    def Allinfo(self) :
        print("the carracter is ", self.GetName()," type Paladin,", "he has ",self.GetHP(),"hp", "out of", self.GetMaxHP(),"max hp",", has", self.GetAP(), "attack power","and", self.GetMP(), "healing/magic power", "and he is at position :", self.Getpos())
    def __lt__(self, other) :
        if (self.GetAP()+self.GetMP)/2 <= (other.GetAP()+other.GetMP)/2 :
            return self 
        else :
            return other


class Gladiator(Warrior):
     # passive last stand si HP<40 +10AP
    def __init__(self,name):
        super().__init__(name,defaultgladiatorAP)
        self.ls=0
        # self.SetAP(defaultgladiatorAP)
        self.SetRange(defaultgladiatorRange)
    def Allinfo(self) :
        print("the carracter is ", self.GetName(),"is type Warior Gladiator,", "he has ",self.GetHP(),"hp", "out of", self.GetMaxHP(),"max hp",", has", self.GetAP(), "attack power", "and he is at position :", self.Getpos())
    def Attack(self,hits,player):
        if self.GetHP()<=40 and self.ls == False:
            print(self.GetName(),"is in last stand and damage is boosted")
            self.SetAP(defaultgladiatorAP+10)
            self.ls=True
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
    def Allinfo(self) :
        print("the carracter is ", self.GetName(),"is type Warior  Black Prior,", "he has ",self.GetHP(),"hp", "out of", self.GetMaxHP(),"max hp",", has", self.GetAP(), "attack power", "and he is at position :", self.Getpos())
    def Attack(self,hits,player):
        if random.randint(0,1)==0 :
            self.SetAP(defaultBlackPriorAP*2)
            self.SetHP(self.GetHP()-15)
            hits=1
            if self.GetHP()>0:
                print("player", self.GetName(),"sacrificed 15hp to deal a critical hit")
                newhp=player.GetHP() - self.GetAP()
                if (newhp<=0):
                    print(self.GetName(), "killed", player.GetName())
                    player.SetHP(0)
                else :
                    if abs(self.Getpos()-player.Getpos()) <= self.GetRange(): #if self and opponent in range of self 
                        player.SetHP(newhp)
                        print(self.GetName(),"at position", self.Getpos(),"attacks player",player.GetName(),"at position", player.Getpos(),"with", self.GetAP(), "damage and puts",player.GetName(),"to", player.GetHP(), "HP")
                    else:
                        print("player not in range ")
                    turnpass()
                self.SetAP(defaultBlackPriorAP)
            else :
                print("player", self.GetName(),"sacrificed 15hp and died trying to deal a critical hit, lol")
        else :
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

class Warden(Warrior):
    def __init__(self,name):
        super().__init__(name,defaultWardenAP)
        # self.SetAP(defaultWardenAP)
        self.SetRange(defaultWardenRange)

        self.SetMaxHP(self.GetHP() + 30)
        self.SetHP(self.GetHP() + 30) #more tanky ?
    def Allinfo(self) :
        print("the carracter is ", self.GetName(),"is type Warior Warden,", "he has ",self.GetHP(),"hp", "out of", self.GetMaxHP(),"max hp",", has", self.GetAP(), "attack power", "and he is at position :", self.Getpos())
    

    

    

class Shaman(Healer):
    def __init__(self, name):
        super().__init__(name, defaultShamanMP)
        self.SetRange(defaultShamaRange)  # takes damage while healing can heal self +20 -10
        # self.SetMP(defaultShamanMP) # Cette ligne n'est pas nécessaire car c'est déjà fait dans le constructeur de la classe parente
    def Allinfo(self) :
        print("the carracter is ", self.GetName(),"is type Healer Shaman,", "he has ",self.GetHP(),"hp", "out of",  self.GetMaxHP(),"max hp",", has", self.GetMP(), "healing/magic power", "and he is at position :", self.Getpos())
    
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
    def Allinfo(self) :
        print("the carracter is ", self.GetName(),"is type Healer Elf,", "he has ",self.GetHP(),"hp", "out of",  self.GetMaxHP(),"max hp",", has", self.GetMP(), "healing/magic power", "and he is at position :", self.Getpos())
    
    def Heal(self,castNumber,player):
        # ajouter if dist respectée 
        # ajouter random dist after heal 
        # stun si trop greedy et heal 3 fois dans le vide ? sinon perte de MP temporaire  
        if (player.GetHP()!=0): #check if dead
            for k in range(castNumber):
                newhp = player.GetHP() + self.GetMP()  # Utilisation de GetMP() pour obtenir la valeur de l'attribut privé
                if (newhp>player.GetMaxHP()): #check if healed to full 
                    print(self.GetName(), "Healed to full", player.GetName(), "and overheals giving 5 extra max health")
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
    def Allinfo(self) :
        print("the carracter is ", self.GetName(),"is type Healer Angel,", "he has ",self.GetHP(),"hp", "out of",  self.GetMaxHP(),"max hp",", has", self.GetMP(), "healing/magic power", "and he is at position :", self.Getpos())
    # def Heal(self,castNumber,player):
    #     if (player.GetHP()==0):
    #         print("it's a miracle !!!",self.GetName()," is reviving", player.GetName(), " !!!!!!")
    #     for k in range(castNumber):
    #         newhp = player.GetHP() + self.GetMP()  # Utilisation de GetMP() pour obtenir la valeur de l'attribut privé
    #         if (newhp>player.GetMaxHP()): #check if healed to full 
    #             print(self.GetName(), "Healed to full", player.GetName())
    #             player.SetHP(player.GetMaxHP())
    #         else :
    #             if abs(self.Getpos()-player.Getpos()) <= self.GetRange():  #if self and opponent in range of self
    #                 player.SetHP(newhp)
    #                 print(self.GetName(),"at position", self.Getpos(), "heals player", player.GetName(),"at position", player.Getpos(), "of", self.GetMP(), "health back up to", player.GetHP(), "HP")
    #             else:
    #                 print("player not in range")
    #         turnpass()

class Executor(Paladin):
    def __init__(self, name):
        super().__init__(name,defaultExecutorAP,defaultExecutorMP)
        self.SetRange(defaultExecutorRange)
    #paladin Executor execute : si a la fin de sa derniere attaque joueur.__HP<15 ->execute +  gagne 30HP low attack long range spam type 
    def Allinfo(self) :
        print("the carracter is ", self.GetName()," type Paladin Executor,", "he has ",self.GetHP(),"hp", "out of", self.GetMaxHP(),"max hp",", has", self.GetAP(), "attack power","and", self.GetMP(), "healing/magic power", "and he is at position :", self.Getpos())

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
    def Allinfo(self) :
        print("the carracter is ", self.GetName()," type Paladin Gambler,", "he has ",self.GetHP(),"hp", "out of", self.GetMaxHP(),"max hp",", has", self.GetAP(), "attack power","and", self.GetMP(), "healing/magic power", "and he is at position :", self.Getpos())

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
    def Allinfo(self) :
        print("the carracter is ", self.GetName()," type Paladin Exorcist,", "he has ",self.GetHP(),"hp", "out of", self.GetMaxHP(),"max hp",", has", self.GetAP(), "attack power","and", self.GetMP(), "healing/magic power", "and he is at position :", self.Getpos())



class Team :
    def __init__(self,teamName,Fighters=[],Healers=[]):
        self.TeamName = teamName
        self.Fighters = Fighters
        self.Healers = Healers
        self.Healers.sort()
        self.Fighters.sort()
        if (self.Fighters==[]) :
            Att_1=Gladiator("Gladiator "+str(teamName))
            Att_2=BlackPrior("Blackprior "+str(teamName))
            Att_3=Warden("Warden "+str(teamName))
            self.Fighters=[Att_2,Att_1,Att_3]
        if (self.Healers==[]) :
            Heal_1=Shaman("Shaman "+str(teamName))
            Heal_2=Angel("Angel "+str(teamName))
            Heal_3=Elf("Elf "+str(teamName))
            self.Healers=[Heal_3,Heal_1,Heal_2]
        # self.Healers.sort()
        # self.Fighters.sort()
    def __str__(self) -> str:

        fight = []
        for f in self.Fighters :
            fight.append(f.__str__())
        
        heal = []
        for h in self.Healers :
            heal.append(h.__str__())
        
        
        max_length = max(len(f) for f in fight + heal)

        result_string = 'Fighters :              Healers :\n\n'
        for f, h in zip(fight, heal):
           
            formatted_f = f'{f:<{max_length}}' 
            formatted_h = f'{h:<{max_length}}' 
            result_string += f'{formatted_f}\t{formatted_h}\n' 

        return "\n"+str(self.TeamName) +": \n" + result_string
    def attack(self,n,i,j,otherTeam) :
        try :
            self.Fighters[i].Attack(n, otherTeam.Fighters[j])
        except InvalidAttackError as e:

            print(e) 
    def heal(self, n, j):
        try:
            if self.Fighters[j].GetHP() == 0:
                self.Fighters.remove(self.Fighters[j])
                print("Cannot heal dead player, removing the Fighter from the team....")
            else:
                k = random.randint(0, len(self.Healers) - 1)
                self.Healers[k].Heal(n, self.Fighters[j])

        except InvalidHealTargetError as e:
            print(e)

        except IndexError:
            print(f"Invalid index '{j}' for healer.")

        except Exception as e:
            print(f"An unexpected error occurred: {e}")


class Application(tk.Tk):
    def __init__(self, Team1=Team("Team1"), Team2=Team("Team2")):
        tk.Tk.__init__(self)
        self.title("Game Interface")
        self.geometry('800x400')
        self.configure(bg='lightblue')
        self.grid_rowconfigure(0, weight=2)
        self.grid_columnconfigure(0, weight=1)
        self.grid_columnconfigure(5, weight=1)
        self.Team1=Team1
        self.Team2=Team2
        self.create_widgets()
        self.gamerules()
        

        

    def create_widgets(self):
        # création widgets et positionnement des widgets
        frame1 = tk.Frame(self, bg='lightblue', bd=2, relief=tk.SUNKEN)
        frame2 = tk.Frame(self, bg='lightblue', bd=2, relief=tk.SUNKEN)
        frame1.grid(row=0, column=0, padx=10, pady=10, sticky='nsew')
        frame2.grid(row=0, column=5, padx=10, pady=10, sticky='nsew')
        
        self.listbox1 = tk.Listbox(frame1, bg='white', font=('Courier', 12), fg='black',exportselection = False,selectmode=tk.MULTIPLE)
        self.listbox1.bind('<<ListboxSelect>>', self.printchar1)
        
        self.listbox2 = tk.Listbox(frame2, bg='white', font=('Courier', 12), fg='black',exportselection = False,selectmode=tk.MULTIPLE)
        self.listbox2.bind('<<ListboxSelect>>', self.printchar2)

        self.listbox1.pack(expand=True, fill=tk.BOTH, padx=10, pady=10)
        self.listbox2.pack(expand=True, fill=tk.BOTH, padx=10, pady=10)
        
        self.text1 = tk.Text(self, height=4, width=100, bg='white', font=('Courier', 12), fg='black')
        self.text2 = tk.Text(self, height=4, width=100, bg='white', font=('Courier', 12), fg='black')
        self.text1.grid(row=1, column=0, padx=10, pady=10)
        self.text2.grid(row=1, column=5, padx=10, pady=10)

    
        # Create buttons
        self.button1 = tk.Button(self, text="Left Attacks Right", fg='blue', bg='white', font=('Courier', 12, 'bold'), command=self.AttackLeftToRight)
        self.button2 = tk.Button(self, text="Heal", fg='green', bg='white', font=('Courier', 12, 'bold'), command=self.Heal)
        self.button3 = tk.Button(self, text="Quit Game", fg='red', bg='white', font=('Courier', 12, 'bold'), command=self.quit)
        self.button4 = tk.Button(self, text="Right Attacks Left", fg='blue', bg='white', font=('Courier', 12, 'bold'), command=self.AttackRightToLeft)

        # Arrange buttons in the grid
        self.button1.grid(row=0, column=1, sticky=tk.E, padx=10, pady=10)
        self.button2.grid(row=1, column=1, sticky=tk.E, padx=10, pady=10)  # Moved to row 1, underneath button 1
        self.button4.grid(row=0, column=4, sticky=tk.W, padx=10, pady=10)
        self.button3.grid(row=1, column=4, sticky=tk.W, padx=10, pady=10)  # Moved to row 1, for symmetry

        for p in (self.Team1.Fighters+self.Team1.Healers):
            self.listbox1.insert(tk.END, p.GetName())

        for p in (self.Team2.Fighters+self.Team2.Healers):
            self.listbox2.insert(tk.END, p.GetName())

    def gamerules(self):
        rules = (
            "-the top 3 characters in each teams are Fighters and the bottom 3 are Healers\n-you can only attack one character at a time \n-if the attack does not deal any damage check terminal it is out of range\n-when Two healers are selected to heal each other the TOP one will heal the BOTTOM one\n-if you have selected multiple caracters the carracteristics printed will be the ones of the TOP one "
        )
        messagebox.showinfo("Game rules", rules)

    def printchar1(self, event):
        selection = self.listbox1.curselection()
        if selection:
            i= selection[0]
            player = (self.Team1.Fighters+self.Team1.Healers)[i]
            self.text1.delete(1.0, tk.END)
            self.text1.insert(tk.END, player)
            

    def printchar2(self,event):
        selection = self.listbox2.curselection()
        if selection:
            i= selection[0]
            player = (self.Team2.Fighters+self.Team2.Healers)[i]
            self.text2.delete(1.0, tk.END)
            self.text2.insert(tk.END, player)

    def AttackLeftToRight(self):
        try:
            selection1 = self.listbox1.curselection()
            selection2 = self.listbox2.curselection()
            if len(selection1)>1 or len(selection2)>1 :
                raise Exception(" You can only use one Fighter to attack one character")
            if selection1 and selection2:
                i1 = selection1[0]
                i2 = selection2[0]
                char1 = (self.Team1.Fighters+self.Team1.Healers)[i1]
                char2 = (self.Team2.Fighters+self.Team2.Healers)[i2]
                char1.Attack(1,char2)
                if char2.GetHP() <= 0:
                    print(f"[!] {char2.GetName()} is dead.")
                    self.listbox2.delete(i2)
                    (self.Team2.Fighters+self.Team2.Healers).remove(char2)
                    if char2 in self.Team2.Healers and char2 in self.Team2.Fighters:
                        self.Team2.Healers.remove(char2)
                        self.Team2.Fighters.remove(char2)
                    elif char2 in self.Team2.Fighters:
                        self.Team2.Fighters.remove(char2)
                    else:
                        self.Team2.Healers.remove(char2)
                if len(self.Team2.Fighters)==0 :
                    messagebox.showinfo("Game rules", "Game Over Team 1 Won !!!!")
                    self.quit()
                if char1.GetHP() <= 0:
                    print(f"[!] {char1.GetName()} is dead.")
                    self.listbox1.delete(i1)
                    (self.Team1.Fighters+self.Team1.Healers).remove(char1)
                    if char1 in self.Team1.Healers and char1 in self.Team1.Fighters:
                        self.Team1.Healers.remove(char1)
                        self.Team1.Fighters.remove(char1)
                    elif char1 in self.Team1.Fighters:
                        self.Team1.Fighters.remove(char1)
                    else:
                        self.Team1.Healers.remove(char1)
                if len(self.Team1.Fighters)==0 :
                    messagebox.showinfo("Game rules", "Game Over Team 2 Won !!!")
                    self.quit()
            else:
                raise Exception("[!] Please choose one character in both teams.")


        except Exception as e:
            messagebox.showinfo("Error", str(e))
        finally: 
            self.printchar1(None)
            self.printchar2(None)
              

    def AttackRightToLeft(self):
        try:
            selection1 = self.listbox1.curselection()
            selection2 = self.listbox2.curselection()
            if len(selection1)>1 or len(selection2)>1 :
                raise Exception(" You can only use one character to attack 1 character")
            if selection1 and selection2:
                i1 = selection1[0]
                i2 = selection2[0]
                char1 = (self.Team1.Fighters+self.Team1.Healers)[i1]
                char2 = (self.Team2.Fighters+self.Team2.Healers)[i2]
                char2.Attack(1,char1)
                if char1.GetHP() <= 0:
                    print(f"[!] {char1.GetName()} is dead.")
                    self.listbox1.delete(i1)
                    (self.Team1.Fighters+self.Team1.Healers).remove(char1)
                    if char1 in self.Team1.Healers and char1 in self.Team1.Fighters:
                        self.Team1.Healers.remove(char1)
                        self.Team1.Fighters.remove(char1)
                    elif char1 in self.Team1.Fighters:
                        self.Team1.Fighters.remove(char1)
                    else:
                        self.Team1.Healers.remove(char1)
                if len(self.Team1.Fighters)==0 :
                    messagebox.showinfo("Game rules", "Game Over Team 2 Won !!!")
                    self.quit()
                if char2.GetHP() <= 0:
                    print(f"[!] {char2.GetName()} is dead.")
                    self.listbox2.delete(i2)
                    (self.Team2.Fighters+self.Team2.Healers).remove(char2)
                    if char2 in self.Team2.Healers and char2 in self.Team2.Fighters:
                        self.Team2.Healers.remove(char2)
                        self.Team2.Fighters.remove(char2)
                    elif char2 in self.Team2.Fighters:
                        self.Team2.Fighters.remove(char2)
                    else:
                        self.Team2.Healers.remove(char2)
                if len(self.Team2.Fighters)==0 :
                    messagebox.showinfo("Game rules", "Game Over Team 1 Won !!!!")
                    self.quit()
            else:
                raise Exception("[!] Please choose obne character in both teams.")


        except Exception as e:
            messagebox.showinfo("Error", str(e))
        finally: 
            self.printchar1(None)
            self.printchar2(None)
            

    def Heal(self):
        try:
            select2 = self.listbox2.curselection()
            select1 = self.listbox1.curselection()
            if len(select2) == 2:
                indice1 = select2[0]
                indice2 = select2[1]
                perso1 = (self.Team2.Fighters+self.Team2.Healers)[indice1]
                perso2 = (self.Team2.Fighters+self.Team2.Healers)[indice2]
                if (perso1 in self.Team2.Fighters and not (perso1 in self.Team2.Healers)):
                    perso2.Heal(1,perso1)
                elif (perso2 in self.Team2.Fighters and not (perso2 in self.Team2.Healers)):     
                    perso1.Heal(1,perso2)
                else:
                    perso1.Heal(1,perso2)
            elif len(select2) > 2:
                raise Exception("[!] Heal is between 2 characters.")   
            else :
                if len(select1) == 2:
                    indice1 = select1[0]
                    indice2 = select1[1]
                    perso1 = (self.Team1.Fighters+self.Team1.Healers)[indice1]
                    perso2 = (self.Team1.Fighters+self.Team1.Healers)[indice2]
                    if (perso1 in self.Team1.Fighters and not (perso1 in self.Team1.Healers)):
                        perso2.Heal(1,perso1)
                    elif (perso2 in self.Team1.Fighters and not (perso2 in self.Team1.Healers)):     
                        perso1.Heal(1,perso2)
                    else:
                            perso1.Heal(1,perso2)
                elif len(select2) > 2:
                    raise Exception("[!] Heal is between 2 characters.")   
                else :
                    raise Exception("[!] Please choose 2 characters in either one of the teams.")
        except Exception as e:
            messagebox.showinfo("Error",str(e))
        finally:
            self.printchar1(None)
            self.printchar2(None)
            self.listbox1.selection_clear(0, tk.END)
            self.listbox2.selection_clear(0, tk.END)


if __name__ == "__main__":

    app = Application()
    app.title("Game")
    app.mainloop()

    # app = MaListBox()
    # app.title("MaListBox")
    # app.mainloop()

    # Att_A1=BlackPrior("Fighter1 teamA")
    # Att_A2=BlackPrior("Fighter2 teamA")
    # Att_A3=Warden("Fighter3 teamA")
   
    # Att_B1=Gladiator("Fighter1 teamB")
    # Att_B2=Gladiator("Fighter2 teamB")
    # Att_B3=Warden("Fighter3 teamB")
    

    # Heal_A1=Shaman("Healer1 teamA")
    # Heal_A2=Angel("Healer2 teamA")
    # Heal_A3=Elf("Healer3 teamA")

    # Heal_B1=Elf("Healer1 teamB")
    # Heal_B2=Angel("Healer2 teamB")
    # Heal_B3=Elf("Healer3 teamB")

    # Att_A=[Att_A1,Att_A2,Att_A3]
    # Heal_A=[Heal_A1,Heal_A2,Heal_A3]
    # # print(Att_A[0])
    # TeamA = Team("TeamA",Att_A,Heal_A)
    # # TeamA = Team("TeamA",[],[])
    # # print(Att_A[0])
    # Att_B=[Att_B1,Att_B2,Att_B3]
    # Heal_B=[Heal_B1,Heal_B2,Heal_B3]

    # TeamB =Team("TeamB",Att_B,Heal_B)
    # # TeamB =Team("TeamB",[],[])


    # # test1= Warrior("test1",10)
    # # test2= Warrior("test2",20)
    # # test3 =Warrior('test3',30)
    # # a=[test1,test2,test3]
    # # print(a[0])
    # # teamtest=Team("test",a)
    # # print(a[0])
    # # print(teamtest)


    # print("The war will start between the two sides .....")
    # print(TeamA)
    # print("And.....")
    # print(TeamB)

       

    # while TeamA.Fighters and TeamB.Fighters and input("Press enter to start turn\n") == "":
    #     n = random.randint(1, 3)
    #     i = random.randint(0, len(TeamA.Fighters) - 1)
    #     j = random.randint(0, len(TeamB.Fighters) - 1)

    #     try:
    #         TeamA.attack(n, i, j, TeamB)
    #         TeamB.heal(n, j)

    #         if TeamB.Fighters:
    #             while i not in [0, len(TeamB.Fighters) - 1]:
    #                 i = i - 1
    #             j = random.randint(0, len(TeamA.Fighters) - 1)
    #             TeamB.attack(n, i, j, TeamA)
    #             TeamA.heal(n, j)

    #     except InvalidAttackError as e:
    #         print(e)  # Print the error message raised by InvalidAttackError

    #     except Exception as e:
    #         print(f"An unexpected error occurred: {e}")

    #     print(TeamA)
    #     print(TeamB)

    # print("\n\n\nThe war is over and we have a winner....\n")
    # if TeamA.Fighters :
    #     print(TeamA.TeamName,"won the war against",TeamB.TeamName,"with",len(TeamA.Fighters), "Fighters left in the battle !!!!!!!!\n\n\n")
    # else :
    #     print(TeamB.TeamName,"won the war against",TeamA.TeamName,"with",len(TeamB.Fighters), "Fighters left in the battle !!!!!!!!\n\n\n")


    










       
    # print(len(Att_A),len(Att_B))

    # print(defaultgladiatorAP)
    #Ali=Exorcist("Ali",10,10,5)
    # gab=Fighter("Gabriel",10)
    # gab.Allinfo()

    # nessa=BlackPrior("Inessa")
    # moi=Angel("Natao")
    # # nessa.Attack(5,gab)
    # # moi.Heal(12,gab)
    # gamb=Gambler("gambler")
    # gamb.Attack(3,moi)
    # exe=Executor("executor")
    # exe.Attack(10,gamb)
    # exo=Exorcist("exorcist")
    # exo.Attack(3,gab)
    # exo.Heal(8,gab)
    # Ali=Elf("Ali")
    # Ali.Heal(10,moi)
    # Ali.GetHP()
    # printallchar()

# if isinstance(self,Paladin):
#             print("hello")

