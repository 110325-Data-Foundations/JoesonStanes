n=input("Enter you weight ")
weight=input("Is this in (L)bs or (K)gs ")
if weight.upper()=="L":
    weightkg=float(n)*0.45
    print(f"You are {weightkg} kgs")

