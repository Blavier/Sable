if (freezetime > 0) freezetime -= 1;

if (keyboard_check_released(vk_escape) && !keyboard_check(vk_lcontrol))
{
	game_end();	
}

gametime ++; // tick up