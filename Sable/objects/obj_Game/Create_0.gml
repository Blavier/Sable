randomize();

//window_set_fullscreen(true);

//show_debug_overlay(true);

freezetime = 0;
gametime = 0;

if room == Clouds
	area_gravity = 0.02;
else
	area_gravity = 0.05;

// Set up the grid
width_ = room_width div CELL_WIDTH;
height_ = room_height div CELL_HEIGHT;


grid_empty = ds_grid_create(width_, height_);
ds_grid_set_region(grid_empty, 0, 0, width_ - 1, height_ - 1, VOID);

grid_ground = ds_grid_create(width_, height_);
ds_grid_set_region(grid_ground, 0, 0, width_ - 1, height_ - 1, VOID);

var _tilemap_id_2 = layer_tilemap_get_id(layer_get_id("Tiles_ground"));

for (var _y = 0; _y < height_; _y++) {
	for (var _x = 0; _x < width_; _x++) {		
		var _data = tilemap_get_at_pixel(_tilemap_id_2, _x*CELL_WIDTH,_y*CELL_HEIGHT) & tile_index_mask;
		if _data != 0 {
			grid_ground[# _x, _y] = FLOOR;
		}
	}
}



grid_middle = ds_grid_create(width_, height_);

ds_grid_set_region(grid_middle, 0, 0, width_ - 1, height_ - 1, VOID);

var _tilemap_id_3 = layer_tilemap_get_id(layer_get_id("Tiles_middle"));

for (var _y = 0; _y < height_; _y++) {
	for (var _x = 0; _x < width_; _x++) {		
		var _data = tilemap_get_at_pixel(_tilemap_id_3, _x*CELL_WIDTH,_y*CELL_HEIGHT) & tile_index_mask;
		if _data != 0 {
			grid_middle[# _x, _y] = FLOOR;
		}
	}
}



grid_top = ds_grid_create(width_, height_);

ds_grid_set_region(grid_top, 0, 0, width_ - 1, height_ - 1, VOID);

var _tilemap_id_4 = layer_tilemap_get_id(layer_get_id("Tiles_top"));

for (var _y = 0; _y < height_; _y++) {
	for (var _x = 0; _x < width_; _x++) {		
		var _data = tilemap_get_at_pixel(_tilemap_id_4, _x*CELL_WIDTH,_y*CELL_HEIGHT) & tile_index_mask;
		if _data != 0 {
			grid_top[# _x, _y] = FLOOR;
		}
	}
}


alarm[0] = 400;