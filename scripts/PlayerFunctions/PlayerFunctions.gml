function grid_movement_x(argument0, argument1, argument2) {
	
	var _object		= argument0;
	var _grid		= argument1;
	var _movement	= argument2; //This value is 1 or -1
	
	//convert object x & y into a grid position
	var _x = _object.x div CELL_SIZE
	var _y = _object.y div CELL_SIZE
	
	//check value of the grid position in the direction moving
	var _gridValue = _grid[# _x+_movement, _y]
	
	//if _grid value = VOID it is a wall, and the function returns false 
	if (_gridValue == VOID) {
		return false;	
	}
	else 
	{
		return true;
	}	
}

function grid_movement_y(argument0, argument1, argument2) {
	
	var _object		= argument0;
	var _grid		= argument1;
	var _movement	= argument2; //This value is 1 or -1
	
	//convert object x & y into a grid position
	var _x = _object.x div CELL_SIZE
	var _y = _object.y div CELL_SIZE
	
	//check value of the grid position in the direction moving
	var _gridValue = _grid[# _x, _y+_movement]
	
	//if _grid value = VOID it is a wall, and the function returns false 
	if (_gridValue == VOID) {
		return false;	
	}
	else 
	{
		return true;
	}	
}
	
function player_movement() {
		if (keyboard_check_pressed(ord("D")))
	{
		time_cost(MoveCost);
	
		if (grid_movement_x(o_Player, o_Grid.saved_level, 1))
		{
			x += CELL_SIZE;
		}
	
	}
	else if (keyboard_check_pressed(ord("A")))
	{
		time_cost(MoveCost);
	
		if (grid_movement_x(o_Player, o_Grid.saved_level, -1))
		{
			x -= CELL_SIZE;	
		}
	}
	else if (keyboard_check_pressed(ord("S")))
	{
		time_cost(MoveCost);
	
		if (grid_movement_y(o_Player, o_Grid.saved_level, 1))
		{
			y += CELL_SIZE;
		}
	}
	else if (keyboard_check_pressed(ord("W")))
	{
		time_cost(MoveCost);
	
		if (grid_movement_y(o_Player, o_Grid.saved_level, -1))
		{
			y -= CELL_SIZE;	
		}
	}
}

function player_attacks() {
	
	var _attack = noone;
	
	if (o_Grid.playerAttack != true) {
		if (keyboard_check_pressed(ord("W")))
		{
			// Attack 1 script
			_attack = o_Grid.attacks[0];
		}
		else if (keyboard_check_pressed(ord("D")))
		{
			// Attack 1 script
			_attack = o_Grid.attacks[1];	
		}
		else if (keyboard_check_pressed(ord("A")))
		{
			// Attack 1 script
			_attack = o_Grid.attacks[2];	
		}
		else if (keyboard_check_pressed(ord("S")))
		{
			// Attack 1 script
			_attack = o_Grid.attacks[3];	
		}
	}
	
	//attack_pattern[@ _index] = o_Grid.EnemyAttacks[_attack_num];
	if (_attack)
	{
		var _turn = o_Grid.turn;
		
		var _index = _turn + _attack.price/10 + o_Grid.daze;
	
		o_Grid.playerTimeline[@ _index]	= _attack;
		o_Grid.playerAttack = true;
		o_Grid.daze -= 1;
	}
	
	
	//if (_attack)
	//{
	//	_attack.effect();
	//}
}


function player_choose() {
	
	if (o_Grid.Choose) {
		
		if (keyboard_check_pressed(ord("W")))
		{
			// Attack 1 script
			o_Grid.new_attack = o_Grid.DraftAttacks[0];
			o_Grid.Choose = false;
		}
		else if (keyboard_check_pressed(ord("D")))
		{
			// Attack 1 script
			o_Grid.new_attack = o_Grid.DraftAttacks[1];
			o_Grid.Choose = false;
		}
		else if (keyboard_check_pressed(ord("A")))
		{
			// Attack 1 script
			o_Grid.new_attack = o_Grid.DraftAttacks[2];
			o_Grid.Choose = false;
		}
		else if (keyboard_check_pressed(ord("S")))
		{
			// Attack 1 script
			o_Grid.new_attack = o_Grid.DraftAttacks[3];
			o_Grid.Choose = false;
		}
		else if (keyboard_check_pressed(vk_space))
		{
			o_Grid.overworld = true;
			o_Grid.time += 180;
			o_Grid.prev_time += 180;
			o_Grid.Draft = false;
		}
	}
	else
	{
		if (keyboard_check_pressed(ord("W")))
		{
			// Attack 1 script
			replace_attack(0, o_Grid.new_attack);
			o_Grid.overworld = true;
			o_Grid.Draft = false;
		}
		else if (keyboard_check_pressed(ord("D")))
		{
			// Attack 1 script
			replace_attack(1, o_Grid.new_attack);
			o_Grid.overworld = true;
			o_Grid.Draft = false;
		}
		else if (keyboard_check_pressed(ord("A")))
		{
			// Attack 1 script
			replace_attack(2, o_Grid.new_attack);
			o_Grid.overworld = true;
			o_Grid.Draft = false;
		}
		else if (keyboard_check_pressed(ord("S")))
		{
			// Attack 1 script
			replace_attack(3, o_Grid.new_attack);
			o_Grid.overworld = true;
			o_Grid.Draft = false;
		}
		else if (keyboard_check_pressed(vk_space))
		{
			o_Grid.overworld = true;
			o_Grid.time += 180;
			o_Grid.prev_time += 180;
			o_Grid.Draft = false;
		}
	}
}
	
function replace_attack(_atk_index, _new_atk) {

	o_Grid.attacks[@ _atk_index] = _new_atk;

}