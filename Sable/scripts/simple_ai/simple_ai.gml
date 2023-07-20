// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function simple_rand_ai()
{
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
}