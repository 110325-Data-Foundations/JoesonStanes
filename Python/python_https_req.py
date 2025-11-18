import requests
print("Enter a name of a pokemon to find:")
a=input()
found= requests.get(f'https://pokeapi.co/api/v2/pokemon/{a}')

print(found.json())


