draw_set_halign(fa_center);

// row spacing
var _gap = 65;

// draw title
if (sub_menu == MAIN) {
	var font = fnt_title;
	draw_set_font(fnt_title);
} else {
	var font = fnt_menularge;
}

draw_set_font(font);
draw_text_transformed_color(room_width/2, room_height * 0.3 + 1, menu[sub_menu][0], 1.07, 1.07, 0, c_black,c_black,c_black,c_black,0.85);
draw_text_softshadow(room_width/2, room_height * 0.3, menu[sub_menu][0], font, c_white, c_black, 3, 4, 44, 35);

draw_set_font(fnt_menu);

// draw items
var _size = array_length(menu[sub_menu]);
for (var i = 1; i < _size; ++i) {
    if i == index var _col = c_dkgray; else var _col = c_white;
	
	// check if it's plain text or selectable
	if is_array(menu[sub_menu][i]) {
		// store menu array
		var _menu_array = menu[sub_menu][i];
		
		// get the map array
		var _map_array = set[? _menu_array[1]];
		
		// get the limit array or choices array
		var _limits_array = _map_array[1]; // get limits
		
		// is int or text?
		var _str1 = _menu_array[0];
		if is_real(_limits_array[1]) {
			// int to display
			var _str2 = string(_map_array[0]);
		}
		else {
			// string to display
			var _str2 = _limits_array[_map_array[0]];
		}
	}
	else {
		var _str1 = menu[sub_menu][i];
		var _str2 = "";
	}
	
	// set up the y pos and text width
	// get the struct for this menu entry
	var _stc = button_array[sub_menu][i];
	_stc.y = menu_y_pos + _gap * i;
	
	// set different widths if we are on an arry
	if _str2 == "" {
		_stc.wl = string_width(_str1)/2;
		_stc.wr = string_width(_str1)/2;
	} else {
		_stc.wl = string_width(_str1 + " ");
		_stc.wr = string_width(_str2 + " ");
	}
	
	// is the mouse hovering or menu entry?
	var _hovering_over_text = false;
	
	// should mouse control menu?
	if mouse_y >= menu_y_pos and mouse_y <= menu_y_pos + _gap * _size {
		// check which entry mouse is over
		if mouse_y > _stc.y and mouse_y < _stc.y + _stc.h {
			//check x position
			if mouse_x > menu_x_pos - _stc.wl and mouse_x < menu_x_pos + _stc.wr {
				_col = c_dkgray;
				_hovering_over_text = true;
			}
		}
	}
	
	// is this the current index, if so highlight it
	if index == i _col = c_dkgray;
	
	// update the index with the mouse position if this is the selected text
	if _col == c_dkgray {
		// update index
		if (index != i) {
			index = i;
			
			audio_play_sound(UI_move, 5, 0);
		}
		// are we clicking and also over the text?
		if mouse_check_button_pressed(mb_left) and _hovering_over_text {
			// set menu select to true
			var _select = true;
			var _hmove = 0;
			// if menu entry is an array, allow movement
			if is_array(menu[sub_menu][i]) {
				// increment based on click position
				if mouse_x < menu_x_pos - _stc.wl + click_area_w _hmove = -1;
				else if mouse_x > menu_x_pos - click_area_w and mouse_x < menu_x_pos _hmove = 1;
			}
			process_menu(_select, _hmove, true);
			
			// update the size because we could be in new submenu
			_size = array_length(menu[sub_menu]);
		}
	}
	
	// draw text
	if _str2 == "" {
		// simple text
		draw_set_halign(fa_center);
		draw_text_color(menu_x_pos, menu_y_pos + _gap * i, _str1, c_black, c_black, c_black, c_black, 1);
		draw_text_softshadow(-1 + menu_x_pos, -1 + menu_y_pos + _gap * i, _str1, fnt_menu, _col, c_black, 3, 4, 35, 15);
	} else {
		// array text
		draw_set_halign(fa_right);
		draw_text_color(menu_x_pos, menu_y_pos + _gap * i, _str1, c_black, c_black, c_black, c_black, 1);
		draw_text_softshadow(-1 + menu_x_pos, -1 + menu_y_pos + _gap * i, _str1, fnt_menu, _col, c_black, 3, 4, 35, 15);
		
		draw_set_halign(fa_left);
		draw_text_color(menu_x_pos, menu_y_pos + _gap * i, " " + _str2, c_black, c_black, c_black, c_black, 1);
		draw_text_softshadow(-1 + menu_x_pos, -1 + menu_y_pos + _gap * i, " " + _str2, fnt_menu, _col, c_black, 3, 4, 35, 15);
	}
}

// draw transitions
draw_sprite_ext(sBlack,0,0,0,1920,1080,0,c_white, min(fade_in_time, 200)/200);

draw_set_font(fnt_menularge);
if (fade_in_time > 300 && fade_in_time < 475) {
	if (fade_in_time = 474) audio_play_sound(Swell, 5, 0);
	draw_text_color(room_width/2, room_height/2, "Naso Inc. Presents", c_white, c_white, c_white, c_white, 1);	
}
