// Constructor for attacks
function Enemy_Attack() constructor { //General Weapon struct, needs to hold all variables a weapon could require.
	AttackNo	= 0;
	name	= "Nothing";
	desc	= "The foe is doing nothing";
	sprite	= s_Nothing;
	price	= 0;
	damage = 0;		
	target = "Player";
	effect = function()
			{
				
			}
}

function Enemy_Attack_0() : Enemy_Attack() constructor {
	AttackNo	= 1;
	name	= "Scratch";
	desc	= "The target is raked with claws or teeth";
	sprite	= s_Scratch;
	price	= 20;
	damage	= 10;
	effect	= function() 
			{
				o_Grid.time -= damage;
			}
}


function Enemy_Attack_1() : Enemy_Attack() constructor {
	AttackNo	= 2;
	name	= "Scratch";
	desc	= "The target is raked with claws or teeth";
	sprite	= s_Scratch;
	price	= 20;
	damage	= 10;
	effect	= function() 
			{
				show_debug_message("enemy attacks")
				o_Grid.time -= damage;
			}
}

function Enemy_Attack_2() : Enemy_Attack() constructor {
	AttackNo	= 3;
	name	= "Bite";
	desc	= "The user attacks with fangs - Inflicts Bleed";
	sprite	= s_Bite;
	price	= 30;
	damage	= 10;
	effect	= function() 
			{
				o_Grid.time -= damage;
				o_Grid.bleed++;
			}
}

function Enemy_Attack_3() : Enemy_Attack() constructor {
	AttackNo	= 4;
	name	= "Fairy Blessing";
	desc	= "The fairy bestows 60 seconds to you";
	sprite	= s_Fairy_Blessing;
	price	= 30;
	damage	= 0;
	effect	= function() 
			{
				o_Grid.time += 60;
			}
}

function Enemy_Attack_4() : Enemy_Attack() constructor {
	AttackNo	= 5;
	name	= "Bonerang";
	desc	= "Add Bonerang return to player timeline";
	sprite	= s_Bone;
	price	= 30;
	damage	= 20;
	effect	= function() 
			{
				if (o_Grid.playerTimeline[o_Grid.turn + 4].name = "Nothing")
				{
					o_Grid.playerTimeline[@ o_Grid.turn + 4] = new Enemy_Attack_5();
				}
				else if (o_Grid.playerTimeline[o_Grid.turn + 5].name = "Nothing")
				{
					o_Grid.playerTimeline[@ o_Grid.turn + 5] = new Enemy_Attack_5();
				}
				else if (o_Grid.playerTimeline[o_Grid.turn + 6].name = "Nothing")
				{
					o_Grid.playerTimeline[@ o_Grid.turn + 6] = new Enemy_Attack_5();
				}
				
			}
}

function Enemy_Attack_5() : Enemy_Attack() constructor {
	AttackNo	= 6;
	name	= "Bonerang Returns";
	desc	= "Inflicts daze - Can be overidden by player attack";
	sprite	= s_Bone_Returns;
	price	= 0;
	damage	= 40;
	effect	= function() 
			{
				o_Grid.time -= damage;
				o_Grid.daze++;
			}
}

function Enemy_Attack_6() : Enemy_Attack() constructor {
	AttackNo	= 7;
	name	= "Bone Club";
	desc	= "The target is clubbed with a large bone";
	sprite	= s_Bone_Club;
	price	= 40;
	damage	= 30;
	effect	= function() 
			{
				o_Grid.time -= damage;
			}
}

function Enemy_Attack_7() : Enemy_Attack() constructor {
	AttackNo	= 8;
	name	= "Scatter Caltrops";
	desc	= "Scatter caltrops along the player timeline";
	sprite	= s_Caltrops_Enemy;
	price	= 20;
	damage	= 0;
	effect	= function() 
			{
				//Check to ensure doesnt overide player attack
				
				for(var i = 0; i < 6; i += 2)
				{
					if (o_Grid.playerTimeline[o_Grid.turn + i + 3].name = "Nothing")
					{
						o_Grid.playerTimeline[@ o_Grid.turn + i + 3] = new Enemy_Attack_8();
					}
					else if (o_Grid.playerTimeline[o_Grid.turn + i + 4].name = "Nothing")
					{
						o_Grid.playerTimeline[@ o_Grid.turn + i + 4] = new Enemy_Attack_8();
					}
				}	
			}
}

