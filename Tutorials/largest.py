n=input("Enter the size of the list ")
list1=[]
for i in range(0,int(n)):
    element=input("Enter the element ")
    list1.append(int(element))
for i in list1:
    largest=list1[0]
    if list[i]>largest:
        largest=list[i]
print(f"The largest element in the list is {largest}")