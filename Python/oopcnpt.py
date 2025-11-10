# Python is an OOP language now
from abc import ABC, abstractmethod
# We can create custom classes and then generate objects based on those classes

class Dog: 
    
    # In python, we override __init__() to create our constructor
    # Notice it has the double underscore... it is a "dunder" method
    # We take in "self" - we are passing our freshly created object to our __init__
    # We take in arguments that are our classes attributes
    # And then set them inside __init__
    # I can assign a default value as well 
    def __init__(self, breed, age, color, name="default name"):
        self.breed = breed
        self.age = age
        self.color = color
        self.name = name
        
    def bark(self): # If I want to reference the objects attributes, I pass in self
        return f"{self.name} is barking"
    
    # __str__ acts as my toString() from other languages, used to create a string 
    # representation of the object
    def __str__(self):
        return f"My name is {self.name}, I am a {self.breed}."
    

ellie = Dog("Maltese", 16, "white", "Ellie")

print(ellie)
    
    
# Inheritance - If I have a class that is based on another class (An "is a" relationship) I 
# can save myself some time by using inheritance

# I pass in the parent class in parenthesis
class Doodle(Dog):
    
    # We still have to use __init__ as our constructor, but we have to pass things
    # to the parent class __init__ using... super()
    def __init__(self, breed, age, color, name="default name", is_eldritch_horror=True):
        super().__init__(breed, age, color, name) # We call the parent class __init__ using super()
        self.is_eldtrich_horror = is_eldritch_horror
        

callie = Doodle("Labradoodle", 16, "yellow", "callie")

print(callie.bark())


class Vehicle(ABC):
    @abstractmethod
    def move():
        pass
    def break_down():
        return "The vehicle is broken down."
# since we dont have an init we cant produce anm abstrat class object we have to make use of decorators
    @property
    @abstractmethod
    def vin(self):
        pass
class Car(Vehicle):
    def __init__(self,make,model,year,value):
        self.make=make
        self.model=model
        self.year=year
        self.value=value
        
        
    def move(self):
        return "The car is driving."
    def __str__(self):
        return f"{self.year} {self.make} {self.model} valued at ${self.value}"
    @property
    def vin(self):
        return "1HGCM82633A123456"
my_car=Car("Toyota","Camry",2020,24000)
print(my_car.__dict__)
      class Animal:
        def __init__(self,name,age,species,secret,super_secret):
            self.name=name
            self.age=age
            self.species=species
            self._secret=secret
            self.__super_secret=super_secret
        def __str__(self):
            return f"{self.name} is a {self.species} aged {self.age} with a secret {self.secret} and a super secret {self.super_secret}"
        def __repr__(self):
            return f"Animal(name={self.name}, age={self.age}, species={self.species}, secret={self.secret}, super_secret={self.super_secret})"

    