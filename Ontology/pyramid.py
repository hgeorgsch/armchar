import numpy as np

def line(x):  
     s = score(x) 
     a = score(x/5) 
     return (x, s, x-gauss(s), a, x-5*gauss(a))

def score(x): return int(np.floor((np.sqrt(1+8*x)-1)/2))               

def gauss(x): return int(x*(x+1)/2)                                    

n = 1400

print(":xpTable a owl:Class ; :isTable") 

for x in range(n+1): 
    print( "[ :xp %i ; :artScore %i ; :artRemainder %i ; :abScore %i ; :abRemainder %i  ]" % line(x) )

print ( ") ." )
