print("********* AI Menu Placer Bot *********")

FOOD_LIST = [
    ["1. Margherita Pizza", 9.49],
    ["2. Spicy Chicken Burger", 7.29],
    ["3. Alfredo Pasta", 6.99],
    ["4. Caesar Salad", 5.79],
    ["5. Dragon Sushi Roll", 10.99],
    ["6. BBQ Chicken Wings", 8.49],
    ["7. Chocolate Lava Cake", 4.99],
    ["8. Mango Smoothie", 3.99],
]

def get_menu_lines(food_list=FOOD_LIST):
    """Return menu lines (pure, easy to test)."""
    return [f"{name}   -   ${price}" for name, price in food_list]

def normalize_food_name(numbered_name: str) -> str:
    """Remove the '1. ' prefix."""
    return numbered_name.split(". ", 1)[1]

def add_choice_to_orders(orders: dict, choice: str, food_list=FOOD_LIST):
    """
    Add a menu item by numeric choice (1..len(food_list)).
    Returns (ok: bool, message: str).
    """
    if not choice.isdigit():
        return False, "Oh oh! Invalid choice. Please try again."
    idx = int(choice) - 1
    if not (0 <= idx < len(food_list)):
        return False, "Oh oh! Invalid choice. Please try again."

    numbered_name, price = food_list[idx]
    food_name = normalize_food_name(numbered_name)
    orders[food_name] = orders.get(food_name, 0) + price
    return True, f"Added {food_name} (${price}) to your order."

def summarize_orders(orders: dict):
    """
    Return (lines, total) for the order summary.
    """
    lines = []
    total = 0.0
    for food, price in orders.items():
        lines.append(f"- {food}: ${price:.2f}")
        total += price
    return lines, total

def main(io_input=input, io_print=print):
    orders = {}
    while True:
        io_print("Choose option:\n1. Place Menu Order\n2. View Menu\n3. View My Orders\n4. Exit")
        choose_option = io_input("Please enter the number corresponding to your choice: ").strip()

        if choose_option == '1':
            io_print("\n\t\t\t\t\tMenu:\n")
            for line in get_menu_lines():
                io_print("\t\t\t\t" + line)
            io_print("\n")

            while True:
                choice = io_input(f"Enter your choice (1-{len(FOOD_LIST)}) or X to stop ordering: ").strip()
                if choice.upper() == "X":
                    io_print("Finished ordering.\n")
                    break
                ok, msg = add_choice_to_orders(orders, choice)
                io_print(msg + ("\n" if ok else "\n"))
        elif choose_option == '2':
            io_print("\nMenu:")
            for line in get_menu_lines():
                io_print(line)
            io_print("\n")
        elif choose_option == '3':
            if not orders:
                io_print("\nNo items ordered yet.\n")
            else:
                io_print("\nYour Orders Summary:")
                lines, total = summarize_orders(orders)
                for l in lines:
                    io_print(l)
                io_print(f"Total Amount: ${total:.2f}\n")
        elif choose_option == '4':
            io_print("Exiting the program. Thank you!")
            break
        else:
            io_print("Oh oh! Invalid choice. Please try again.\n")

if __name__ == "__main__":
    main()
