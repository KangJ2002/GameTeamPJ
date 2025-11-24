draw_self();

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_Shop);

var _cx = x;
var _cy = y;
var _line_height = 20;

draw_set_color(c_white);
draw_text(_cx, _cy - _line_height, string(upgrade_type));

if (is_max_level) {
    // 최대 레벨 표시
    draw_set_color(c_lime);
    draw_text(_cx, _cy + 0, "MAX LEVEL!");
    draw_text(_cx, _cy + _line_height, "Level: " + string(current_level));
} else {
    // 현재 레벨과 다음 스탯 표시
    draw_set_color(c_yellow);
    draw_text(_cx, _cy + 0, 
        "L" + string(current_level) + " -> L" + string(current_level + 1) + 
        " (" + string_format(next_stat_value, 0, (upgrade_type == "MINING_SPEED" ? 1 : 0)) + ")"
    );
	
	// 비용 표시 (구매 가능 여부에 따라 색상 변경)
    if (can_afford) {
        draw_set_color(c_green);
    } else {
        draw_set_color(c_red);
    }
    draw_text(_cx, _cy + _line_height, "Cost: " + string(upgrade_cost));
}

draw_set_halign(fa_left);