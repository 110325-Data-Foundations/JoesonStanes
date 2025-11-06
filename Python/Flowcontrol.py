#Flow controls in Python

#for
#while
#do-while
#if-else
#switch
#try-except


#For loops 

loop_items =["pancakes","waffles","eggs","bacon","juice"]
for item in loop_items:
    print(item + "+1")

#while
count=0
while count < 10:
    print(count)
    count += 1

#if we need to we can nest loopps to match them 
for i in range(1):
    for j in range(3):
        print(f"i={i}, j={j}")

        #if else

count=10
for i in range(10):
    count -=1
    if count==5:
        print(i)

#Match case
#switch
print("Enter a selection: 1,2,3,4,5")
selection=input()
match selection:
    case "1":
        print("You selected 1")
    case "2":
        print("You selected 2")
    case "3":
        print("You selected 3")
    case "4":
        print("You selected 4")
    case "5":
        print("You selected 5")
    case _:
        print("Invalid selection")