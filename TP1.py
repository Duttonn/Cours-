import random

defaultgladiatorAP=20
defaultBlackPriorAP=30
defaultWardenAP=15
defaultShamanMP=20
defaultElfMP=30
defaultShaolinMP=15





class Character :
    def __init__(self,name):
        self.__name=name
        self.__HP=80+random.randint(-30, 20)
        # self.toutes_classes=["guerrier","soigneurs","paladins"]
        # self.classe=self.toutes_classes[classe]
    def GetHP(self):
        return self.__HP
    def SetHP(self,newHP):
        self.__HP=newHP
    def GetName(self):
        return self.__name
    def SetName(self,newName):
        self.__name=newName

class Paladin(Character):

    def __init__(self,name):
        super().__init__(name)
     

class Warrior(Character):

    def __init__(self,name,attack=25):
        super().__init__(name)
        self.__AP=attack
    def GetAP(self):
        return self.__AP
    def SetAP(self,newAP):
        self.__AP=newAP
    def Attack(self,hits,player):
        for k in range(hits):
            newhp=player.GetHP()-self.GetAP()
            player.SetHP(newhp)
            print(self.GetName()," attacks player ",player.GetName()," with ", self.GetAP(), "damage and puts him to ", player.GetHP(), " HP") 


class gladiator(Warrior):

    def __init__(self,name):
        super().__init__(name,defaultgladiatorAP)
        # self.SetAP(defaultgladiatorAP)

class BlackPrior(Warrior):
    def __init__(self,name):
        super().__init__(name,defaultBlackPriorAP)
        self.SetHP(self.GetHP() - 10)

class Warden(Warrior):
    def __init__(self,name):
        super().__init__(name,defaultWardenAP)
        # self.SetAP(defaultWardenAP)
        self.SetHP(self.GetHP + 30) #more tanky ?

    




class Mage(Character):
    def __init__(self,name,magic):
        super().__init__(name)
        self.__MP=magic
    def GetMP(self):
        return self.__MP
    def SetMP(self,newMP):
        self.__MP=newMP
    def Heal(self,castNumber,player):
        for k in range(castNumber):
            newhp = player.GetHP() + self.GetMP()  # Utilisation de GetMP() pour obtenir la valeur de l'attribut privé
            player.SetHP(newhp)
            print(self.GetName(), "heals player", player.GetName(), "of", self.GetMP(), "health back up to", player.GetHP(), "HP")

class Shaman(Mage):
    def __init__(self, name):
        super().__init__(name, defaultShamanMP)
        # self.SetMP(defaultShamanMP) # Cette ligne n'est pas nécessaire car c'est déjà fait dans le constructeur de la classe parente

class Elf(Mage):
    def __init__(self, name):
        super().__init__(name, defaultElfMP)
        self.SetHP(self.GetHP() - 10)

class Shaolin(Mage):
    def __init__(self, name):
        super().__init__(name, defaultShaolinMP)
        self.SetHP(self.GetHP() + 20)

if __name__ == "__main__":
    print(defaultgladiatorAP)
    me=Shaolin("Natao")
    print(vars(me))
