// Define the squash and stretch factor
var _squash_factor = 0.10; // Adjust this value to control the intensity of squash and stretch

// Calculate the image scale based on zvel
var _image_yscale = 1 + (abs(zvel) * _squash_factor);
var _image_xscale = 1 - (abs(zvel) * _squash_factor);


var _shadow_scale = max(0.1, 0.5 - (z / 150)); 
draw_sprite_ext(sShadow, 0, x, y+2, _shadow_scale, _shadow_scale, 0, c_black, 0.5);

image_xscale = _image_xscale;
image_yscale = _image_yscale;

// Update the position
y -= z;
draw_self();
y += z;

draw_set_color(c_black);