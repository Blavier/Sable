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
		var _absxvel = abs(playerobject.xvel);
		var _absyvel = abs(playerobject.yvel);
		//make the player face me is they arent moving
		if (_absxvel < 0.5 && _absyvel < 0.5)
		{
			if (x < playerobject.x)
			{
				playerobject.lastdirx = 1;
			}
			else
			{
				playerobject.lastdirx = -1;
			}
			
			if (y < playerobject.y)
			{
				playerobject.lastdiry = 1;
			}
			else
			{
				playerobject.lastdiry = -1;
			}
		}
		
		
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