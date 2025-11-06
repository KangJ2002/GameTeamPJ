input_h = keyboard_check(ord("D")) - keyboard_check(ord("A"));

if (input_h > 0) input_h = 1;
else if (input_h < 0) input_h = -1;

x += input_h * move_speed;

var padding = 16;
x = clamp(x, padding, room_width - padding);
