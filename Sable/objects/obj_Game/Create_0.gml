randomize();

//window_set_fullscreen(true);

//show_debug_overlay(true);

freezetime = 0;
gametime = 0;

area_gravity = 0.05;

// Set up the grid
width_ = room_width div CELL_WIDTH;
height_ = room_height div CELL_HEIGHT;
grid = ds_grid_create(width_, height_);

ds_grid_set_region(grid, 0, 0, width_ - 1, height_ - 1, VOID);

var _tilemap_id = layer_tilemap_get_id(layer_get_id("Walls"));

for (var _y = 0; _y < height_; _y++) {
	for (var _x = 0; _x < width_; _x++) {		
		var _data = tilemap_get_at_pixel(_tilemap_id, _x*CELL_WIDTH,_y*CELL_HEIGHT) & tile_index_mask;
		if _data != 0 {
			grid[# _x, _y] = WALL;
		}
		else {
			// No tile
		}
		//show_debug_message(string(_x) + "   " + string(_y));
	}
	
}

grid_floor = ds_grid_create(width_, height_);

ds_grid_set_region(grid, 0, 0, width_ - 1, height_ - 1, VOID);

var _tilemap_id_2 = layer_tilemap_get_id(layer_get_id("Tiles_ground"));

for (var _y = 0; _y < height_; _y++) {
	for (var _x = 0; _x < width_; _x++) {		
		var _data = tilemap_get_at_pixel(_tilemap_id_2, _x*CELL_WIDTH,_y*CELL_HEIGHT) & tile_index_mask;
		if _data != 0 {
			grid_floor[# _x, _y] = FLOOR;
		}
		else {
			// No tile
		}
		//show_debug_message(string(_x) + "   " + string(_y));
	}
	
}
//audio_play_sound(choose(ActionCalling_v2, battle__1_, bells, donkey__1_, ending, important, optimistic__2_, unfinished, Cave, CasinoEncounter, battle_variation2), 1, 1, 0.7);