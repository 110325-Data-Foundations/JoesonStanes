print("Hello plano")
#this is a comment 
x="hello"
print(type(x))

#data types in python

#integer
my_int=10
my_float=34.89

#string
my_string="Hello plano!"

#boolena

my_bool=True
my_bool2=False

#none tells the user that ht number typed is null

my_none=None  

print(my_none)


#using arithmetic operations using variable type
a=20
b=323.988
sum=print(a+b)

#string concatenation

first="hello"
second="plano"
sum=print(first+""+second)

#operators

# + - * / % // **

#console inout and output
#output to the console is easy in pyton bcz there si an input erm called inoput 

print("Here is my console op")
my_inout = input("Enter your name: ")
print(f"Hello {my_inout}")

#truthy vs falsy values
#truthy values are values that evalute to true in a boolean context

#falsy 
#null
#0,0.00,0j

#Truthy values - Everything else

#casting - type conversion

num1=2
num2=30.877
print(num1+num2)


mytotal="My total is "+ str(num1)
print(mytotal)

#collections - python has a few built in collection types for storing different values
#this include list disctionaries range tuples range etc

#list- mutable ,allows duplicates indexible
#coiunts from zeromylist
mylist=[1,3,5,22]
mylist.append(50)
print(mylist)
mylist.insert(2,"hello")
print(mylist)
mylist.remove(3)
print(mylist)
mylist.pop(2)
print(mylist)
mylist.append(22)
print(mylist)
mylist.insert(0,100)
print(mylist)

print(mylist)

#SETS
MYSET={1,2,3,4,5,5,5}
print(MYSET)
MYSET.add(10)
print(MYSET)  
print(MYSET.pop())

#Tuples 
this_is_my_tuple=(1,2,6,3,4,5)
print(this_is_my_tuple.count(1))

print(this_is_my_tuple.index(3))

#dictionary

my_dictionary={
    "name":"John",
    "age":30,
    "city":"New York"
    }
my_dictionary["name"]=30
print(my_dictionary)
