// obj_rock - Draw Event

// rock 그리기
draw_self();

// 체력바 설정
var bar_width  = 40;
var bar_height = 6;
var bar_margin = 4;

var bar_x = x - bar_width / 2 ;
var bar_y = y + sprite_height * image_yscale + bar_margin - 20;

// 체력 비율
var hp_ratio = hp / hp_max;
if (hp_ratio < 0) hp_ratio = 0;
if (hp_ratio > 1) hp_ratio = 1;

// 배경(빈 바)
draw_set_color(c_dkgray);
draw_rectangle(bar_x, bar_y, bar_x + bar_width, bar_y + bar_height, false);

// 현재 체력
draw_set_color(c_green);
draw_rectangle(bar_x, bar_y, bar_x + bar_width * hp_ratio, bar_y + bar_height, false);

// 테두리
draw_set_color(c_black);
draw_rectangle(bar_x, bar_y, bar_x + bar_width, bar_y + bar_height, true);