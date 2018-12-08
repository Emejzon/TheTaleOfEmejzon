# The Tale of Emejzon (text-based adventure game)
# by Jan Chudy
# Python 'wrapper' for better user experience
# pyswip by Yuce Tekol "yuce": https://github.com/yuce/pyswip

import os
import pyswip

# create Prolog instance and consult the game file
prolog = pyswip.Prolog()
prolog.consult("AdventureGame.pl")

def start_game():
    '''
    Function clears the console and starts the prolog game sequence.
    '''
    os.system('cls' if os.name=='nt' else 'clear')
    null = list(prolog.query("start"))
    print()     

def save_game():
    '''
    Function queries all instructions that determine the state of the game and saves them to 'Saves/Save.py'.
    '''
    stats1 = ["playerPos","playerHealth", "isAlive", "used", "described", "isOpen", "teleportPos"]
    stats2 = ["itemPos", "eventCount"]
    with open('Saves/Save.pl', 'w') as s:
        s.write(":- dynamic playerPos/1, itemPos/2, playerHealth/1, isAlive/1, used/1, described/1, isOpen/1, eventCount/2, teleportPos/1.\n\
:- retractall(playerPos(_)), retractall(itemPos(_, _)), retractall(playerHealth(_)), retractall(isAlive(_)), retractall(used(_)),\n\
\tretractall(described(_)), retractall(isOpen(_)), retractall(eventCount(_, _)), retractall(teleportPos(_)).\n")
            
        for stat in stats1:
            l = list(prolog.query(stat+"(X)"))
            for item in l:
                s.write(stat + "(" + str(item["X"]) + ").\n")

        for stat in stats2:
            l = list(prolog.query(stat+"(X,Y)"))
            for item in l:
                s.write(stat + "(" + str(item["X"]) + "," + str(item["Y"]) + ").\n")
    
    print("GAME SAVED")

def evaluate(imput: str):
    '''
    Function evaluates user's input and queries the prolog file.
    '''
    query = imput.lower().split(' ')
    print()
    try:
        if len(query) == 1:
            if "save" in query:
                save_game()
            else:
                null = list(prolog.query(query[0]))
                if len(null) == 0: null = list(prolog.query("newLine"))
        else:
            instruction = query[0] + "(" + ",".join(query[1:]) + ")"
            null = list(prolog.query(instruction))
            if len(null) == 0: null = list(prolog.query("newLine"))
    except pyswip.prolog.PrologError:
        print("Sorry, I don't understand. This is not a valid instruction.")
    print()

# ------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------

start_game()

# Game loop
while True:
    line = input('|- ')
    evaluate(line)