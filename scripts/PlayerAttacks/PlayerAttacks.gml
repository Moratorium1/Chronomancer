// Constructor for attacks
function Attack() constructor { //General Weapon struct, needs to hold all variables a weapon could require.
	AttackNo	= 0;
	name	= "Nothing";
	desc	= "Do nothing";
	sprite	= s_Nothing;
	price	= 0;
	damage = 0;		
	target = "Enemy"
	effect = function() 
			{
				
			}
}

//Weapons
function scr_attack_0() : Attack() constructor {
	AttackNo	= 1;
	name	= "Whack";
	desc	= "The foe is whacked hard with a staff";
	sprite	= s_Thwack;
	price	= 20;
	damage	= 10;
	effect	= function() 
			{
				o_Grid.enemy_time -= damage;
				o_Grid.playerAttack = false;
			}
}

function scr_attack_1() : Attack() constructor {
	AttackNo	= 2;
	name	= "Jolt";
	desc	= "The foe is struck by a jolt of chrono energy";
	sprite	= s_Jolt;
	price	= 30;
	damage	= 20;
	effect	= function() 
			{
				o_Grid.enemy_time -= damage;
				o_Grid.playerAttack = false;
			}
}

function scr_attack_2() : Attack() constructor {
	AttackNo	= 3;
	name	= "Bolt";
	desc	= "The foe is struck by a Bolt of chrono energy";
	sprite	= s_Bolt;
	price	= 50;
	damage	= 40;
	effect	= function() 
			{
				o_Grid.enemy_time -= damage;
				o_Grid.playerAttack = false;
			}
}

function scr_attack_3() : Attack() constructor {
	AttackNo	= 4;
	name	= "Cure";
	desc	= "The caster fast forwards time to remove negative status effects - removes daze and bleed";
	sprite	= s_Heal;
	price	= 30;
	damage	= 0;
	effect	= function() 
			{
				o_Grid.bleed = 1;
				o_Grid.daze = 0;
				o_Grid.playerAttack = false;
			}
}

function scr_attack_4() : Attack() constructor {
	AttackNo	= 5;
	name	= "Rewind";
	desc	= "Rewind the timeline by 70 Seconds - Fails if wound below 0";
	sprite	= s_Rewind;
	price	= 20;
	damage	= 0;
	effect	= function() 
			{
				// Check if enough turns have passed - prevents game crash if turns = negative
				if (o_Grid.turn > 6) 
				{
					// Clears rewind from timeline - prevents rewinding chaining
					o_Grid.playerTimeline[@ o_Grid.turn] = new Attack();
					// Perform the rewind
					o_Grid.turn -= 6;
					// Set the player attack to false by default
					o_Grid.playerAttack = false;
				}
				else
				{
					o_Grid.playerAttack = false;
				}
				
				// Clears rewind from timeline - prevents rewinding chaining
				o_Grid.playerTimeline[@ o_Grid.turn] = new Attack();
				
			}
}

function scr_attack_5() : Attack() constructor {
	AttackNo	= 5;
	name	= "Caltrops";
	desc	= "Scatter caltrops along the enemy timeline";
	sprite	= s_Caltrop_Player;
	price	= 20;
	damage	= 0;
	effect	= function() 
			{
				//Check to ensure doesnt overide player attack
				
				for(var i = 0; i < 6; i += 2)
				{
					if (o_Grid.enemyTimeline[o_Grid.turn + i + 3].name = "Nothing")
					{
						o_Grid.enemyTimeline[@ o_Grid.turn + i + 3] = new scr_attack_6();
					}
					else if (o_Grid.enemyTimeline[o_Grid.turn + i + 4].name = "Nothing")
					{
						o_Grid.enemyTimeline[@ o_Grid.turn + i + 4] = new scr_attack_6();
					}
				}	
			}
}

function scr_attack_6() : Attack() constructor {
	AttackNo	= 9;
	name	= "Caltrop";
	desc	= "Deals damage when the foe reaches them";
	sprite	= s_Caltrop_Player;
	price	= 0;
	damage	= 10;
	target  = "Enemy"
	effect	= function() 
			{
				o_Grid.enemy_time -= damage;
			}
}

