if (room == room_Mine){
    // 1. 게임 상태 초기화 및 안전 장치
    // 결과창 버튼 생성 여부 초기화
	if (variable_instance_exists(id, "end_buttons_created")) { 
        end_buttons_created = false;
    }
	
	global.is_playing = false; // 처음에는 카운트다운 중이므로 false
    
    // 2. 시간 및 재화 초기화
    global.game_time = global.game_time_max; // 최대 시간으로 설정
	global.gold_at_start = global.currency; // 광산 진입 전 현재 재화 저장
	
	
    // 3. 알람 설정 및 초기화
	// 기존에 있던 obj_Rock 파괴 (obj_Rock이 obj_Ore_Parent의 자식이든 아니든 파괴)
	with (obj_Ore_Parent) instance_destroy(); 
    
    alarm[0] = -1; // 광석 재생성 알람 비활성화
	alarm[1] = 3 * room_speed; // 3초 카운트다운 알람 설정 (alarm[1]이 0이 되면 게임 시작)
	
	
    // 4. 광석 배치 설정
	var _rock_count = global.max_rock_count; // 생성할 최대 광석 개수
	var _rocks_created = 0;
	var _grid_size = 32; // 그리드 크기
	var _map_width = 15; // 맵 그리드 너비
	var _map_height = 15; // 맵 그리드 높이
	
	var _max_attemps = _rock_count * 5; // 최대 시도 횟수
    
    // 5. 초기 광석 배치 루프
	while(_rocks_created < _rock_count && _max_attemps > 0){
		_max_attemps--;
      
        // 그리드 위치 랜덤 선택
        var _grid_x = irandom_range(0, _map_width - 1);
        var _grid_y = irandom_range(0, _map_height - 1);
           
        // 실제 방 위치 계산 (그리드 중심 + 64 마진)
        var rx = _grid_x * _grid_size + (_grid_size / 2) + 64;
        var ry = _grid_y * _grid_size + (_grid_size / 2) + 64;
        
        // 해당 위치에 obj_Rock(또는 광석 부모)이 없을 때만 생성
        if (instance_position(rx, ry, obj_Rock) == noone) { 
            
            // 어떤 광물을 생성할지 결정
		    var _rock_to_create = obj_Rock; // 기본값은 돌
        
		    if (global.level_mine_unlock >= 3) {
                // Level 3 해금: obj_Diamond, obj_Gold, obj_Silver 스폰 가능
                var _chance = random(100); // 0부터 99.999... 난수 생성
                if (_chance < 15) { 
                    _rock_to_create = obj_Diamond; // 5%
                } else if (_chance < 45) { 
                    _rock_to_create = obj_Gold;    // 10% (5% ~ 14%)
                } else if (_chance < 90) { 
                    _rock_to_create = obj_Silver;  // 20% (15% ~ 34%)
                }
            } else if (global.level_mine_unlock >= 2) {
                // Level 2 해금: obj_Gold, obj_Silver 스폰 가능
                var _chance = random(100);
                if (_chance < 40) { 
                    _rock_to_create = obj_Gold;    // 10%
                } else if (_chance < 90) { 
                    _rock_to_create = obj_Silver;  // 20% (10% ~ 29%)
                }
            } else if (global.level_mine_unlock >= 1) {
		        // Level 1 해금: obj_Silver 스폰 가능
		        var _chance = random(100);
            
		        // 은 광석 스폰 확률을 90%로 수정
		        if (_chance < 90) { // <--- **90% 확률**
		            _rock_to_create = obj_Silver;
		        } else {
		            _rock_to_create = obj_Rock; // 10% 확률로 obj_Rock 생성
		        }
		    }
        
		    instance_create_layer(rx, ry, "Instances", _rock_to_create);
		    _rocks_created++;
		} 
				
	}
}