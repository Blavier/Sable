if (movelock_time > 0)
{
	// Locked in place
	movelock_time --;
}
else
{
	// Physics
	
	// Magnet to player
	if (distance_to_object(Player) < 34)
	{
		//xvel += lengthdir_x(0.125, point_direction(x,y,Player.x,Player.y))
		//yvel += lengthdir_y(0.125, point_direction(x,y,Player.x,Player.y))
	}
	
	// Slowing forces
	if (z == 0)
	{
		xvel *= 1 - ground_friction - air_drag;
		yvel *= 1 - ground_friction - air_drag;
	}
	else
	{
		xvel *= 1 - air_drag;
		yvel *= 1 - air_drag;
	}
	
	if (z > 0)
	{
		// Fall to ground
		zvel -= obj_Game.area_gravity;	
	}
	else
	{
		z = 0;
	
		// Bounce off ground
		zvel *= -elasticity;
		
		if (abs(zvel) > 0.1)
		{
			audio_play_sound(snd_coindrop,5,false,0.4,0,1);
		}
	
		movelock_time = floor(zvel*4);
	}

	// Apply velocity
	x += xvel;
	y += yvel;
	z += zvel;
}

z = clamp(z, 0, 999);