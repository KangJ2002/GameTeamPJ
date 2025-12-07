/// obj_Player - Step Event

// 0. 게임 일시정지 등 처리
if (global.is_playing == false) {
    image_speed = 0;
    image_index = 0;
    exit;
}

// 1. 플레이어 이동 구현 (광산 룸에서만)
if (room == room_Mine) {

    var mx = (keyboard_check(vk_right) || keyboard_check(ord("D")))
           - (keyboard_check(vk_left)  || keyboard_check(ord("A")));
    var my = (keyboard_check(vk_down)  || keyboard_check(ord("S")))
           - (keyboard_check(vk_up)    || keyboard_check(ord("W")));

    // 대각선 이동 속도 보정 (정규화)
    if (mx != 0 || my != 0) {
        var len = point_distance(0, 0, mx, my);
        mx /= len;
        my /= len;
    }

    x += mx * global.move_speed;
    y += my * global.move_speed;
}

// 2. 마우스 위치 기준으로 좌우 반전
if (mouse_x < x) {
    image_xscale = -1;   // 왼쪽 바라봄 (좌우 반전)
} else {
    image_xscale = 1;    // 오른쪽 바라봄 (정방향)
}

// 3. 채굴 쿨타임 감소 (1FPS당 1씩 감소)
if (mining_cooldown_timer > 0) {
    mining_cooldown_timer -= 1;
}

// 4. 공격 입력 + 쿨타임 체크
if (mouse_check_button(mb_left) && mining_cooldown_timer <= 0) {

    // 4-1. 쿨타임 재설정
    mining_cooldown_timer = mining_cooldown_max;
    show_debug_message(">>>공 격 실 행 됨 (원뿔형)<<< ");

    // 4-2. 현재 장착된 곡괭이 오브젝트 결정
    var _pickaxe_obj = noone;
    if (global.current_pickaxe == 1) {
        _pickaxe_obj = obj_Pickaxe1;
    } else if (global.current_pickaxe == 4) {
        _pickaxe_obj = obj_Pickaxe4;
    }

    // 4-3. 곡괭이 모션 시작 (한 번 휙 숙이기)
    if (_pickaxe_obj != noone && instance_exists(_pickaxe_obj)) {
        var _px = instance_nearest(x, y, _pickaxe_obj);
        with (_px) {
            // obj_pickaxe Create에서 정의한 값 사용
            image_angle = angle_click;  // 예: -20 ~ -40 정도
            // 필요 시 애니메이션도 줄 수 있음:
            // image_index = 0;
            // image_speed = 1;
        }
    }

    // 4-4. 공격 방향 계산 (마우스 방향이 중심축)
    var _attack_dir = point_direction(x, y, mouse_x, mouse_y);

    // 4-5. 공격 범위 내 모든 광석 찾기 (큰 원으로 1차 선별)
    var _hit_list = ds_list_create();
    var _num_hit  = collision_circle_list(
        x, y,
        global.Range_radius,   // 공격 거리
        obj_Ore_Parent,        // 광석 오브젝트
        false,                 // prec
        true,                  // notme
        _hit_list,             // 결과 리스트
        false                  // multiple
    );

    // 4-6. 원뿔 각도 판정 (2차 선별)
    if (_num_hit > 0) {
        for (var i = _num_hit - 1; i >= 0; i--) {

            var _target_rock = _hit_list[| i];

            // 타겟이 플레이어로부터 어느 각도에 있는지
            var _target_dir = point_direction(x, y, _target_rock.x, _target_rock.y);

            // 마우스 방향(_attack_dir)과 타겟 방향 간의 각도 차이
            var _angle_diff = angle_difference(_target_dir, _attack_dir);

            // 각도 차이가 허용 범위(global.mining_Angle/2)를 넘으면 리스트에서 제거
            if (abs(_angle_diff) > global.mining_Angle / 2) {
                ds_list_delete(_hit_list, i);
                _num_hit -= 1;
            }
        }

        // 4-7. 최종적으로 원뿔 범위 내에 남은 광석에 데미지 적용
        for (var i = 0; i < _num_hit; i++) {
            var _target_rock = _hit_list[| i];

            _target_rock.hp -= global.mining_Damage; // 데미지 적용

			// 1. 곡괭이가 광석의 좌측(-), 우측(+) 어디에 생성될지 결정합니다.
			//    (광석 중심 x에서 -10 ~ +10 오프셋)
			var _hit_x_offset = choose(-20, 20); 
			var _hit_y_offset = -10; // 광석보다 약간 위쪽에 배치

			var _hit_fx = instance_create_layer(
			    _target_rock.x + _hit_x_offset, 
			    _target_rock.y + _hit_y_offset, 
			    "Instances", 
			    obj_Hit_Effect 
			);

			// 2. 🆕 _hit_x_offset 값에 따라 곡괭이의 방향을 결정합니다.
			if (_hit_x_offset < 0) {
			    // 오프셋이 음수(-10) (광석 좌측 끝 생성)
			    // ➡️ 우측을 바라보게 (image_xscale = -1)
			    _hit_fx.image_xscale = -1; 
    
			    // 🆕 오른쪽으로 찍는 느낌을 위해 양수 각도(35도) 적용
			    _hit_fx.image_angle = 35; 
			} else {
			    // 오프셋이 양수(+10) (광석 우측 끝 생성)
			    // ➡️ 좌측을 바라보게 (image_xscale = 1)
			    _hit_fx.image_xscale = 1; 
    
			    // 🆕 왼쪽으로 찍는 느낌을 위해 음수 각도(-35도) 적용
			    _hit_fx.image_angle = -35
			}

            with (_target_rock) {
                if (hp <= 0) {
                    var _final_value = rock_value;
					var _earned_currency = floor(_final_value * global.currency_gain_multiplier);
					
                    global.currency += _earned_currency; // 재화 획득 
                    
                    // 1. 팝업 텍스트 오브젝트 생성
                    var _popup = instance_create_layer(
                        x, y - 20, // 광석의 x, y보다 약간 위
                        "Instances", 
                        obj_Text_Popup // 1단계에서 생성한 팝업 오브젝트 이름
                    );
                    
                    // 2. 팝업에 표시할 내용 전달
                    _popup.display_text = "+" + string(_earned_currency);
                    
                    // 3. 재화 가치에 따라 팝업 색상 설정
                    if (_final_value > 1) {
                        _popup.display_color = c_yellow;  // 은 광석(value > 1)은 아쿠아색
                    } else {
                        _popup.display_color = c_yellow; // 돌 광석(value = 1)은 노란색
                    }
                    
                    show_debug_message("currency increased to : " + string(global.currency));
                    instance_destroy(); // 광석 파괴
                }
            }
        }
    }

    // 4-8. 리스트 정리
    ds_list_destroy(_hit_list);
}