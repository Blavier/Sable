//audio_listener_position(x,y,-1);
//audio_listener_velocity(xvel, yvel, 0);

var SpeedNormal = 0.12;

var SpeedDiagonal = SpeedNormal * 0.707;

var _left = keyboard_check(vk_left);
var _right = keyboard_check(vk_right);
var _up = keyboard_check(vk_up);
var _down = keyboard_check(vk_down);

var space = keyboard_check_pressed(vk_space);

var onground = obj_Game.grid_floor[# Player.x div CELL_WIDTH, Player.y div CELL_HEIGHT] == FLOOR;


var _tilemap_id = layer_tilemap_get_id(layer_get_id("Tiles_ground"));
var _data = tilemap_get_at_pixel(_tilemap_id, x, y);
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


if (z > 0)
{
	// Fall to ground
	zvel -= obj_Game.area_gravity;

	landsoundplayed = false;
}
else
{
	// On ground
	if (onground)
	{
		if (zvel < -0.05)
		{
			if (!landsoundplayed)
			{
				landsoundplayed = true;
				
				audio_play_sound(asset_get_index(_type + "StepStop"),
								1, 0, 0.4+random(0.1), 0, 0.9 + random(0.1));


				{
					var _p = instance_create_depth(x+2,y+6,0,obj_Particle);
					_p.sprite_index = sFootstep;
					_p.image_speed = 0;
					_p.image_xscale = 1;
					_p.image_yscale = 1;
					_p.xvel = 0;
					_p.yvel = 0;
					_p.image_angle = point_direction(xprevious,yprevious,x,y);
				}
				{
					var _p = instance_create_depth(x-1,y+6,0,obj_Particle);
					_p.sprite_index = sFootstep;
					_p.image_speed = 0;
					_p.image_xscale = 1;
					_p.image_yscale = 1;
					_p.xvel = 0;
					_p.yvel = 0;
					_p.image_angle = point_direction(xprevious,yprevious,x,y);
				}
			
				if (jumpingstate != 0)
				{
					jumpingstate = 0;
				}
			
				landing_time = 14;
			}
		}
		zvel = 0;
		z = 0;
	}
	else
	{
		zvel -= obj_Game.area_gravity;	
		
		if z < -600 room_restart();
	}
}

if (space) jump_time = 14;

if (jump_time > 0)
{
	jump_time--;
	if z <= 0 && onground {
		zvel = 1.30;

		audio_play_sound(jump,1,false,0.3,0,1);
		
		jumpingstate = 1;
	
		var _p = instance_create_depth(x,y+6,0,obj_Particle);
		_p.sprite_index = spr_cloud_step;
		_p.image_speed = 0.5;
		_p.xvel = random_range(-0.4, 0.4);
		_p.yvel = random_range(-0.1, -0.4);
	}
}

z += zvel;

var hor = (_right - _left);
var vertical = (_down - _up);

if (movelock_time > 0)
{
	xvel = 0;
	yvel = 0;
}

if (hor != 0 && vertical != 0) {
	xvel += hor * SpeedDiagonal;
	yvel += vertical * SpeedDiagonal;
} else {
	xvel += hor * SpeedNormal;
	yvel += vertical * SpeedNormal;
}

var _anim_index = sSable;
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
}

anim_current_frame = floor(anim_tick / _anim_speed);

if (anim == anim_run || anim == anim_run_back)
{
	var _current_frame = image_index;
	if ((anim_current_frame == 3 || anim_current_frame == 1) && !footstepcreated && onground && z <= 0)
	{
		footstepcreated = true;
		var _footoffsetx = 0;
		var _footoffsety = 0;
		
		if vertical != 0
			_footoffsetx = (anim_current_frame-2)*-2;
		if hor != 0
			_footoffsety = (anim_current_frame-2)*-2;
			
		audio_play_sound(choose(asset_get_index(_type + "Step1"),
								asset_get_index(_type + "Step2"),
								asset_get_index(_type + "Step3")),
								1, 0, 0.3+random(0.1), 0, 0.9 + (anim_current_frame-1)/10 + random(0.1));

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
			_p.xvel = random_range(-0.5, 0.5);
			_p.yvel = random_range(-0.2, 0.2);
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
		if (hor == 0 && vertical == 0 && z <= 0)
		{
			if (!stopsoundplayed)
			{
				stopsoundplayed = true;
			
				audio_play_sound(asset_get_index(_type + "StepStop"),
									1, 0, 0.4+random(0.1), 0, 0.9 + random(0.1));
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
			
			if (zvel > 0) {
				anim_frame = 0;
			}
			else {
				anim_frame = 1;
			}
		}
		else
		{
			if (hor != 0 || vertical != 0)
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
}


var _collidewithgrid = obj_Game.grid;

xvel *= 0.86; //0.86
x += xvel;

if (xvel > 0) {
	if (grid_place_meeting(id, _collidewithgrid)) {
		x = bbox_right&~(CELL_WIDTH+0);
		x -= bbox_right-x+1;
		xvel = 0;
	}
}
else if (xvel < 0) {
	if (grid_place_meeting(id, _collidewithgrid)) {
		x = bbox_left&~(CELL_WIDTH-1);
		x += CELL_WIDTH+x-bbox_left;
		xvel = 0;
	}
}

yvel *= 0.86;
y += lerp(yvel, (window_get_height() / window_get_width()) * yvel, 0.25);

if yvel > 0 {
	if (grid_place_meeting(id, _collidewithgrid)) {
		y = bbox_bottom&~(CELL_HEIGHT+0);
		y -= bbox_bottom-y+1;
		yvel = 0;
	}
} else if yvel < 0 {
	if (grid_place_meeting(id, _collidewithgrid)) {
		y = bbox_top&~(CELL_HEIGHT-1);
		y += CELL_HEIGHT+y-bbox_top;
		yvel = 0;
	}
}

if (hitpoints < 0)
{
	with (Checkpoint)
	{
		if (ischecked)
		{
			other.x = x;
			other.y = y;
			other.xvel = 0;
			other.yvel = 0;
			
			other.hitpoints = other.maxhitpoints;
		}
	}
}

if (hitflash_time > 0) hitflash_time --;
if (movelock_time > 0) movelock_time --;


if (anim != old_anim)
{
	anim_frame = 0;
	anim_tick = 0;
	old_anim = anim;
}

sprite_index = _anim_index;
if (_anim_speed > 0)
{
	image_index = _start_frame + floor(anim_tick / _anim_speed);
}
else
{
	image_index = _start_frame + anim_frame;
}

if (image_index > _start_frame + _anim_length - 1)
	anim_tick = 0;

anim_tick ++;