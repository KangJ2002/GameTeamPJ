if (room == room_Mine) {
    
    // 게임이 '진행 중'일 때만 재생성을 시도하고 알람을 재설정합니다.
    if (global.is_playing == true) { 
        
        var max_count = global.max_rock_count;
        var max_attempts = 10; // 빈 공간 찾기 시도 횟수를 10번으로 늘립니다.
        var created = false;
    
        // 2. 현재 광석 개수가 최대 개수보다 적을 때만 시도합니다.
        if (instance_number(obj_Rock) < max_count) {
            
            // 빈 공간을 찾을 때까지 최대 10번 시도하는 루프
            repeat (max_attempts) { 
                
                var _grid_size = 32;
				var _map_width = 15;
				var _map_height = 15;
					
				var _grid_x = irandom_range(0, _map_width - 1);
                var _grid_y = irandom_range(0, _map_height - 1);

				var _gx = irandom(_map_width - 1);
				var _gy = irandom(_map_height - 1);

				var rx = _grid_x * _grid_size + (_grid_size / 2) + 64;
                var ry = _grid_y * _grid_size + (_grid_size / 2) + 64;
                
                // 해당 위치에 obj_Rock이 없을 때만 생성 (충돌 확인)
               if (instance_position(rx, ry, obj_Ore_Parent) == noone) {
                    
				    // 🆕 1. 생성할 오브젝트를 결정합니다. 기본값은 obj_Rock (돌 광석)
				    var _rock_to_create = obj_Rock;

                    // 🆕 2. 광물 해금 레벨을 확인하고 확률적으로 상위 광물을 선택합니다.
                    //     (더 희귀한 광물부터 체크하여 확률을 제어합니다.)
				    var _chance = random(100); // 0부터 99까지의 난수 (확률 계산용)

                    if (global.level_mine_unlock >= 3) {
                        // Level 3 해금: obj_Diamond, obj_Gold, obj_Silver 스폰 가능
                        if (_chance < 5) { 
                            _rock_to_create = obj_Diamond; // 5% 확률
                        } else if (_chance < 15) { 
                            _rock_to_create = obj_Gold;    // 10% 확률 (5% ~ 14%)
                        } else if (_chance < 35) { 
                            _rock_to_create = obj_Silver;  // 20% 확률 (15% ~ 34%)
                        }
                    } else if (global.level_mine_unlock >= 2) {
                        // Level 2 해금: obj_Gold, obj_Silver 스폰 가능
                        if (_chance < 10) { 
                            _rock_to_create = obj_Gold;    // 10% 확률
                        } else if (_chance < 30) { 
                            _rock_to_create = obj_Silver;  // 20% 확률 (10% ~ 29%)
                        }
                    } else if (global.level_mine_unlock >= 1) {
                        // Level 1 해금: obj_Silver 스폰 가능
                        if (_chance < 20) { 
                            _rock_to_create = obj_Silver;  // 20% 확률
                        }
                    }
    
				    // 🆕 3. 결정된 오브젝트를 생성합니다.
				    instance_create_layer(rx, ry, "Instances", _rock_to_create);
					show_debug_message("✅ Rock Regenerated at (" + string(rx) + ", " + string(ry) + ") - Type: " + object_get_name(_rock_to_create));
					created = true;
					break; // 성공했으니 반복 중단
					}
				}
            
            if (created == false) {
                // 10번 시도했지만 빈 공간을 못 찾았을 경우 디버그 메시지 출력
                show_debug_message("❌ Failed to find a free spot after 10 attempts.");
            }
        }
        
        // 3. 재생성 성공 여부와 관계없이 다음 알람을 설정하여 루프를 이어갑니다.
        alarm[0] = 20; // 3초 대기 (쿨타임)
        
    } 
    // global.is_playing == false 이면, 다음 알람을 설정하지 않고 재생성 로직을 완전히 멈춥니다.
}