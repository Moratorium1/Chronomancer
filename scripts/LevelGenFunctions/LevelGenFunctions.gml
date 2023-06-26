function create_level(){
	
	/* 
		Create level grid
		Clear level grid
		randomize results
	
		Create a room in the centre of the level
		Pick a random direction, Move in the direction roomSize + 1 
		Create another room
		Repeat above til all rooms are placed
		
		save level
	*/
	
	place_player();
	
	// Create level grid
	level = ds_grid_create(GRID_WIDTH, GRID_HEIGHT)	
	
	// Clear level grid
	ds_grid_set_region(level, 0, 0, GRID_WIDTH, GRID_HEIGHT, VOID)
	
	// Randomize results
	randomize();
	
	// 
	var _room_number = irandom_range(3, 4);
	
	// Find room center
	var _controller_x = GRID_WIDTH div 2;
	var _controller_y = GRID_HEIGHT div 2;
	
	repeat(_room_number)
	{
		// Randomize room size
		var _room_size = irandom_range(3, 4);
	
		// Create Room
		ds_grid_set_region(level, _controller_x - _room_size, _controller_y - _room_size, _controller_x + _room_size, _controller_y + _room_size, FLOOR)
	
		// Calculate distance from current room centre to next room centre
		var _move_dist = _room_size + (_room_size / 2);
		var _controller_direction = irandom(3);
	
		// Move controller to centre of next room
		switch (_controller_direction)
		{
			case 0:
		
			_controller_x += _move_dist;
			
			break;
		
			case 1:
			
			_controller_y -= _move_dist;
			
			break;
			
			case 2: 

			_controller_x += _move_dist;

			break;
			
			case 3: 

			_controller_y += _move_dist;

			break;
		}
	}
	
	save_level();
	
	place_exit()
}

function save_level() {
	ds_grid_copy(saved_level, level);
	ds_grid_destroy(level);
}

