var dr = detection_radius;
var er = exit_radius

if (point_in_rectangle(playerobject.x, playerobject.y, x-dr, y-dr, x+dr, y+dr))
{
	if (myTextbox != noone)
	{ 
		if (!instance_exists(myTextbox)) { myTextbox = noone; exit; }
	}
	else if (keyboard_check_pressed(interact_key))
	{
		if (instance_exists(obj_textbox)) { exit; }	//exit if a textbox already exists
		event_user(0);								//if you need variables to update for text
			
		//Hand over variables
		create_dialogue(myText, mySpeaker, myEffects, myTextSpeed, myTypes, myNextLine, myScripts, myTextCol, myEmotion, myEmote);
	}
}
else if !(point_in_rectangle(playerobject.x, playerobject.y, x-er, y-er, x+er, y+er))
{
	// player moves outside of detection radius
	
	if (myTextbox != noone) {
		with (myTextbox) instance_destroy();
		myTextbox = noone;
	}
}




if (random(1) < 0.003)
{
	ai_x = choose(1, 2);
}
if (random(1) < 0.003)
{
	ai_y = choose(1, 2);
}

var _left = 0;
var _right = 0;
var _up = 0;
var _down = 0;

if !instance_exists(obj_textbox)
{
	if (ai_x == 1 || ai_x == 2)
	{
		//move on axis
		if (ai_x == 1) _left = 1;
		else _right = 1;
	
		if (random(1) < 0.005)
		{
			if (random(1) < 0.2)
			{
				if (ai_x == 1) ai_x = 2
				else ai_x = 1
			}
			else
			{
				ai_x = 0
			}
		}
	}

	if (ai_y == 1 || ai_y == 2)
	{
		//move on axis
		if (ai_y == 1) _up = 1;
		else _down = 1;
	
		if (random(1) < 0.005)
		{
			if (random(1) < 0.2)
			{
				if (ai_y == 1) ai_y = 2
				else ai_y = 1
			}
			else
			{
				ai_y = 0
			}
		}
	}
}

var _snd_footstep_falloff = 100;
var _snd_jump_falloff = 200;
var _snd_land_falloff = 80;

var _space = random(1) < 0.003;
var _c = 0;

var _a = random(1) < 0.003;
var _s = 0;
var _d = 0;
z += zvel;

var _grid_collide_post = obj_Game.grid_empty;
if (z < -16)
	_grid_collide_post = obj_Game.grid_empty;
else if (z < 0)
	_grid_collide_post = obj_Game.grid_ground;
else if (z < 16)
	_grid_collide_post = obj_Game.grid_middle;
else if (z < 32)
	_grid_collide_post = obj_Game.grid_top;
	
var _grid_collide_post_offset = obj_Game.grid_empty;
if (z < -16 - 1)
	_grid_collide_post_offset = obj_Game.grid_empty;
else if (z < 0 - 1)
	_grid_collide_post_offset = obj_Game.grid_ground;
else if (z < 16 - 1)
	_grid_collide_post_offset = obj_Game.grid_middle;
else if (z < 32 - 1)
	_grid_collide_post_offset = obj_Game.grid_top;
	
_onceiling = false;
_onfloor = false;
var _foot_to_floor_offset_y = y;

