# Lua-Zombie-Game
Zombie Game that uses Lua in the LOVE engine.

Control a 2D circle as it tries to survive in a top-down world filled with dangerous zombie 2D circles.

Running:

To run from source, you must download [LOVE](https://love2d.org/) and the source code. After unzipping the source code, follow the instructions in the [LOVE wiki](https://love2d.org/wiki/Getting_Started#Running_Games):

* Windows: In file explorer, drag the src folder onto love.exe in the LOVE folder (make sure .dlls that come with LOVE installation are in same folder as love.exe)
* Windows: In command prompt, enter `"[LOVE Folder Path]\love.exe" "[Lua-Zombie-Game Folder Path]\src"`
* Linux: Enter `love [Lua-Zombie-Game Folder Path]/src/`
* Mac: In Mac Terminal, enter `open -n -a love "~[Lua-Zombie-Game Folder Path]/src`

Controls:
* WASD to move
* Mouse to aim
* M1 to shoot
* 1, 2, 3, 4, 5 to switch weapons
* R to reload

Sandbox Controls (Enter Konami Code):
* F to spawn a zombie at the crosshair
* V to set player health to 9999
* B to make the zombies quiet
* C to equip the Super Gun

Notable Accomplishments (for me):
* Entity management system that manages multiple instances of a Class and automatically deletes them when a condition is met, shifting the rest of the entities in order to maintain an array structure
* Collision system that utilizes AABB and circle collision algorithms
  * Efficient system that takes advantage of the Entity Management System in order to collide all objects against each other
* No use of sprites or canvas - everything is either text or a circle

This project was developed over a duration of one week from 8/8/2020 - 8/14/2020

Credits:
* List manager: Mitch McMabers from https://stackoverflow.com/questions/12394841/safely-remove-items-from-an-array-table-while-iterating
* Gun Sounds and Zombie Crowd Sound Credits: https://www.fesliyanstudios.com
* Player Sound Credits: Half Life 2
