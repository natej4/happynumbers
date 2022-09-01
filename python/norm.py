def happy(n):
    past = set()			
    while n != 1:
        n = sum(int(i)**2 for i in str(n))
        if n in past:
            return False
        past.add(n)
    return True

def findNorms(list):
    dictionary = {}
    
    for num in list:
        norm = 0.0
        result = 0.0
        past = set()
        i = num
        while i != 1:
            i = sum(int(j)**2 for j in str(i))
            if i not in past:
                past.add(i)
        while i > 0:
            lastdigit = i % 10
            result += lastdigit*lastdigit
            i/=10
            past.add(result)
        for k in past:
            k = k*k
            norm += k
        dictionary[num] = norm
    sortedDict = dict(sorted(dictionary.items(), key=lambda item:item[1], 
    reverse=True))
    return sortedDict

def norm(n):
    norm = 0.0
    past = set()
    result = 0
    i = n
    # while i > 0:
    #     lastdigit = i % 10
    #     result += lastdigit*lastdigit
    #     i /= 10
    #     past.add(result)
    while i != 1:
        if i not in past:
            past.add(i)
        i = sum(int(j)**2 for j in str(i))
            
    for k in past:
        k = k*k
        norm += k
    print(past)
    return norm

print(norm(19))

print(19**2 + 82)
