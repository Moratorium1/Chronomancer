/// Macros

// General
#macro CELL_SIZE 16

// LevelGen
#macro GRID_WIDTH	room_width div CELL_SIZE
#macro GRID_HEIGHT	room_height div CELL_SIZE

#macro FLOOR -5
#macro VOID -7

// Bitmasking
#macro NORTH 1
#macro WEST 2
#macro EAST 4
#macro SOUTH 8

// Gameplay
#macro STARTING_TIME 900

// Battle
#macro INCREMENT 2


#macro BATTLE_POS_X CELL_SIZE * 20
#macro BATTLE_POS_Y (GRID_HEIGHT * CELL_SIZE) - CELL_SIZE*20

#macro ENEMY_POS_X (GRID_WIDTH * CELL_SIZE) - CELL_SIZE * 4
#macro ENEMY_POS_Y BATTLE_POS_Y


#macro SUMMON_POS1_X CELL_SIZE * 10
#macro SUMMON_POS1_Y GRID_HEIGHT * CELL_SIZE - CELL_SIZE*12