function scr_attack_7() : Attack() constructor {
	AttackNo	= 9;
	name	= "Flare";
	desc	= "Energy is pulled from across the timelines to strike the foe - removes a stage of blind";
	sprite	= s_Flare;
	price	= 40;
	damage	= 20;
	target  = "Enemy"
	effect	= function() 
			{
				o_Grid.enemy_time -= damage;
				o_Grid.blind -= 1;
			}
}

function scr_attack_12() : Attack() constructor {
	AttackNo	= 9;
	name	= "Flash";
	desc	= "Energy from the timeline is used to power a flash of light - removes a stage of blind";
	sprite	= s_Flash;
	price	= 20;
	damage	= 10;
	target  = "Enemy"
	effect	= function() 
			{
				o_Grid.enemy_time -= damage;
				o_Grid.blind -= 1;
			}
}

function scr_attack_8() : Attack() constructor {
	AttackNo	= 9;
	name	= "Shockwave";
	desc	= "Create a shockwave across the timeline to create three damaging pulses";
	sprite	= s_Shockwave;
	price	= 50;
	damage	= 20;
	target  = "Enemy"
	effect	= function() 
			{
				o_Grid.time -= damage;
				for(var i = 0; i < 6; i += 2)
				{
					if (o_Grid.playerTimeline[o_Grid.turn + i + 3].name = "Nothing" || o_Grid.playerTimeline[o_Grid.turn + i + 3].name = "Caltrops" || o_Grid.playerTimeline[o_Grid.turn + i + 3].name = "Sharpened Caltrops")
					{
						o_Grid.playerTimeline[@ o_Grid.turn + i + 3] = new scr_attack_9();
					}
					else if (o_Grid.playerTimeline[o_Grid.turn + i + 3].name = "Pulse")
					{
						o_Grid.playerTimeline[@ o_Grid.turn + i + 3] = new scr_attack_10();
					}
					else if (o_Grid.playerTimeline[o_Grid.turn + i + 4].name = "Nothing" || o_Grid.playerTimeline[o_Grid.turn + i + 4].name = "Caltrops" || o_Grid.playerTimeline[o_Grid.turn + i + 4].name = "Sharpened Caltrops")
					{
						o_Grid.playerTimeline[@ o_Grid.turn + i + 4] = new scr_attack_9();
					}
					else if (o_Grid.playerTimeline[o_Grid.turn + i + 4].name = "Pulse")
					{
						o_Grid.playerTimeline[@ o_Grid.turn + i + 4] = new scr_attack_10();
					}	
				}
			}
}

function scr_attack_11() : Attack() constructor {
	AttackNo	= 9;
	name	= "Ripple";
	desc	= "A ripple in the timeline is exploited to create two damaging pulses";
	sprite	= s_Ripple;
	price	= 20;
	damage	= 0;
	target  = "Enemy"
	effect	= function() 
			{
				o_Grid.time -= damage;
				for(var i = 0; i < 4; i += 2)
				{
					if (o_Grid.playerTimeline[o_Grid.turn + i + 3].name = "Nothing" || o_Grid.playerTimeline[o_Grid.turn + i + 3].name = "Caltrops" || o_Grid.playerTimeline[o_Grid.turn + i + 3].name = "Sharpened Caltrops")
					{
						o_Grid.playerTimeline[@ o_Grid.turn + i + 3] = new scr_attack_9();
					}
					else if (o_Grid.playerTimeline[o_Grid.turn + i + 3].name = "Pulse")
					{
						o_Grid.playerTimeline[@ o_Grid.turn + i + 3] = new scr_attack_10();
					}
					else if (o_Grid.playerTimeline[o_Grid.turn + i + 4].name = "Nothing" || o_Grid.playerTimeline[o_Grid.turn + i + 4].name = "Caltrops" || o_Grid.playerTimeline[o_Grid.turn + i + 4].name = "Sharpened Caltrops")
					{
						o_Grid.playerTimeline[@ o_Grid.turn + i + 4] = new scr_attack_9();
					}
					else if (o_Grid.playerTimeline[o_Grid.turn + i + 4].name = "Pulse")
					{
						o_Grid.playerTimeline[@ o_Grid.turn + i + 4] = new scr_attack_10();
					}	
				}
			}
}

