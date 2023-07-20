depth = -y;

var _onground = obj_Game.grid_floor[# Player.x div CELL_WIDTH, Player.y div CELL_HEIGHT] == FLOOR;

var _squash_factor = 0.06;

// Calculate the image scale based on zvel
var _image_yscale = 1 + (abs(zvel) * _squash_factor);
var _image_xscale = 1 - (abs(zvel) * _squash_factor);

// Scale when nearer to camera in sky
_image_yscale += z / 1000;
_image_xscale += z / 1000;

var _shadow_scale = max(0.1, 1 - (z / 150)); 
if (_onground) draw_sprite_ext(sShadow, 0, x, y+7, _shadow_scale, _shadow_scale, 0, c_black, 0.25);


if (hitflash_time > 0) shader_set(sh_white);
y -= z;
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale*_image_xscale, _image_yscale, 0, c_white, 1);
y += z;
shader_reset();


draw_set_color(c_black);

//draw_text(x + 50, y + 20, _type);

//draw_sprite_ext(sPlayerArm, guntype, x, y+3-zlevel, 1, 1, point_direction(x,y-zlevel,mouse_x,mouse_y), c_white, 1);


//draw_text(x,y+30,"zvel: " + string(zvel));
//draw_text(x,y+50,"zlvl: " + string(zlevel));






//draw_sprite_ext(sPlayerStand, 0, x, y, image_xscale, image_yscale, 0, c_black, 0.9);
