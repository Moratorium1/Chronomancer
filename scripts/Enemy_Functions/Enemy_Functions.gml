function Distance_to_player(_object, _range)
{
	var _distance = point_distance(x, y, _object.x, _object.y)
	
	if (_distance <= _range)
	{
		return true;	
	}
}

function Enemy_Movement() {
	if (o_Grid.prev_time != o_Grid.time)
	{
		show_debug_message("enemy move");
		var _timePassed = (o_Grid.prev_time - o_Grid.time) + saved;
		var _moves = _timePassed / moveCost;
	
		if (_moves < 1)
		{
			saved += _timePassed;
		}
		else if (instance_exists(o_Player)) && (Distance_to_player(o_Player, CELL_SIZE*detectionRange))
		{
			saved = 0;
			
			var _moves = round(_moves);
			
			var _x = ((o_Player.x div CELL_SIZE)*CELL_SIZE+CELL_SIZE/2);
			var _y = ((o_Player.y div CELL_SIZE)*CELL_SIZE+CELL_SIZE/2);
			
			
			if (mp_grid_path(o_Grid.navigation, path, x, y, _x, _y, false))
			{
				var _oneStepX = path_get_point_x(path, _moves);
				var _oneStepY = path_get_point_y(path, _moves);
		
				//_angle = point_direction(x,y, _oneStepX, _oneStepY);		
		
				mp_grid_path(o_Grid.navigation, path, x, y, _oneStepX, _oneStepY, false)
		
				mp_potential_step_object(_oneStepX, _oneStepY, CELL_SIZE*_moves, o_unwalkable);
				
				if Distance_to_player(o_Player, CELL_SIZE*8)
				{
					//audio_play_sound(sd_enemy_step, 10, false);
				}
			}
			
		}
	}
}
	
function Enemy_Combat() {
	/*
		create an array to store the enemy attack pattern
		array has to hold enough attacks til the enemy health runs out due to time (enemy health / 10)
	*/
	
	randomize();
	
	var _array_len = (o_Grid.enemy_time/10)*2;	
	attack_pattern = array_create(_array_len, new Enemy_Attack());
	
	/*
		Randomly select an enemy move 
		Place it in the array in the position attack price /10 + the last position that was filled
	*/
	

	for (var _index = 0; _index < _array_len; _index++)
	{
		var _new_pos = 0;
		//_index--; //unsure if this is needed
		var _attack_num = irandom_range(0, 3);
		var _attack = o_Grid.EnemyAttacks[_attack_num];
		var _atk_price = _attack.price;
		_new_pos = (_atk_price/10);
		_index += _new_pos;
	
		attack_pattern[@ _index] = o_Grid.EnemyAttacks[_attack_num];
	}
	
	/* Copy the grid to the enemy timeline */
	array_copy(o_Grid.enemyTimeline, 0, attack_pattern, 0, _array_len);	
}

function Entity_Wander() {
	if (o_Grid.prev_time != o_Grid.time)
	{
		
		var _timePassed = (o_Grid.prev_time - o_Grid.time) + saved;
		var _moves = _timePassed / moveCost;
	
		if (_moves < 1)
		{
			saved += _timePassed;
			
		}
		else if (instance_exists(o_Player))
		{
			saved = 0;
			
			show_debug_message(_moves);
			var _moves = round(_moves);
			
			var _direction = irandom_range(0, 3);
			
			switch (_direction)
			{
				case 0:
				
					var _x = x + CELL_SIZE;
					var _y = y;
					
				break;
				
				case 1:
				
					var _x = x;
					var _y = y - CELL_SIZE;
				
				break;
				
				case 2:
				
					var _x = x - CELL_SIZE;
					var _y = y;
					
				break;
				
				case 3:
				
					var _x = x;
					var _y = y + CELL_SIZE;
				
				break;
				
			}
			
			if (mp_grid_path(o_Grid.navigation, path, x, y, _x, _y, false))
			{
				mp_potential_step_object(_x, _y, CELL_SIZE*_moves, p_Enemy);
			}

		}
	}
	
}