draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_tip);
draw_set_colour(c_white);

draw_set_font(fnt_tip); 
draw_set_colour(c_white);

var _game_title = "MINING GAME";
var _title_x = display_get_gui_width() / 2;
var _title_y = display_get_gui_height() / 4;

var _text_to_display = "Press Any Key to Start!";

var _x = display_get_gui_width() / 2;
var _y = display_get_gui_height() - 250;


draw_text_transformed(_title_x, _title_y, _game_title, 4, 4, 0); 

draw_text_transformed(_x, _y, _text_to_display, 2, 2, 0)
