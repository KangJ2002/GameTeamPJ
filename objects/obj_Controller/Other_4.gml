if (room == room_Mine){
	if (variable_instance_exists(id, "end_buttons_created")) {
        end_buttons_created = false;
    }
	
	global.is_playing = false;
	global.game_time = global.game_time_max;
	global.gold_at_start = global.currency;
	
	
	if (alarm[0] < 0) { // 혹시 이미 실행 중이 아니라면 (안전장치)
        alarm[0] = 60; // 1초 후 첫 재생성 알람 실행
    }
	
	
	with (obj_Rock) instance_destroy();
alarm[0] = -1; // 광석 재생성 알람 비활성화
alarm[1] = 3 * room_speed;
	
	var _rock_count = global.max_rock_count; 
	var _rocks_created = 0;

    var _grid_size = 32; 
	var _map_width = 15;
	var _map_height = 15;
	
	var _margin_grid = 64 / _grid_size;
	
	var _total_grid_w = room_width / _grid_size;
    var _total_grid_h = room_height / _grid_size;
	
	var _max_grid_x = _total_grid_w - 1 - _margin_grid;
    var _max_grid_y = _total_grid_h - 1 - _margin_grid;
	

	var _max_attemps = _rock_count * 5;
	
	while(_rocks_created < _rock_count && _max_attemps > 0){
		_max_attemps--;
      
            var _grid_x = irandom_range(0, _map_width - 1);
            var _grid_y = irandom_range(0, _map_height - 1);
           
            var rx = _grid_x * _grid_size + (_grid_size / 2) + 64;
            var ry = _grid_y * _grid_size + (_grid_size / 2) + 64;
           
            if (instance_position(rx, ry, obj_Rock) == noone) {
                // 🆕 3-1. 어떤 광물을 생성할지 결정
		        var _rock_to_create = obj_Rock; // 기본값은 돌
        
		        if (global.level_mine_unlock >= 1) {
		            // Level 1 이상 해금 시: 돌 또는 은을 일정 비율로 결정
		            var _chance = random(100); // 0부터 99까지의 난수 생성
            
		            // 은 광석 스폰 확률 (예: 20%)
		            if (_chance < 20) { 
		                _rock_to_create = obj_Silver;
		            } else {
		                _rock_to_create = obj_Rock;
		            }
            
		            // TODO: Level 2 해금 시: _chance < 10 (은), _chance < 3 (금) 등으로 확장
		        }
        
		        instance_create_layer(rx, ry, "Instances", _rock_to_create);
		        _rocks_created++;
			} 
				
		}
}