function Enemy_Attack_8() : Enemy_Attack() constructor {
	AttackNo	= 9;
	name	= "Caltrops";
	desc	= "Can be overidden by player attack";
	sprite	= s_Caltrops_Enemy;
	price	= 0;
	damage	= 10;
	effect	= function() 
			{
				o_Grid.time -= damage;
			}
}

function Enemy_Attack_9() : Enemy_Attack() constructor {
	AttackNo	= 10;
	name	= "Parry";
	desc	= "If the player takes an action at the same time ignore the damage and create a counter";
	sprite	= s_Parry;
	price	= 30;
	damage	= 0;
	effect	= function() 
			{
				if (o_Grid.playerTimeline[o_Grid.turn].name != "Nothing")
				{
					// regain dmg lost to player attack
					o_Grid.enemy_time += o_Grid.playerTimeline[o_Grid.turn].damage;	
					
					o_Grid.enemyTimeline[@ o_Grid.turn + 1] = new Enemy_Attack_10();
				}
			}
}

function Enemy_Attack_10() : Enemy_Attack() constructor {
	AttackNo	= 11;
	name	= "Counter";
	desc	= "The foe attacks quickly in the opening created by a well timed parry";
	sprite	= s_CounterAttack;
	price	= 0;
	damage	= 60;
	effect	= function() 
			{
				o_Grid.time -= damage;
			}
}

function Enemy_Attack_11() : Enemy_Attack() constructor {
	AttackNo	= 12;
	name	= "Stike";
	desc	= "The target is struck with a weapon";
	sprite	= s_Counter;
	price	= 40;
	damage	= 40;
	effect	= function() 
			{
				o_Grid.time -= damage;
			}
}

function Enemy_Attack_12() : Enemy_Attack() constructor {
	AttackNo	= 13;
	name	= "Shield Bash";
	desc	= "The target is struck with a shield - Inflicts daze";
	sprite	= s_Shield_Bash;
	price	= 40;
	damage	= 20;
	effect	= function() 
			{
				o_Grid.time -= damage;
				o_Grid.daze += 1;
			}
}

function Enemy_Attack_13() : Enemy_Attack() constructor {
	AttackNo	= 14;
	name	= "Fight Dirty";
	desc	= "Sand is thrown in the targets eyes - inflicts blind";
	sprite	= s_Fight_Dirty;
	price	= 20;
	damage	= 10;
	effect	= function() 
			{
				o_Grid.time -= damage;
				o_Grid.blind = 1;
			}
}

function Enemy_Attack_14() : Enemy_Attack() constructor {
	AttackNo	= 14;
	name	= "Blinding Powder";
	desc	= "A stinging powder is thrown in the targets eyes - inflicts severe blind";
	sprite	= s_BlindingPowder;
	price	= 30;
	damage	= 10;
	effect	= function() 
			{
				o_Grid.time -= damage;
				o_Grid.blind = 2;
			}
}

// ADD BLEEDING CALTROPS FOR ASSASSIN

function Enemy_Attack_15() : Enemy_Attack() constructor {
	AttackNo	= 15;
	name	= "Sharpened Caltrops";
	desc	= "Scatter sharpened caltrops along the player timeline";
	sprite	= s_Caltrops_Sharpened;
	price	= 30;
	damage	= 0;
	effect	= function() 
			{
				//Check to ensure doesnt overide player attack
				
				for(var i = 0; i < 6; i += 2)
				{
					if (o_Grid.playerTimeline[o_Grid.turn + i + 3].name = "Nothing")
					{
						o_Grid.playerTimeline[@ o_Grid.turn + i + 3] = new Enemy_Attack_16();
					}
					else if (o_Grid.playerTimeline[o_Grid.turn + i + 4].name = "Nothing")
					{
						o_Grid.playerTimeline[@ o_Grid.turn + i + 4] = new Enemy_Attack_16();
					}
				}	
			}
}

