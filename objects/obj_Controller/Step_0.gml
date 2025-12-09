if(room == room_Mine){
	if(global.is_playing == true && global.game_time > 0){
		global.game_time -= delta_time / 1000000; //정확히 1초씩 감소 
		
		if(global.game_time <= 0){
			global.game_time = 0;
			global.is_playing = false;
		}
	}
	if (global.is_playing == true) {
        var max_count = global.max_rock_count;
        
        // 현재 광석 개수가 최대치보다 적고 (캐진 돌이 있고),
        // 재생성 알람(alarm[0])이 현재 멈춰있다면 다시 시작합니다.
        if (instance_number(obj_Ore_Parent) < max_count && alarm[0] < 0) {
            // 광석을 캔 직후 재생성 쿨다운을 설정하여 알람을 다시 켜줍니다.
            alarm[0] = global.rock_regen_cooldown_max; 
        }
	}
}
