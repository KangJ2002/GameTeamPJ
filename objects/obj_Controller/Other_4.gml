if (room == room_Mine){
	show_debug_message("Enter Mine! Now Currncy : " + string(global.currency));
	
	global.is_playing = true;
	global.game_time = global.game_time_max;
	global.gold_at_start = global.currency;
	
	
	if (alarm[0] < 0) { // 혹시 이미 실행 중이 아니라면 (안전장치)
        alarm[0] = 60; // 1초 후 첫 재생성 알람 실행
    }
	
	
	with (obj_Rock) instance_destroy();
	
	var _rock_count = global.max_rock_count; 
	var _rocks_created = 0;

    var _grid_size = 32; 
    var _map_width = 15;
    var _map_height = 15;
	var _max_attemps = _rock_count * 5;
	
	while(_rocks_created < _rock_count && _max_attemps > 0){
		_max_attemps--;
      
            var _grid_x = irandom_range(0, _map_width - 1);
            var _grid_y = irandom_range(0, _map_height - 1);
           
            var rx = _grid_x * _grid_size + (_grid_size / 2);
            var ry = _grid_y * _grid_size + (_grid_size / 2);
           
            if (instance_position(rx, ry, obj_Rock) == noone) {
                instance_create_layer(rx, ry, "Instances", obj_Rock);
				_rocks_created++;
			} 
			
		}
}

