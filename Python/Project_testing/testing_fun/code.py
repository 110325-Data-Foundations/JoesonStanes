# Program to convert temperature between Celsius and Fahrenheit

def celsius_to_fahrenheit(c):
    """Convert Celsius to Fahrenheit."""
    return (c * 9/5) + 32

def fahrenheit_to_celsius(f):
    """Convert Fahrenheit to Celsius."""
    return (f - 32) * 5/9

def main():
    print("🌡️ Temperature Converter 🌡️")
    print("1. Celsius to Fahrenheit")
    print("2. Fahrenheit to Celsius")

    choice = input("Choose an option (1 or 2): ")

    if choice == "1":
        c = float(input("Enter temperature in Celsius: "))
        f = celsius_to_fahrenheit(c)
        print(f"{c}°C is equal to {f:.2f}°F")
    elif choice == "2":
        f = float(input("Enter temperature in Fahrenheit: "))
        c = fahrenheit_to_celsius(f)
        print(f"{f}°F is equal to {c:.2f}°C")
    else:
        print("Invalid choice. Please choose 1 or 2.")

if __name__ == "__main__":
    main()