function Enemy_Attack_16() : Enemy_Attack() constructor {
	AttackNo	= 16;
	name	= "Sharpened Caltrops";
	desc	= "Inflicts bleed - Can be overidden by player attack";
	sprite	= s_Caltrops_Sharpened;
	price	= 0;
	damage	= 0;
	effect	= function() 
			{
				o_Grid.time -= damage;
				o_Grid.bleed++;
			}
}

function Enemy_Attack_17() : Enemy_Attack() constructor {
	AttackNo	= 13;
	name	= "Shield Slam";
	desc	= "The target is slammed with a heavy shield - Inflicts daze";
	sprite	= s_Shield_Slam;
	price	= 50;
	damage	= 50;
	effect	= function() 
			{
				o_Grid.time -= damage;
				o_Grid.daze += 2;
			}
}

function Enemy_Attack_18() : Enemy_Attack() constructor {
	AttackNo	= 13;
	name	= "Dragon Slam";
	desc	= "A spiked shield is thrust into the target - inflicts daze & bleed";
	sprite	= s_Dragon_Slam;
	price	= 30;
	damage	= 50;
	effect	= function() 
			{
				o_Grid.time -= damage;
				o_Grid.daze += 1;
				o_Grid.bleed += 1;
			}
}

function Enemy_Attack_19() : Enemy_Attack() constructor {
	AttackNo	= 13;
	name	= "Whirlwind";
	desc	= "The Knight lashes out wildly with its sword";
	sprite	= s_Counter;
	price	= 20;
	damage	= 30;
	effect	= function() 
			{
				o_Grid.time -= damage;
				for(var i = 0; i < 6; i += 2)
				{
					if (o_Grid.enemyTimeline[o_Grid.turn + i + 3].name = "Nothing")
					{
						o_Grid.enemyTimeline[@ o_Grid.turn + i + 3] = new Enemy_Attack_20();
					}
					else if (o_Grid.enemyTimeline[o_Grid.turn + i + 3].name = "Wild Strike")
					{
						o_Grid.enemyTimeline[@ o_Grid.turn + i + 3] = new Enemy_Attack_22();
					}
					else if (o_Grid.enemyTimeline[o_Grid.turn + i + 4].name = "Nothing")
					{
						o_Grid.enemyTimeline[@ o_Grid.turn + i + 4] = new Enemy_Attack_20();
					}
					else if (o_Grid.enemyTimeline[o_Grid.turn + i + 4].name = "Wild Strike")
					{
						o_Grid.enemyTimeline[@ o_Grid.turn + i + 4] = new Enemy_Attack_22();
					}	
				}
			}	
	}

function Enemy_Attack_20() : Enemy_Attack() constructor {
	AttackNo	= 13;
	name	= "Wild Strike";
	desc	= "If two wild strikes get played on the same turn upgrade them to a dragon strike";
	sprite	= s_DragonCounterAttack;
	price	= 0;
	damage	= 30;
	effect	= function() 
			{
				o_Grid.time -= damage;
				o_Grid.daze += 1;
			
			}
}

function Enemy_Attack_21() : Enemy_Attack() constructor {
	AttackNo	= 10;
	name	= "Dragon's Counter";
	desc	= "If the player takes an action at the same time ignore the damage and create a wild strike next turn";
	sprite	= s_DragonCounter;
	price	= 20;
	damage	= 20;
	effect	= function() 
			{
				if (o_Grid.playerTimeline[o_Grid.turn].name != "Nothing")
				{
					// regain dmg lost to player attack
					o_Grid.enemy_time += o_Grid.playerTimeline[o_Grid.turn].damage;	
					
					if (o_Grid.enemyTimeline[o_Grid.turn].name = "Wild Strike")
					{
						o_Grid.enemyTimeline[@ o_Grid.turn + 1] = new Enemy_Attack_22();
					}
					else
					{
						o_Grid.enemyTimeline[@ o_Grid.turn + 1] = new Enemy_Attack_20();
					}
				}
			}
}

function Enemy_Attack_22() : Enemy_Attack() constructor {
	AttackNo	= 13;
	name	= "Dragon Strike";
	desc	= "A wild strike of a sword imbued with the fury of a dragon";
	sprite	= s_DragonStrike;
	price	= 0;
	damage	= 120;
	effect	= function() 
			{
				o_Grid.time -= damage;
				o_Grid.bleed += 1;
			
			}
}