
# Asks the user for two positive integers 
# and returns the 10 happy numbers between them 
# with the greatest norms, sorted descending by the norms

# by Nate Jackson for CSC330

def fillArray(x, y):
    if x > y:
        n=x
        x=y
        y=n
    nums = []
    nums.extend(range(x,y))
    return nums

def isNotHappy(n):
    past = set()			
    while n != 1:
        n = sum(int(i)**2 for i in str(n))
        if n in past:
            return True
        past.add(n)
    return False

def filterList(list):
    # filtered = []
    for num in list:
        if isNotHappy(num):
            list.pop(list.index(num))
    return list



x = int(input("First argument: "))
y = int(input("Second argument: "))

if x == y:
    print("NOBODYS HAPPY")
    exit()
# nums = fillArray(x, y)
print(filterList(fillArray(x, y)))

