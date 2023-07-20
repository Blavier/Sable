audio_play_sound(important, 1, 1);

#macro MAIN 0
#macro SETTINGS 1
#macro GRAPHICS 2
#macro AUDIO 3
#macro CONTROLS 4
#macro PLAY 5
#macro TOTAL 6

global.dsm_settings = ds_map_create();
#macro set global.dsm_settings

ds_map_set(set, "sound", [5, [0, 10]]);
ds_map_set(set, "music", [5, [0, 10]]);

ds_map_set(set, "fullscreen", [0, ["On", "Off"]]);
ds_map_set(set, "graphics_quality", [2, ["Low", "Normal", "High"]]);

ds_map_set(set, "subtitles", [0, ["On", "Off"]]);
ds_map_set(set, "text_speed", [1, ["Slow", "Normal", "Fast", "Instant"]]);

window_set_fullscreen(true);

time_held_left = 0;
time_held_right = 0;

// Sable's Cosmic Odyssey

// main menu
menu[MAIN][0] = "Sable Story";
menu[MAIN][1] = "Play";
menu[MAIN][2] = "Settings";
menu[MAIN][3] = "Quit";

// play submenu
menu[PLAY][0] = "";
menu[PLAY][1] = "Continue";
menu[PLAY][2] = "New Game";
menu[PLAY][3] = "Back";

// settings submenu
menu[SETTINGS][0] = "Settings Menu";
menu[SETTINGS][1] = "Graphics";
menu[SETTINGS][2] = "Audio";
menu[SETTINGS][3] = "Controls";
menu[SETTINGS][4] = "Back";

// graphics submenu
menu[GRAPHICS][0] = "Graphics Menu";
menu[GRAPHICS][1] = ["Fullscreen: ", "fullscreen"];
menu[GRAPHICS][2] = ["Graphics Quality: ", "graphics_quality"];
menu[GRAPHICS][3] = ["Subtitles: ", "subtitles"];
menu[GRAPHICS][4] = ["Text Speed: ", "text_speed"];
menu[GRAPHICS][5] = "Back";

// audio submenu
menu[AUDIO][0] = "Audio Menu";
menu[AUDIO][1] = ["Sound Volume ", "sound"];
menu[AUDIO][2] = ["Music Volume ", "music"];
menu[AUDIO][3] = "Back";

// controls submenu
menu[CONTROLS][0] = "Controls Menu";
menu[CONTROLS][1] = ["Controls: ", "sound"];
menu[CONTROLS][2] = ["Controls: ", "music"];
menu[CONTROLS][3] = "Back";

index = 1; // pointer in menu
sub_menu = MAIN; // current submenu

menu_x_pos = room_width * 0.5;
menu_y_pos = room_height * 0.4;
click_area_w = 35;

function button(_y, _wl, _wr, _h) constructor {
	y = _y;			//selection position y
	wl = _wl;		//click area width left
	wr = _wr;		//click area width right
	h = _h;			//click area height
}

// init a button struct for each menu entry
var _h = 40;
//string_height() // set font before
for (var a = 0; a < TOTAL; ++a) {
    for (var b = 0; b < array_length(menu[a]); ++b) {
	    button_array[a][b] = new button(0, room_width/2, room_width/2, _h);
	}
}


// Fade in
fade_in_time = 580; // 500