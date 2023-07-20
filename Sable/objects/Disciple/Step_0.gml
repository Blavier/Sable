event_inherited(); //so it will inherit from par_speaker


var SpeedNormal = 0.05;
var SpeedDiagonal = SpeedNormal * 0.707;

if (random(1) < 0.003)
{
	ai_x = choose(1, 2);
}
if (random(1) < 0.003)
{
	ai_y = choose(1, 2);
}

var left = 0;
var right = 0;
var up = 0;
var down = 0;

if !instance_exists(obj_textbox)
{
	if (ai_x == 1 || ai_x == 2)
	{
		//move on axis
		if (ai_x == 1) left = 1;
		else right = 1;
	
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
		if (ai_y == 1) up = 1;
		else down = 1;
	
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

if ((hor != 0 || vertical != 0))
{
	if (obj_Game.gametime % 20 == 0)
	{
		{
			var particle = instance_create_depth(x,y+8,0,obj_Particle);
			particle.sprite_index = sShadow;
			particle.image_speed = 0.25;
			particle.image_xscale = 0.5;
			particle.image_yscale = 0.5;
			particle.xvel = random_range(-0.4, 0.4);
			particle.yvel = random_range(-0.1, -0.4);
		}
		{
			var particle = instance_create_depth(x,y+8,0,obj_Particle);
			particle.sprite_index = sFootstep;
			particle.image_speed = 0;
			particle.image_xscale = 1;
			particle.image_yscale = 1;
			particle.xvel = 0;
			particle.yvel = 0;
		}
	}
}

switch (characterstate)
{
	case 0: 
	
		image_xscale = -lastdirx;

		if (up || left || down || right)
		{
			if (left || right)
			{
				lastdirx = left - right;
				
				if (!down)
				{
					lastdiry = -1;
				}
			}
			if (up || down)
			{
				lastdiry = up - down;
			}
		
			if (lastdiry == 1)
			{
				sprite_index = s_Disciple_behind;
			}
			else {
				sprite_index = s_Disciple;
			}
			
			image_speed = 0.25;	
		}
		else
		{
			if (lastdiry == 1)
			{
				sprite_index = s_Disciple_stand;
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
				sprite_index = s_Disciple_stand;
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
		sprite_index = s_Disciple;
		image_speed = 1;	
	break;
}

var max_xspeed = 15;
var max_yspeed = 15;

// Set up the grid
width_ = room_width div CELL_WIDTH;
height_ = room_height div CELL_HEIGHT;
_grid = ds_grid_create(width_, height_);

//ds_grid_set_region(_grid, 0, 0, width_ - 1, height_ - 1, VOID);

collidewithgrid = _grid;

xvel = clamp(xvel, -max_xspeed, max_xspeed);
xvel *= 0.9;
x += xvel;

if (xvel > 0) {
	if (grid_place_meeting(id, collidewithgrid)) {
		x = bbox_right&~(CELL_WIDTH-1);
		x -= bbox_right-x;
		xvel = 0;
	}
}
else if (xvel < 0) {
	if (grid_place_meeting(id, collidewithgrid)) {
		x = bbox_left&~(CELL_WIDTH-1);
		x += CELL_WIDTH+x-bbox_left;
		xvel = 0;
	}
}

yvel = clamp(yvel, -max_yspeed, max_yspeed);
yvel *= 0.9;
y += yvel;

if yvel > 0 {
	if (grid_place_meeting(id, collidewithgrid)) {
		y = bbox_bottom&~(CELL_HEIGHT-1);
		y -= bbox_bottom-y;
		yvel = 0;
	}
} else if yvel < 0 {
	if (grid_place_meeting(id, collidewithgrid)) {
		y = bbox_top&~(CELL_HEIGHT-1);
		y += CELL_HEIGHT+y-bbox_top;
		yvel = 0;
	}
}

if (hitflash_time > 0) hitflash_time --;
if (movelock_time > 0) movelock_time --;