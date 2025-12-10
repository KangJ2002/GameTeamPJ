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

if (room == room_Mine && global.is_playing == false && alarm[1] > 0) {
    // 현재 남은 초 계산 (Draw GUI에서 쓰는 것과 동일)
    var _countdown_sec = ceil(alarm[1] / room_speed);

    // 이전 값과 다르면 -> 숫자가 바뀌는 순간
    if (_countdown_sec != prev_countdown_sec) {
        // 🔊 여기서 효과음 재생
        audio_play_sound(snd_321, 1, false);

        // 이전 값 갱신
        prev_countdown_sec = _countdown_sec;
    }
} else {
    // 카운트다운이 아닌 상태일 때는 초기화(선택 사항)
    prev_countdown_sec = -1;
}