if zvel > 0 { // rising
	if (_grid_collide_post_offset != false)
	{
		if (_grid_collide_post_offset == obj_Game.grid_ground && obj_Game.grid_ground[# x div CELL_WIDTH, _foot_to_floor_offset_y div CELL_HEIGHT] == FLOOR) {
			zvel = 0;
			z = -16 - 1;
			_onceiling = _grid_collide_post_offset;
		}
		if (_grid_collide_post_offset == obj_Game.grid_middle && obj_Game.grid_middle[# x div CELL_WIDTH, _foot_to_floor_offset_y div CELL_HEIGHT] == FLOOR) {
			zvel = 0;
			z = 0 - 1;
			_onceiling = _grid_collide_post_offset;
		}
		if (_grid_collide_post_offset == obj_Game.grid_top && obj_Game.grid_top[# x div CELL_WIDTH, _foot_to_floor_offset_y div CELL_HEIGHT] == FLOOR) {
			zvel = 0;
			z = 16 - 1;
			_onceiling = _grid_collide_post_offset;
		}
	}
} else if zvel < 0 { // falling	
	if (_grid_collide_post != false)
	{
		if (_grid_collide_post == obj_Game.grid_ground && obj_Game.grid_ground[# x div CELL_WIDTH, _foot_to_floor_offset_y div CELL_HEIGHT] == FLOOR) {
			zvel = 0;
			z = 0;
			_onfloor = _grid_collide_post;
		}
		if (_grid_collide_post == obj_Game.grid_middle && obj_Game.grid_middle[# x div CELL_WIDTH, _foot_to_floor_offset_y div CELL_HEIGHT] == FLOOR) {
			zvel = 0;
			z = 16;
			_onfloor = _grid_collide_post;
		}
		if (_grid_collide_post == obj_Game.grid_top && obj_Game.grid_top[# x div CELL_WIDTH, _foot_to_floor_offset_y div CELL_HEIGHT] == FLOOR) {
			zvel = 0;
			z = 32;
			_onfloor = _grid_collide_post;
		}
	}
}
_timesince_onfloor ++;
if _onfloor _timesince_onfloor = 0;

// get floor material
var _tilemap_id = layer_tilemap_get_id(layer_get_id("Tiles_ground"));
var _data = tilemap_get_at_pixel(_tilemap_id, x, y+6);
var _type = "Stone";

if (_data != 0) {
	if (_data < 42) {
		_type = "Cloud";
	} else if (_data < 84) {
		_type = "Dirt";
	} else if (_data < 126) {
		_type = "Gravel";
	} else if (_data < 168) {
		_type = "Stone";
	}
}

if (_c)
{
	zvel = -0.45;
}

if (_space) jump_time = 14;

if (_onfloor)
{
	jumpingstate = 0;
}

if (jump_time > 0)
{
	jump_time--;
	if _timesince_onfloor < 15 && jumpingstate == 0 {
		zvel = 2.25;

		audio_play_sound(jump,1,false,(0.3)/(distance_to_object(Player)/_snd_jump_falloff),0,1);
		
		jumpingstate = 1;
	
		var _p = instance_create_depth(x,y+6,0,obj_Particle);
		switch _type {
			case "Cloud":
				_p.sprite_index = spr_cloud_step;
				break;
			case "Dirt":
				_p.sprite_index = spr_dirt_step;
				break;
			case "Gravel":
				_p.sprite_index = spr_stone_step;
				break;
			case "Stone":
				_p.sprite_index = spr_stone_step;
				break;
			default:
				_p.sprite_index = spr_stone_step;
				break;
		}
		_p.image_speed = 0.5;
		_p.xvel = random_range(-0.4, 0.4);
		_p.yvel = random_range(-0.1, -0.4);
	}
}




var _hor = (_right - _left);
var _vertical = (_down - _up);

var _speed_normal = 0.13;
var _inair_mod = 0.3;
if (_onfloor) _inair_mod = 1.0;
var _speed_diagonal = _speed_normal * 0.707;

if (attack_time <= 0 && movelock_time <= 0)
{
	// wait for activation
	if (_a) {
		audio_play_sound(snd_swoosh, 1, 0);
		attack_time = 50;
		characterstate = 1;
		if !_onfloor zvel = 0.65;
		
	}
	
	if (_s) {
		attack_time = 100;
		characterstate = 2;
		if !_onfloor zvel = 0.65;
	}
}
else {
	switch characterstate
	{
		case 1: // attack
		{
			draw_slash = 1;
			var _attack_speed_normal = 0.27;
			var _attack_speed_diagonal = _attack_speed_normal * 0.707;

			if (_hor != 0 && _vertical != 0) {
				xvel += _hor * _attack_speed_diagonal * _inair_mod;
				yvel += _vertical * _attack_speed_diagonal * _inair_mod;
			} else {
				xvel += _hor * _attack_speed_normal * _inair_mod;
				yvel += _vertical * _attack_speed_normal * _inair_mod;
			}
		}
		break;
		case 2:
		{
			var _attack_speed_normal = 0.37;
			var _attack_speed_diagonal = _attack_speed_normal * 0.707;

			if (_hor != 0 && _vertical != 0) {
				xvel += _hor * _attack_speed_diagonal * _inair_mod;
				yvel += _vertical * _attack_speed_diagonal * _inair_mod;
			} else {
				xvel += _hor * _attack_speed_normal * _inair_mod;
				yvel += _vertical * _attack_speed_normal * _inair_mod;
			}
			
			zvel += 0.09;
		}
		break;
	}
	
	attack_time --; // on cooldown
	
	if (attack_time == 0) {
		draw_slash = 0;
		characterstate = 0;
		movelock_time = 30;
	}
}

if (characterstate == 0) // basic ground and air movement
{
	if (_hor != 0 && _vertical != 0) {
		xvel += _hor * _speed_diagonal * _inair_mod;
		yvel += _vertical * _speed_diagonal * _inair_mod;
	} else {
		xvel += _hor * _speed_normal * _inair_mod;
		yvel += _vertical * _speed_normal * _inair_mod;
	}
}

var _grid_collide = obj_Game.grid_empty;
if (z < -16)
	_grid_collide = obj_Game.grid_empty;
else if (z < 0)
	_grid_collide = obj_Game.grid_ground;
else if (z < 16)
	_grid_collide = obj_Game.grid_middle;
else if (z < 32)
	_grid_collide = obj_Game.grid_top;


zvel -= obj_Game.area_gravity;

// apply friction
var _friction_drag = 0.03
var _friction_ground = 0.12;

if (_onfloor)
{
	xvel *= 1.00 - _friction_ground - _friction_drag;
	yvel *= 1.00 - _friction_ground - _friction_drag;
	zvel *= 1.00 - _friction_drag;
}
else
{
	xvel *= 1.00 - _friction_drag;
	yvel *= 1.00 - _friction_drag;
	zvel *= 1.00 - (_friction_drag * 0.5);
}


if (movelock_time > 0) {
	_hor = 0;
	_vertical = 0;
}

var _nx = x + xvel;
var _ny = y + lerp(yvel, (window_get_height() / window_get_width()) * yvel, 0.25);

if (_grid_collide != 0) {
	
	if (xvel != 0) {
		if (!grid_place_meeting_pos(_nx, y, _grid_collide)) {
			x = _nx;
		} else {
			while (!grid_place_meeting_pos(sign(xvel) + x, y, _grid_collide)) {
				x += sign(xvel);
			}
			xvel = 0;
		}
	}
	
	if (yvel != 0) {
		if (!grid_place_meeting_pos(x, _ny, _grid_collide)) {
			y = _ny;
		} else {
			while (!grid_place_meeting_pos(x, sign(yvel) + y, _grid_collide)) {
				y += sign(yvel);
			}
			yvel = 0;
		}
	}
}
else {
	x = _nx;
	y = _ny;
}


var _anim_index = s_Disciple;
var _start_frame = 0;
var _anim_length = 0;
var _anim_speed = 0;

switch (anim)
{
	// front facing
	case anim_idle:
		_start_frame	= 0;
		_anim_length	= 2;
		_anim_speed		= 40;
	break;
		
	case anim_run:
		_start_frame	= 2;
		_anim_length	= 4;
		_anim_speed		= 15;
	break;
	
	case anim_jump:
		_start_frame	= 6;
		_anim_length	= 0;
		_anim_speed		= 0;
	break;
	
	// back facing
	case anim_idle_back:
		_start_frame	= 9;
		_anim_length	= 2;
		_anim_speed		= 40;
	break;
	
	case anim_run_back:
		_start_frame	= 11;
		_anim_length	= 4;
		_anim_speed		= 15;
	break;
	
	case anim_jump_back:
		_start_frame	= 15;
		_anim_length	= 0;
		_anim_speed		= 0;
	break;
	
	// attack
	case anim_atk:
		_start_frame	= 18;
		_anim_length	= 0;
		_anim_speed		= 0;
	break;
	
	case anim_atk_back:
		_start_frame	= 27;
		_anim_length	= 0;
		_anim_speed		= 0;
	break;
}

anim_current_frame = floor(anim_tick / _anim_speed);

if (anim == anim_run || anim == anim_run_back)
{
	var _current_frame = image_index;
	if ((anim_current_frame == 3 || anim_current_frame == 1) && !footstepcreated && z <= 0) //onground
	{
		footstepcreated = true;
		var _footoffsetx = 0;
		var _footoffsety = 0;
		
		if _vertical != 0
			_footoffsetx = (anim_current_frame-2)*-2;
		if _hor != 0
			_footoffsety = (anim_current_frame-2)*-2;
			
		audio_play_sound(choose(asset_get_index(_type + "Step1"),
								asset_get_index(_type + "Step2"),
								asset_get_index(_type + "Step3")),
								1, 0, (0.3+random(0.1))/(distance_to_object(Player)/_snd_footstep_falloff), 0, 0.9 + (anim_current_frame-1)/10 + random(0.1));

		{
			var _p = instance_create_depth(x+_footoffsetx,y+6+_footoffsety,0,obj_Particle);
			
			switch _type {
				case "Cloud":
					_p.sprite_index = spr_cloud_step;
					break;
				case "Dirt":
					_p.sprite_index = spr_dirt_step;
					break;
				case "Gravel":
					_p.sprite_index = spr_stone_step;
					break;
				case "Stone":
					_p.sprite_index = spr_stone_step;
					break;
				default:
					_p.sprite_index = spr_stone_step;
					break;
			}
			_p.image_speed = 0.125;
			_p.image_xscale = 1;
			_p.image_yscale = 1;
			_p.xvel = (xvel * -0.25) + random_range(-0.5, 0.5);
			_p.yvel = (yvel * -0.25) + random_range(-0.2, 0.2);
		}
		{
			var _p = instance_create_depth(x+_footoffsetx,y+6+_footoffsety,0,obj_Particle);
			_p.sprite_index = sFootstep;
			_p.image_speed = 0;
			_p.image_xscale = 1;
			_p.image_yscale = 1;
			_p.xvel = 0;
			_p.yvel = 0;
			_p.image_angle = point_direction(xprevious,yprevious,x,y);
		}
	}
	
	if (anim_current_frame == 2 || anim_current_frame == 0)
	{
		footstepcreated = false;
	}
}

if (abs(xvel) > 0 || abs(yvel) > 0)
{
	if (0.05 > abs(xvel) || 0.05 > abs(yvel))
	{
		if (_hor == 0 && _vertical == 0 && z <= 0)
		{
			if (!stopsoundplayed)
			{
				stopsoundplayed = true;
			
				audio_play_sound(asset_get_index(_type + "StepStop"),
									1, 0, (0.4+random(0.1))/(distance_to_object(Player)/_snd_footstep_falloff), 0, 0.9 + random(0.1));
				{
					var _p = instance_create_depth(x+3,y+6,0,obj_Particle);
					_p.sprite_index = sFootstep;
					_p.image_speed = 0;
					_p.xvel = 0;
					_p.yvel = 0;
					_p.image_angle = point_direction(xprevious,yprevious,x,y);
				}
				{
					var _p = instance_create_depth(x-1,y+6,0,obj_Particle);
					_p.sprite_index = sFootstep;
					_p.image_speed = 0;
					_p.xvel = 0;
					_p.yvel = 0;
					_p.image_angle = point_direction(xprevious,yprevious,x,y);
				}
			}
		}
		else
		{
			stopsoundplayed = false;
		}
	}
}

if (_hor != 0 || _vertical != 0)
{
	if (_left || _right)
	{
		bothx = false;
		if !(_left && _right) /// prevent both at same time
		{
			lastdirx = _left - _right;
		}
		else
		{
			bothx = true;
		}
				
		if (!_down)
		{
			lastdiry = -1;
		}
	}
	if (_up || _down)
	{
		bothy = false;
		if !(_up && _down) /// prevent both at same time
		{
			lastdiry = _up - _down;
		}
		else
		{
			bothy = true;
		}
	}	
}

switch (characterstate)
{
	case 0: 
		image_xscale = -lastdirx;

		if (jumpingstate) 
		{
			if (lastdiry == 1) {
				anim = anim_jump_back;
			} else {
				anim = anim_jump;
			}
			
			if (zvel > 1) {
				anim_frame = 0;
			}
			else if zvel < 0 {
				anim_frame = 2;
			}
			else
			{
				anim_frame = 1;
			}
		}
		else
		{
			if (_hor != 0 || _vertical != 0)
			{
				if (lastdiry == 1)
				{
					anim = anim_run_back;
				}
				else {
					anim = anim_run;
				}
			}
			else
			{
				if (lastdiry == 1)
				{
					anim = anim_idle_back;
				}
				else {
					anim = anim_idle;
				}
			}
		}
	break;
	case 1:
		image_xscale = -lastdirx;
	
		if (lastdiry == 1)
		{
			anim = anim_atk_back;
		}
		else {
			anim = anim_atk;
		}
		
		_anim_speed = 0;
	break;
	case 2:
		image_xscale = -lastdirx;
	
		if (lastdiry == 1)
		{
			anim = anim_atk_back;
		}
		else {
			anim = anim_atk;
		}
		
		_anim_speed = 0;
	break;
}







if (attack_time > 0) attack_time --;
if (hitflash_time > 0) hitflash_time --;
if (movelock_time > 0) movelock_time --;

if (anim != old_anim)
{
	anim_frame = 0;
	anim_tick = 0;
	old_anim = anim;
}

sprite_index = _anim_index;
if (_anim_speed > 0) image_index = _start_frame + floor(anim_tick / _anim_speed);
else image_index = _start_frame + anim_frame;

if (image_index > _start_frame + _anim_length - 1)
	anim_tick = 0;

anim_tick ++;