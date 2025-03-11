from functools import reduce

def composeLines(indent,pts):
    res=""
    for pt in pts:
        res+=indent+str(pt)+"\n"
    return res

def mapL(f,a):
    return list(map(f,a))

def dict_to_func(d):
    return lambda x : d[x]

inner_reduce = lambda op,l : reduce(op,l[1:],l[0])

str_comb = lambda comb : lambda x,y : str(x)+comb+str(y)
