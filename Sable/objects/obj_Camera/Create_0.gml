// 640 by 360, 16:9

#macro view view_camera[0]

view_width = 1920/3;
view_height = 1080/3;

window_scale = 3;

screen_shake = 0;

camera_type = 1;
camera_target = noone;

//display_reset(0, true) // for screen tearing / pixel perfect

layer_create(-500, "Text");

sprite_index=-1;

window_set_size(view_width * window_scale, view_height * window_scale);
alarm[0] = 1;

surface_resize(application_surface, view_width * window_scale, view_height * window_scale);

//if (instance_exists(camera_target))
//	camera_set_view_pos(view, camera_target.x - view_width / 2, camera_target.y - view_height / 2);