function tile_level(){

	// Get tile map id 
	var _wall_map_id = layer_tilemap_get_id("WallTiles");

	// Tile level
	for (var _y = 1; _y < GRID_HEIGHT-1; _y++)
	{
		for (var _x = 1; _x < GRID_WIDTH-1; _x++)
		{
			if (saved_level[# _x, _y] != FLOOR)
			{
				var _north_tile = saved_level[# _x, _y-1] == VOID; //true if the tile above is void
				var _west_tile = saved_level[# _x-1, _y] == VOID;
				var _east_tile = saved_level[# _x+1, _y] == VOID;
				var _south_tile = saved_level[# _x, _y+1] == VOID;
			
				var _tile_index = NORTH*_north_tile + WEST*_west_tile + EAST*_east_tile + SOUTH*_south_tile + 1; //+1 as the first tile of set is transparent
				tilemap_set(_wall_map_id, _tile_index, _x, _y);
			}	
		}
	}
}

function GridToMap() {
///transfer grid contents to a map
//loop through the grid
		for (var _y = 1; _y < GRID_HEIGHT-1; _y++)
		{
			for (var _x = 1; _x < GRID_WIDTH-1; _x++)
			{	//if a grid position != FLOOR it is a wall
				if (saved_level[# _x, _y] != FLOOR)
				{	//add all wall cell to the map as forbidden when pathing
					mp_grid_add_cell(navigation, _x, _y);
				}
			}
		}
}

function floor_count() {
	var _floor_num = 0;
	
	for (var _y = 1; _y < GRID_HEIGHT-1; _y++)
	{
		for (var _x = 1; _x < GRID_WIDTH-1; _x++)
		{
			if (saved_level[# _x, _y] == FLOOR)
			{
				_floor_num++;
			}
		}
	}

	return _floor_num;
}

function spawn_enemies() {

		// Loop through the level
		for (var _y = 1; _y < GRID_HEIGHT-1; _y++)
		{
			for (var _x = 1; _x < GRID_WIDTH-1; _x++)
			{
				// if the grid position is a floor tile, all points have not been spent, and its at least 3 tiles away from the player
				if ((saved_level[# _x, _y] == FLOOR) && (point_distance(_x*CELL_SIZE, _y*CELL_SIZE, o_Player.x, o_Player.y) >= 3*CELL_SIZE) && (!place_meeting(x, y, o_Exit)) && (!place_meeting(x, y, o_Chest)))
				{
					// Roll to see if a enemy should be spawned
					var _enemy_odds = 100;
					
					// Position to spawn enemy - centred to the middle of a grid position
					var _grid_x = _x*CELL_SIZE+CELL_SIZE/2
					var _grid_y = _y*CELL_SIZE+CELL_SIZE/2
					
					if (irandom(_enemy_odds) == _enemy_odds)
					{
						// Roll an enemy cost from 1 to the toal number of points
						var _enemy_num = irandom_range(1, 3);
						
						// Depending on the cost select enemy to spawn
						switch(_enemy_num)
						{
							case 1:
								
								if (_floor < 2)
								{
									
									instance_create_layer(_grid_x, _grid_y, "Instances", o_Bat);
								}
								else if (_floor >= 2 && _floor < 4)
								{
										
									instance_create_layer(_grid_x, _grid_y, "Instances", o_Skeleton);
								}
								else if (_floor >= 4 && _floor < 6)
								{
										
									instance_create_layer(_grid_x, _grid_y, "Instances", o_Skel_Warrior);
								}
								else if (_floor >= 6)
								{
										
									instance_create_layer(_grid_x, _grid_y, "Instances", o_Skel_Knight);
								}
								
							break;
							
							case 2:
							
								if (_floor < 2)
								{
									
									instance_create_layer(_grid_x, _grid_y, "Instances", o_Rat);
								}
								else if (_floor >= 2 && _floor < 4)
								{
										
									instance_create_layer(_grid_x, _grid_y, "Instances", o_Warrior);
								}
								else if (_floor >= 4 && _floor < 6)
								{
										
									instance_create_layer(_grid_x, _grid_y, "Instances", o_Knight);
								}
								else if (_floor >= 6)
								{
										
									instance_create_layer(_grid_x, _grid_y, "Instances", o_Dragon_Knight);
								}
							
							break;
							
							case 3:
							
								if (_floor < 2)
								{
									
									instance_create_layer(_grid_x, _grid_y, "Instances", o_Bat);
								}
								else if (_floor >= 2 && _floor < 4)
								{
										
									instance_create_layer(_grid_x, _grid_y, "Instances", o_Thief);
								}
								else if (_floor >= 4 && _floor < 6)
								{
										
									instance_create_layer(_grid_x, _grid_y, "Instances", o_Rogue);
								}
								else if (_floor >= 6)
								{
										
									instance_create_layer(_grid_x, _grid_y, "Instances", o_Assassin);
								}
							
							break;
							
						}
					}
				}
			}
		}

	if (instance_number(p_Enemy) < 3)
	{
		spawn_enemies();	
	}
}

function place_chests() {
	
	var _min = 2;
	var _max = 3;
	
	// If there are less than the m
	
		if (instance_number(o_Chest) < _min)
		{
			for (var _y = 1; _y < GRID_HEIGHT-1; _y++)
			{
				for (var _x = 1; _x < GRID_WIDTH-1; _x++)
				{
					if ((saved_level[# _x, _y] == FLOOR) && (point_distance(_x*CELL_SIZE, _y*CELL_SIZE, o_Player.x, o_Player.y) >= 8*CELL_SIZE) && (!place_meeting(x, y, o_Exit)) && (!place_meeting(x, y, o_Chest)))
					{
						var _chest_odds = 50;
			
						var _grid_x = _x*CELL_SIZE+CELL_SIZE/2
						var _grid_y = _y*CELL_SIZE+CELL_SIZE/2
			
						if (irandom(_chest_odds) == _chest_odds) && (instance_number(o_Chest) < _max)
						{
							var _mimic_odds = 10;
							
							if (irandom(_mimic_odds) == _mimic_odds)
							{
								instance_create_layer(_grid_x, _grid_y, "Instances", o_Mimic);
							}
							else
							{
								instance_create_layer(_grid_x, _grid_y, "Instances", o_Chest);
							}
							
						}
					}
				}
			}
		}
		
		if (instance_number(o_Chest) < _min)
		{
			place_chests();	
		}
		
		
}

function place_fairy() {
	
	// If there are less than the m
	
		
		for (var _y = 1; _y < GRID_HEIGHT-1; _y++)
		{
			for (var _x = 1; _x < GRID_WIDTH-1; _x++)
			{
				if ((saved_level[# _x, _y] == FLOOR) && (point_distance(_x*CELL_SIZE, _y*CELL_SIZE, o_Player.x, o_Player.y) >= 4*CELL_SIZE))
				{
					var _fairy_odds = 50;
			
					var _grid_x = _x*CELL_SIZE+CELL_SIZE/2
					var _grid_y = _y*CELL_SIZE+CELL_SIZE/2
			
					if (irandom(_fairy_odds) == _fairy_odds) && (!instance_exists(o_Fairy))
					{
						instance_create_layer(_grid_x, _grid_y, "Instances", o_Fairy);
					}
				}
			}
		}
		
		
		if (!instance_exists(o_Fairy))
		{
			place_fairy();	
		}
		
		
}

function place_exit() {
	
	for (var _y = 1; _y < GRID_HEIGHT-1; _y++)
	{
		for (var _x = 1; _x < GRID_WIDTH-1; _x++)
		{
			if ((saved_level[# _x, _y] == FLOOR) && (point_distance(_x*CELL_SIZE, _y*CELL_SIZE, o_Player.x, o_Player.y) >= 8*CELL_SIZE) && (!place_meeting(x, y, o_Chest)))
			{
				var _exit_odds = 50;
			
				var _grid_x = _x*CELL_SIZE+CELL_SIZE/2
				var _grid_y = _y*CELL_SIZE+CELL_SIZE/2
			
				if (irandom(_exit_odds) == _exit_odds) && (!instance_exists(o_Exit))
				{
					instance_create_layer(_grid_x, _grid_y, "Instances", o_Exit);
				}
			}
		}
	}	
	
	if (!instance_exists(o_Exit))
	{
		room_restart();	
	}
}
	
function place_player(){

	var _controller_x = GRID_WIDTH div 2;
	var _controller_y = GRID_HEIGHT div 2;
	var _player_start_x = _controller_x * CELL_SIZE + CELL_SIZE/2;
	var _player_start_y = _controller_y * CELL_SIZE + CELL_SIZE/2;
	instance_create_layer(_player_start_x, _player_start_y, "Instances", o_Player)
	
}
	
function next_level(){
	
	create_level();
	room_restart();
}