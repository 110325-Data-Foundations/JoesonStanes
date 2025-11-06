#Erros vs Exception



#Error
#

num=input("Enter a number: ")
print((num))


#Exception handling

try:
    num=int(input("Enter a number: "))
    a=12/num
    print(a)
except ValueError:
    print("Invalid input")
except ZeroDivisionError:
    print("Cannot divide by zero")


class MyException(Exception):
    def __init__(self, message="Time to lock in buddy"):
        self.message = message

try:
    print("Please enter an integer")
    num = int(input())
    if not isinstance(num, int):
        raise MyException()
    print(f"You entered {num}")
except:
    print("Invalid input - not an integer")



#i can have any amouth of exception block as i need and just confirm with the number of exceptions i get with exception i get
