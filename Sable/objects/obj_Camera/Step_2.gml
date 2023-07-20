#macro view view_camera[0]

if not instance_exists(camera_target) exit;

camera_set_view_size(view, view_width, view_height);

var _spd = 0.32;

var buffer_distance = 100; // The distance from the edge of the room where the sink into border effect begins.
var max_sink = 0.60; // The maximum value of the sink into border effect.

screen_shake = clamp(screen_shake, 0, 25);

if (instance_exists(camera_target))
{
    var _x = 0;
    var _y = 0;
	
    _x = (camera_target.x - view_width / 2) + _x;
    _y = (camera_target.y - view_height / 2) + _y;
	
	_x += camera_target.xvel*3;
	_y += camera_target.yvel*3;
	
    _x += random_range(-screen_shake, screen_shake);
    _y += random_range(-screen_shake, screen_shake);
	
    var _x_clamped = clamp(_x, 0, room_width - view_width);
    var _y_clamped = clamp(_y, 0, room_height - view_height);

    var _cur_x = camera_get_view_x(view);
    var _cur_y = camera_get_view_y(view);

    // Calculate the current sink into border based on the camera target's proximity to the room edges.
    var _sinkintoborder_x = min(max(abs(camera_target.x - room_width / 2) / (room_width / 2 - buffer_distance), 0), 1) * max_sink;
    var _sinkintoborder_y = min(max(abs(camera_target.y - room_height / 2) / (room_height / 2 - buffer_distance), 0), 1) * max_sink;
	
    camera_set_view_pos(view,
						lerp(_cur_x, lerp(_x, _x_clamped, _sinkintoborder_x), _spd),
						lerp(_cur_y, lerp(_y, _y_clamped, _sinkintoborder_y), _spd));
}

if (screen_shake > 0)
{
	screen_shake -= 1;
}