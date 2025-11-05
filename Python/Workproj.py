print("*********AI Menu Placer Bot*********")

food_list = [["1.Pizza",8.99], ["2.Burger",5.89], ["3.Pasta",2.36], ["4.Salad",6.33], ["5.Sushi",8.99]]
food_prices = [8.99, 5.49, 7.99, 4.99, 12.99]
while True:
 print("Choose option:\n1. Place Menu Order\n2. View Menu\n3. Exit")
 choose_option = input("Please enter the number corresponding to your choice: ")
 
 

 


 if choose_option == '1':
    print("\n\t\t\t\t\tMenu:\n")
    for i in food_list:
        print(f"\t\t\t\t{i[0]}   -   ${i[1]}")
    print("\n")
    choice=input("Enter your choice")
    if choice == '1':
        print("You have ordered Pizza. Your total is $8.99")
    elif choice == '2':
        print("You have ordered Burger. Your total is $5.89")
    elif choice == '3':
        print("You have ordered Pasta. Your total is $2.36")
    elif choice == '4':
        print("You have ordered Salad. Your total is $6.33")
    elif choice == '5':
        print("You have ordered Sushi. Your total is $8.99")
    else:
        print("Oh oh ! Invalid choice. Please try again.")
 print("You can only place one order at a time.")
 print("\n")


    



 if choose_option == '2':
    print("\nMenu:")
    for i in food_list:
        print(f"{i[0]}   -   ${i[1]}")
    print("\n")

 if choose_option == '3':
    print("Exiting the program. Thank you!")
    exit()