function scr_attack_9() : Attack() constructor {
	AttackNo	= 9;
	name	= "Pulse";
	desc	= "If two pulses are played on the same turn upgrade them to a wave";
	sprite	= s_Pulse;
	price	= 30;
	damage	= 20;
	target  = "Enemy"
	effect	= function() 
			{
					o_Grid.enemy_time -= damage;	
			}
}

function scr_attack_10() : Attack() constructor {
	AttackNo	= 9;
	name	= "Wave";
	desc	= "The combination of two pulses";
	sprite	= s_Wave;
	price	= 30;
	damage	= 60;
	target  = "Enemy"
	effect	= function() 
			{
				o_Grid.enemy_time -= damage;
			}
}

function scr_attack_13() : Attack() constructor {
	AttackNo	= 9;
	name	= "Lock";
	desc	= "The player and enemy no longer take damage from the passage of time - Including bleed effects";
	sprite	= s_Lock;
	price	= 60;
	damage	= 0;
	target  = "Player"
	effect	= function() 
			{
				o_Grid.lock = true;
			}
}

function scr_attack_14() : Attack() constructor {
	AttackNo	= 9;
	name	= "Stasis";
	desc	= "The player and enemy no longer take damage from the passage of time - Inflicts 3 Daze";
	sprite	= s_Stasis;
	price	= 30;
	damage	= 0;
	target  = "Player"
	effect	= function() 
			{
				o_Grid.daze = 3;
				o_Grid.lock = true;
			}
}

function scr_attack_15() : Attack() constructor {
	AttackNo	= 9;
	name	= "Shard";
	desc	= "Shards of time are launched at the foe - Including bleed effects";
	sprite	= s_Shards;
	price	= 30;
	damage	= 10;
	target  = "Player"
	effect	= function() 
			{
				o_Grid.enemy_time -= damage;
				o_Grid.enemy_bleed += 1;
			}
}

function scr_attack_16() : Attack() constructor {
	AttackNo	= 9;
	name	= "Fragment";
	desc	= "A fragment of time is launched at the foe - Including bleed effects";
	sprite	= s_Fragment;
	price	= 50;
	damage	= 40;
	target  = "Player"
	effect	= function() 
			{
				o_Grid.enemy_time -= damage;
				o_Grid.enemy_bleed += 1;
			}
}




/*
function scr_attack_4() : Attack() constructor {
	AttackNo	= 5;
	name	= "Hourglass";
	desc	= "";
	sprite	= s_Scratch;
	price	= 20;
	damage	= 0;
	effect	= function() 
			{
				/*
					Deduct price
					Check next avilable ally slot
					Create o_hourglass in slot - o_hourglass destroys self after 60 to give player +120?
					if no ally slot avilable return with no o_hourglass created
				*/
				
				//Check next available ally slot
				
				/*
				if (o_Grid.ally1 == noone)
				{
					o_Grid.ally1 = instance_create_layer(200, 200, "Instances", o_Hourglass);
					
					with (o_Grid.ally1)
					{
						slot = 1;	
					}
					
				}
				else if (o_Grid.ally2 == noone)
				{
					o_Grid.ally2 = instance_create_layer(200, 300, "Instances", o_Hourglass);
					
					with (o_Grid.ally2)
					{
						slot = 2;	
					}
				}
				else if (o_Grid.ally3 == noone)
				{
					o_Grid.ally3 = instance_create_layer(200, 400, "Instances", o_Hourglass);
					
					with (o_Grid.ally3)
					{
						slot = 3;	
					}
				}
				else
				{
					return	
				}
				
				o_Grid.playerAttack = false;
				
				//o_Grid.ally1 = instance_create_layer()
			}
}

