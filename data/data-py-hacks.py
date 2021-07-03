from sympy import *
import random
import math
import re

def generateFormula(maxNesting = 9, maxFuncs = 13, maxFormulaSize = 25, vars = ["x"]):

    curNesting = math.floor(random.random()*maxNesting) + 1
    curFuncs = math.floor(random.random()*maxFuncs)
    curSize = math.floor(random.random()*maxFormulaSize) + 1
    funcs = getElementaryFunctions()
    ops = getOperators()
    form = ""
    curExprType = True
    while(maxFormulaSize):
        if(curExprType):
            randVal = random.random()
            isNegative = True if randVal > 0.5 else False
            if(isNegative):
                form += '-'
            form += funcs[math.floor(random.random()*len(funcs))]
        else:
            form += ops[math.floor(random.random()*len(ops))]
        maxFormulaSize -= 1
        curExprType = not(curExprType)
    print(vars[0])
    if(len(vars) == 1):
        form = form.replace('__VAR1__', vars[0])
    form = form.replace('--', '+')
    form = form.replace('+-', '-')
    return form



def getBuildingBlocks(type):
    if(type): # non operator type
        return getElementaryFunctions()
    else: # operator type
        return getOperators()

def getOperators():
    return ['+', '-', '*', '/',]

def getElementaryFunctions(nesting = 1): # nesting -> int
    return ['log(__VAR'+str(nesting)+'__)', 'sin(__VAR'+str(nesting)+'__)', 
            'cos(__VAR'+str(nesting)+'__)', 'tan(__VAR'+str(nesting)+'__)']

if __name__ == "__main__":
    form = generateFormula()
    print(form)
    x = symbols('x')
    derivative = diff(form, x)
    print(derivative)
