if(room == room_Mine){
	if(global.is_playing == true && global.game_time > 0){
		global.game_time -= delta_time / 1000000; //정확히 1초씩 감소 
		
		if(global.game_time <= 0){
			global.game_time = 0;
			global.is_playing = false;
			show_debug_message("time over! ");
		}
	}
}
