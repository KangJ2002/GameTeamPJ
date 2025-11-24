if(global.is_playing == false){
	image_speed = 0;
	image_index = 0;
	exit;
}


// 플레이어 이동구현
if (room == room_Mine) {
	
var mx = (keyboard_check(vk_right) || keyboard_check(ord("D"))) - (keyboard_check(vk_left) || keyboard_check(ord("A")));
var my = (keyboard_check(vk_down)  || keyboard_check(ord("S"))) - (keyboard_check(vk_up)   || keyboard_check(ord("W")));

 if (mx != 0 || my != 0) {
    var len = point_distance(0, 0, mx, my);
    mx /= len; 
    my /= len;
 }

x += mx * global.move_speed;
y += my * global.move_speed;
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
    show_debug_message(">>>공 격 실 행 됨 (원뿔형)<<< "); // 메시지 변경

    // 1. 공격 방향 계산
    var _attack_dir = point_direction(x, y, mouse_x, mouse_y);// 마우스 방향을 공격의 중심축으로 사용

    // 2. 공격 범위 내 모든 광석 찾기 (큰 원으로 1차 선별)
    var _hit_list = ds_list_create();
    // global.Range_radius 크기의 원 안에 있는 obj_Rock 인스턴스 모두 목록에 추가
    var _num_hit = collision_circle_list(x, y, global.Range_radius, obj_Rock, false, true, _hit_list, false);
    

    // 3. 1차 선별된 광석에 대해 원뿔 각도 판정 (2차 선별)
    if (_num_hit > 0) {
        for( var i = _num_hit - 1; i>=0; i--){ // 리스트를 뒤에서부터 반복 (제거 용이)
            var _target_rock = _hit_list[| i];

            // 광석이 플레이어로부터 어느 각도에 있는지 계산
            var _target_dir = point_direction(x, y, _target_rock.x, _target_rock.y);
            
            // _attack_dir (중심축)과 _target_dir 사이의 각도 차이 계산
            var _angle_diff = angle_difference(_target_dir, _attack_dir);

            // 각도 차이가 원뿔 각도(global.mining_Angle)의 절반을 넘어서면 리스트에서 제거
            if (abs(_angle_diff) > global.mining_Angle / 2) {
                ds_list_delete(_hit_list, i);
                _num_hit -= 1; // 제거했으므로 충돌 개수 감소
            }
        }

        // 4. 최종적으로 원뿔 범위 내에 남은 광석에 데미지 적용
        for( var i = 0; i<_num_hit; i++){
            var _target_rock = _hit_list[| i];
            
            _target_rock.hp -= global.mining_Damage;// 데미지 적용

            with(_target_rock){
                if(hp<=0){
                    var _final_value = rock_value;
                    global.currency += _final_value;// 재화 획득
                    
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


