// 플레이어 이동구현
if (room != room_Shop) {
	
var mx = (keyboard_check(vk_right) || keyboard_check(ord("D"))) - (keyboard_check(vk_left) || keyboard_check(ord("A")));
var my = (keyboard_check(vk_down)  || keyboard_check(ord("S"))) - (keyboard_check(vk_up)   || keyboard_check(ord("W")));

 if (mx != 0 || my != 0) {
    var len = point_distance(0, 0, mx, my);
    mx /= len; 
    my /= len;
 }

 x += mx * spd;
 y += my * spd;
}
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
	
	show_debug_message(">>>공 격 실 행 됨<<< ");
	
	var _attack_dir = point_direction(x, y, mouse_x, mouse_y);
	
	
	// 공격 사거리 끝 지점 계산
	var _end_x = x + lengthdir_x(global.Range_radius, _attack_dir);
	var _end_y = y + lengthdir_y(global.Range_radius, _attack_dir);
	
	// 마우스 방향으로 채굴
	var _hit_list = ds_list_create();
	var _num_hit = collision_line_list(x, y, _end_x, _end_y, obj_Rock, false, true, _hit_list, false);
	
	// 충돌시 데미지 적용
	if (_num_hit > 0) {
		for( var i = 0; i<_num_hit; i++){
			var _target_rock = _hit_list[| i];
			_target_rock.hp -= global.mining_Damage;
			
			with(_target_rock){
				if(hp<=0){
					var _final_value = rock_value;
					
					global.currency += _final_value;
					
					// debug
					show_debug_message("currency increased to : " + string(global.currency));
					instance_destroy();
				}
			}
		}
	}
	
	ds_list_destroy(_hit_list);
}

//aa


