var mx = (keyboard_check(vk_right) || keyboard_check(ord("D"))) - (keyboard_check(vk_left) || keyboard_check(ord("A")));
var my = (keyboard_check(vk_down)  || keyboard_check(ord("S"))) - (keyboard_check(vk_up)   || keyboard_check(ord("W")));

if (mx != 0 || my != 0) {
    var len = point_distance(0, 0, mx, my);
    mx /= len; 
    my /= len;
}

x += mx * spd;
y += my * spd;

// 좌우 입력에 따라 스프라이트 뒤집기as
if (mx > 0) {
    image_xscale = 1;   // 오른쪽 바라봄
} else if (mx < 0) {
    image_xscale = -1;  // 왼쪽 바라봄
}


// 1) 마우스 방향으로 조준 각도 갱신
aim_dir = point_direction(x, y, mouse_x, mouse_y);
// 선택: 스프라이트를 마우스 방향으로 회전시키고 싶다면
image_angle = aim_dir;