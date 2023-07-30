// get input
var _up = keyboard_check_pressed(vk_up);
var _down = keyboard_check_pressed(vk_down);
var _left = keyboard_check_pressed(vk_left);
var _right = keyboard_check_pressed(vk_right);
var _left_held = keyboard_check(vk_left);
var _right_held = keyboard_check(vk_right);
var _select = keyboard_check_pressed(vk_enter) or keyboard_check_pressed(vk_space) or keyboard_check_pressed(ord("E"));

// holding down key
_repeat_spd = 10;
_repeat_delay = 29;

// holding right
if _right time_held_right = _repeat_delay;
if time_held_right > 0 {
	time_held_right--;
	if time_held_right == 0 and _right_held {
		_right = true;
		time_held_right = _repeat_spd;	
	}
}

// holding left
if _left time_held_left = _repeat_delay;
if time_held_left > 0 {
	time_held_left--;
	if time_held_left == 0 and _left_held {
		_left = true;
		time_held_left = _repeat_spd;	
	}
}

var _move = _down - _up;
var _hmove = _right - _left;

if (_move != 0) {
	
	audio_play_sound(UI_move, 1, 0, 1, 0, 1.5);
	
	index += _move;	
	
	var _size = array_length(menu[sub_menu]);
	
	if (index < 1) index = _size - 1;
	else if (index >= _size) index = 1;
}
	
function process_menu(_select, _hmove, _mouse) {
	// button pressed
	if _select or (is_array(menu[sub_menu][index]) and (_hmove != 0)) {
		
		var isbutton = false;
		
		switch(sub_menu) {
			case MAIN:
				switch(index) {
					case 1: // Play
						sub_menu = PLAY;
						index = 1;
						isbutton = true;
					break;
					case 2: // Settings
						sub_menu = SETTINGS;
						index = 1;
						isbutton = true;
					break;
					case 3: // Quit to Desktop
						game_end();
						isbutton = true;
					break;
				}
			break;
			case PLAY:
				switch(index) {
					case 1:
						room_goto(Clouds);
						audio_stop_all();
						isbutton = true;
					break;
					case 2:
						room_goto(Clouds);
						audio_stop_all();
						isbutton = true;
					break;
					case 3: // Back
						sub_menu = MAIN;
						index = 1; // return to index
						isbutton = true;
					break;
				}
			break;
			case SETTINGS:
				switch(index) {
					case 1: // Graphics
						sub_menu = GRAPHICS;
						index = 1;
						isbutton = true;
					break;
					case 2: // Audio
						sub_menu = AUDIO;
						index = 1;
						isbutton = true;
					break;
					case 3: // Controls
						sub_menu = CONTROLS;
						index = 1;
						isbutton = true;
					break;
					case 4: // Back
						sub_menu = MAIN;
						index = 2; // return to index
						isbutton = true;
					break;
				}
			break;
			case GRAPHICS:
				switch(index) {
					case 1:
						change_menu(_hmove, "fullscreen", _mouse);
					break;
					case 2:
						change_menu(_hmove, "graphics_quality", _mouse);
					break;
					case 3:
						change_menu(_hmove, "subtitles", _mouse);
					break;
					case 4:
						change_menu(_hmove, "text_speed", _mouse);
					break;
					case 5: // Back
						sub_menu = SETTINGS;
						index = 1; // return to index
						isbutton = true;
					break;
				}
			break;
			case AUDIO:
				switch(index) {
					case 1: // Sound
						change_menu(_hmove, "sound", _mouse);
					break;
					case 2: // Music
						change_menu(_hmove, "music", _mouse);
					break;
					case 3: // Back
						sub_menu = SETTINGS;
						index = 2; // return to index
						isbutton = true;
					break;
				}
			break;
			case CONTROLS:
				switch(index) {
					case 1: // 1
						change_menu(_hmove, "sound", _mouse);
					break;
					case 2: // 2
						change_menu(_hmove, "music", _mouse);
					break;
					case 3: // Back
						sub_menu = SETTINGS;
						index = 3; // return to index
						isbutton = true;
					break;
				}
			break;
		}
		
		// play the selection sound 
		if (isbutton) {
			if (_mouse && _hmove == 0) {
				if (_select) audio_play_sound(UI_select, 1, 0, 1, 0, 1.5);
			} else {
			
				if (_select) audio_play_sound(UI_select, 1, 0, 1, 0, 1.5);
			}
		}
	}
}

process_menu(_select, _hmove, false);

function change_menu(_move, _key, _mouse) {
	///@desc	change the ds map key entry by the move value passed
	///@_move	real	whichway to move the selection
	///@_key	string	ds_map key for this selection
	
	// get the allowed limits for this selection
	// get the map array
	var _map_array = set[? _key];
	// get the limits array
	var _limits_array = _map_array[1];
	
	// is this first entry in the limits an integer?
	if is_real(_limits_array[0]) {
		// limits are the index pos 0 & 1
		var _min = _limits_array[0];
		var _max = _limits_array[1];
	} else {
		// string entries, so limits are 0 and size of the array-1
		var _min = 0;
		var _max = array_length(_limits_array) - 1;
	}
	
	var _previous_map = _map_array[0];
	
	// move the selection
	_map_array[@ 0] = clamp(_move + _map_array[0], _min, _max);
	
	if (_map_array[0] != _previous_map)
	{
		audio_play_sound(UI_tweak, 5, 0);
	}
	else if (time_held_right != _repeat_spd && time_held_left != _repeat_spd) {
		if (_mouse) {
			if _move != 0 audio_play_sound(UI_fail, 5, 0);
		} else {
			audio_play_sound(UI_fail, 5, 0);
		}
	}
}

/*
if (sub_menu == MAIN || sub_menu == PLAY)
{
	// main menu
	audio_sound_gain(PizTheme, 1, 600);
	audio_sound_gain(PizTheme_alt, 0, 600);
}
else{
	// in options
	audio_sound_gain(PizTheme, 0, 600);
	audio_sound_gain(PizTheme_alt, 1, 600);
}
*/
if (fade_in_time > 0)
{
	fade_in_time--;
}
/*
if (fade_in_time == 250)
{
	audio_play_sound(PizTheme, 10, 1);
	audio_play_sound(PizTheme_alt, 10, 1);
	audio_sound_gain(PizTheme_alt, 0, 0);
}