depth = -y;

var _squash_factor = 0.06;

// Calculate the image scale based on zvel
var _image_yscale = 1 + (abs(zvel) * _squash_factor);
var _image_xscale = 1 - (abs(zvel) * _squash_factor);

// Scale when nearer to camera in sky
_image_yscale += z / 1000;
_image_xscale += z / 1000;

var _shadow_scale = max(0.1, 0.75 - (z / 150)); 
draw_sprite_ext(sShadow, 0, x, y+7, _shadow_scale, _shadow_scale, 0, c_black, 0.5);


if (hitflash_time > 0) shader_set(sh_white);
y -= z;
{
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale*_image_xscale, _image_yscale, 0, c_white, 1);
	shader_reset();

	if (draw_slash) {
		draw_sprite_ext(sSlash, attack_time / 16, x + xvel*3, y + 8 + yvel*3, image_xscale, -1, 0, c_white, 0.8);
	}

}
y += z;



