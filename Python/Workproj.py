print("********* AI Menu Placer Bot *********")

# Menu list
food_list = [
    ["1.Pizza", 8.99],
    ["2.Burger", 5.89],
    ["3.Pasta", 2.36],
    ["4.Salad", 6.33],
    ["5.Sushi", 8.99]
]

# Dictionary to store orders
orders = {}

while True:
    print("Choose option:\n1. Place Menu Order\n2. View Menu\n3. View My Orders\n4. Exit")
    choose_option = input("Please enter the number corresponding to your choice: ").strip()

    if choose_option == '1':
        print("\n\t\t\t\t\tMenu:\n")
        for item in food_list:
            print(f"\t\t\t\t{item[0]}   -   ${item[1]}")
        print("\n")

        while True:
            choice = input("Enter your choice (1-5) or X to stop ordering: ")

            if choice == "X":
                print("Finished ordering.\n")
                break

            elif choice in ['1', '2', '3', '4', '5']:
                index = int(choice) - 1
                food_name = food_list[index][0][2:]  # remove the "1." prefix
                food_price = food_list[index][1]

                # Save to dictionary
                if food_name in orders:
                    orders[food_name] += food_price  # Add again if already ordered
                else:
                    orders[food_name] = food_price

                print(f"Added {food_name} (${food_price}) to your order.\n")

            else:
                print("Oh oh! Invalid choice. Please try again.\n")
#Showing the menu
    elif choose_option == '2':
        print("\nMenu:")
        for item in food_list:

            print(f"{item[0]}   -   ${item[1]}")
        print("\n")
#Looking at the orders
    elif choose_option == '3':
        if not orders:
            print("\nNo items ordered yet.\n")
        else:
            print("\nYour Orders Summary:")
            total = 0
            for food, price in orders.items():
                print(f"- {food}: ${price:.2f}")
                total += price
            print(f"Total Amount: ${total:.2f}\n")

    elif choose_option == '4':
        print("Exiting the program. Thank you!")
        break

   
    
