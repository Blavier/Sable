// Define the squash and stretch factor
var _squash_factor = 0.10; // Adjust this value to control the intensity of squash and stretch

// Calculate the image scale based on zvel
var _image_yscale = 1 + (abs(zvel) * _squash_factor);
var _image_xscale = 1 - (abs(zvel) * _squash_factor);

draw_sprite_ext(spr_coin, 0, x, y+3, image_xscale, image_yscale, 0, c_black, 0.1);

image_xscale = _image_xscale;
image_yscale = _image_yscale;

// Update the position
y -= z;
draw_self();
y += z;
