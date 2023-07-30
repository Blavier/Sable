draw_set_font(fnt_debug);

draw_set_color(c_white)

draw_text(10, 10, "z " + string(z));

draw_text(10, 50, "zvel " + string(zvel));

draw_text(10, 100, "floor " + string(_onfloor));
draw_text(10, 120, "ceil " + string(_onceiling)); 


draw_text(10, 150, "jumpinjg  " + string(jumpingstate));