var SpeedNormal = 0.1;
var SpeedDiagonal = SpeedNormal * 0.707;

if (random(1) < 0.005)
{
	ai_x = choose(1, 2);
}
if (random(1) < 0.005)
{
	ai_y = choose(1, 2);
}

var left = 0;
var right = 0;
var up = 0;
var down = 0;

if (ai_x == 1 || ai_x == 2)
{
	//move on axis
	if (ai_x == 1) left = 1;
	else right = 1;
	
	if (random(1) < 0.01)
	{
		if (random(1) < 0.4)
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
	
	if (random(1) < 0.01)
	{
		if (random(1) < 0.4)
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
				sprite_index = sButterfly;
			}
			else {
				sprite_index = sButterfly;
			}
			
			image_speed = 0.3;	
		}
		else
		{
			if (lastdiry == 1)
			{
				sprite_index = sButterfly;
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
				sprite_index = sButterfly;
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
		sprite_index = sButterfly;
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
y += yvel;

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

if (hitflash_time > 0) hitflash_time --;
if (movelock_time > 0) movelock_time --;