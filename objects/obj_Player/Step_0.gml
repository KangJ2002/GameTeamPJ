// 플레이어 이동구현
var mx = (keyboard_check(vk_right) || keyboard_check(ord("D"))) - (keyboard_check(vk_left) || keyboard_check(ord("A")));
var my = (keyboard_check(vk_down)  || keyboard_check(ord("S"))) - (keyboard_check(vk_up)   || keyboard_check(ord("W")));

if (mx != 0 || my != 0) {
    var len = point_distance(0, 0, mx, my);
    mx /= len; 
    my /= len;
}

x += mx * spd;
y += my * spd;

// 이미지 좌우반전
if (mouse_x < x) {
    image_xscale = -1;   // 왼쪽 바라봄 (좌우 반전)
} 

else {
    image_xscale = 1;   // 오른쪽 바라봄 (정방향)
}

// 1fps당 채굴 쿨다운 1감소
if(mining_cooldown_timer > 0){
	mining_cooldown_timer -= 1;
}


if(mouse_check_button(mb_left) && mining_cooldown_timer <= 0){
	mining_cooldown_timer = mining_cooldown_max;
	
	/*
	여 기 에 채 굴 ( 공 격 ) 로 직 함 수 추 가 예 정 
	*/
}


