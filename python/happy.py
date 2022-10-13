from math import sqrt
# Asks the user for two positive integers 
# and returns the 10 happy numbers between them 
# with the greatest norms, sorted descending by the norms

# by Nate Jackson for CSC330

#fills a list with the numbers between the given numbers
def fillArray(x, y):
    if x > y:
        n=x
        x=y
        y=n
    nums = []
    nums.extend(range(x,y))
    return nums

#returns true if a given number is "happy"
def happy(n):
    past = set()			
    while n != 1:
        n = sum(int(i)**2 for i in str(n))
        if n in past:
            return False
        past.add(n)
    return True

#returns a list with only the happy numbers
def filterList(list):
    filtered = []
    for num in list:
        if happy(num):
            filtered.append(num)
    return filtered

#finds the norm for each happy number and returns a dictionary containing both,
#sorted by the norm, descending
def findNorms(list):
    dictionary = {}
    
    for num in list:
        norm = 0.0
        result = 0.0
        past = set()
        i = num
        while i != 1:
            if i not in past:
                past.add(i)
            i = sum(int(j)**2 for j in str(i))
        
        for k in past:
            k = k*k
            norm += k
        dictionary[num] = sqrt(norm)
    sortedDict = dict(sorted(dictionary.items(), key=lambda item:item[1], 
    reverse=True))
    return sortedDict

# Main
x = int(input("First argument: "))
y = int(input("Second argument: "))
if x == y:
    print("NOBODYS HAPPY")
    exit()

nums = filterList(fillArray(x, y))
if len(nums) == 0:
    print("NOBODYS HAPPY")
    exit()
dict = findNorms(nums)
output = dict.keys()

count = 0
for item in output:
    if count < 10:
        print(item)
        count +=1

