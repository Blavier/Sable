//audio_listener_position(x,y,-1);
//audio_listener_velocity(xvel, yvel, 0);

var SpeedNormal = 0.12;

var SpeedDiagonal = SpeedNormal * 0.707;

var left = keyboard_check(vk_left);
var right = keyboard_check(vk_right);
var up = keyboard_check(vk_up);
var down = keyboard_check(vk_down);

var space = keyboard_check(vk_space);

var onground = obj_Game.grid_floor[# Player.x div CELL_WIDTH, Player.y div CELL_HEIGHT] == FLOOR;

if (space) jump_time = 10;

if (jump_time > 0)
{
	jump_time--;
	if z <= 0 && onground {
		zvel = 1.80;
		
		xvel *= 1.15;
		yvel *= 1.15;

		audio_play_sound(jump,1,false,0.3,0,1);
		
		jumpingstate = 1;
	
		var _p = instance_create_depth(x,y+6,0,obj_Particle);
		_p.sprite_index = spr_snow_dust;
		_p.image_speed = 0.5;
		_p.xvel = random_range(-0.4, 0.4);
		_p.yvel = random_range(-0.1, -0.4);
	}
}

if (z > 0)
{
	// Fall to ground
	zvel -= obj_Game.area_gravity;	
}
else
{
	// On ground
	if (onground)
	{
		if (z <= 0)
		{
			if (zvel < -0.05)
			{
				audio_play_sound(land,1,false,0.3,0,1);


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
			zvel = 0;
			z = 0;
		}
	}
	else
	{
		zvel -= obj_Game.area_gravity;	
		
		if z < -200 room_restart();
	}
}
z += zvel;

var hor = (right - left);
var vertical = (down - up);

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

if (sprite_index == sSable || sprite_index == sSable_behind)
{
	var _current_frame = floor(image_index);
	if ((_current_frame == 3 || _current_frame == 1) && !footstepcreated)
	{
		footstepcreated = true;
		var _footstepoffsetx = 0;
		var _footstepoffsety = 0;
		
		if vertical != 0
			_footstepoffsetx = (_current_frame-2)*2;
		
		if hor != 0
			_footstepoffsety = (_current_frame-2)*1;
			
		if (_current_frame == 3)
		{
			audio_play_sound(choose(DirtStep1, DirtStep2, DirtStep3), 1, 0, 0.3+random(0.1), 0, 1.0+random(0.1))
		}
		else
		{
			audio_play_sound(choose(DirtStep1, DirtStep2, DirtStep3), 1, 0, 0.3+random(0.1), 0, 1.15+random(0.1))
		}
		
		{
			var _p = instance_create_depth(x+_footstepoffsetx,y+6+_footstepoffsety,0,obj_Particle);
			_p.sprite_index = spr_snow_dust;
			_p.image_speed = 0.25;
			_p.image_xscale = 1	;
			_p.image_yscale = 1;
			_p.xvel = random_range(-0.4, 0.4);
			_p.yvel = random_range(-0.1, -0.4);
		}
		{
			var _p = instance_create_depth(x+_footstepoffsetx,y+6+_footstepoffsety,0,obj_Particle);
			_p.sprite_index = sFootstep;
			_p.image_speed = 0;
			_p.image_xscale = 1;
			_p.image_yscale = 1;
			_p.xvel = 0;
			_p.yvel = 0;
			_p.image_angle = point_direction(xprevious,yprevious,x,y);
		}
	}
	
	if (_current_frame == 2 || _current_frame == 0)
	{
		footstepcreated = false;
	}
}

switch (characterstate)
{
	case 0: 
		image_xscale = -lastdirx;

		if (hor != 0 || vertical != 0)
		{
			if (left || right)
			{
				bothx = false;
				if !(left && right) /// prevent both at same time
				{
					lastdirx = left - right;
				}
				else
				{
					bothx = true;
				}
				
				if (!down)
				{
					lastdiry = -1;
				}
			}
			if (up || down)
			{
				bothy = false;
				if !(up && down) /// prevent both at same time
				{
					lastdiry = up - down;
				}
				else
				{
					bothy = true;
				}
				
			}
		
			if (lastdiry == 1)
			{
				sprite_index = sSable_behind;
			}
			else {
				sprite_index = sSable;
			}
			
			image_speed = 0.3;	
		}
		else
		{
			if (lastdiry == 1)
			{
				sprite_index = sSable_stand;
				if (obj_Game.gametime % 60 > 30)
				{
					image_index = 2;
				}
				else
				{
					image_index = 3;
				}
			}
			else {
				sprite_index = sSable_stand;
				if (obj_Game.gametime % 60 > 30)
				{
					image_index = 0;
				}
				else
				{
					image_index = 1;
				}
			}
			
			image_speed = 0;	
		}	
	break;

	case 1: // etc
		sprite_index = sSable;
		image_speed = 1;	
	break;
}


var _collidewithgrid = obj_Game.grid;

xvel *= 0.88;
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

yvel *= 0.88;
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