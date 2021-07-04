from os import replace
from sympy import *
import random
import math
import re

def generateFormula(maxNesting = 9, 
                    maxFuncs = 13, 
                    maxFormulaSize = 25, 
                    negativeThreshold = 0.9, 
                    funcsThreshold = 0.5,
                    vars = ["x", "y"]):
    
    #values this particular data will have
    nestingValue = math.floor(random.random()*maxNesting) + 1
    funcsValue = math.floor(random.random()*maxFuncs)
    sizeValue = math.floor(random.random()*maxFormulaSize) + 1


    
    funcs = [getElementaryFunctions(i+1) for i in range(nestingValue)]
    ops = getOperators()
    form = ""

    forms = [""]*nestingValue
    curExprTypes = [True]*nestingValue
    curNesting = 1
    curExprType = True

    actualNesting = 1
    actualFuncs = 0

    while(sizeValue):
        nestingSelection = math.floor(random.random() *actualNesting)
        if(curExprTypes[nestingSelection]):
            randVal = random.random()
            isNegative = True if randVal > negativeThreshold else False
            randVal2 = random.random()
            isFuncOrVar = True if randVal > funcsThreshold else False
            if(isNegative):
                forms[nestingSelection] += '-'
            if(isFuncOrVar):
                forms[nestingSelection] += funcs[nestingSelection][math.floor(random.random()*len(funcs[nestingSelection]))]
                actualFuncs += 1
                if(actualNesting - 1 == nestingSelection and actualNesting < nestingValue):
                    actualNesting += 1
            else:
                forms[nestingSelection] += getPlaceHolderVar(nestingSelection+1)
        else:
            forms[nestingSelection] += ops[math.floor(random.random()*len(ops))]
        sizeValue -= 1
        curExprTypes[nestingSelection] = not(curExprTypes[nestingSelection])

    for i in range(len(forms)):
        forms[i] = forms[i].replace('--', '+')
        forms[i] = forms[i].replace('+-', '-')
        if(forms[i] and forms[i][-1] in ops):
            forms[i] = forms[i][:-1]

    return forms#[*re.finditer("\_\_VAR[0-9]+\_\_", form)]


def getPlaceHolderVar(i):
    return '__VAR' + str(i) + '__'

def getBuildingBlocks(type):
    if(type): # non operator type
        return getElementaryFunctions()
    else: # operator type
        return getOperators()

def getOperators():
    return ['+', '-', '*', '/',]

def getElementaryFunctions(nesting = 1): # nesting -> int
    return ['log(__NEST'+str(nesting)+'__)', 'sin(__NEST'+str(nesting)+'__)', 
            'cos(__NEST'+str(nesting)+'__)', 'tan(__NEST'+str(nesting)+'__)', 
            'e^(__NEST' + str(nesting) + '__)']

def replacePlaceholderVars(formulaString, matches, vars = ["x", "y"]):
    for i in range(len(matches) -1, -1, -1):
        span = matches[i].span()
        formulaString = formulaString[:span[0]] + vars[math.floor(len(vars) * random.random())] + formulaString[span[1]:]
    return formulaString


def trimNestedForms(formsArr):
    index = len(formsArr)
    for i in range(len(formsArr)):
        if not formsArr[i]:
            index = i
            break

    return formsArr[:index]
if __name__ == "__main__":
    form = generateFormula()
    form = trimNestedForms(form)
    for i in range(len(form)):
        print(form[i])
    print("================")
    for i in range(len(form) -1, 0, -1):
        print("inserting", form[i])
        print("into : ", form[i-1])
        toReplace = '__NEST'+str(i)+'__'
        print(toReplace)
        form[i-1] = form[i-1].replace(toReplace, form[i])
    
    print("post processed formula:", form[0])
    form = form[0]
    matches = [*re.finditer("(\_\_VAR[0-9]+\_\_)|(\_\_NEST[0-9]+\_\_)", form)]
    
    form = replacePlaceholderVars(form, matches)
    print("post-post processed formula", form)

    x,y = symbols('x y')
    derivative = diff(form, y)
    print(derivative)
