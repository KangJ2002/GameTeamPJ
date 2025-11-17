draw_set_font(fnt_Basic);
draw_set_colour(c_yellow);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var _currency_string = "Gold : " + string_format(global.currency, 0, 0);

var _x = 10;
var _y = 10;

draw_text(_x, _y, _currency_string);

