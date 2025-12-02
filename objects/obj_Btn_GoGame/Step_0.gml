
// 1) 시간 끝 + 게임 멈춤 + 현재 룸이 room_Mine일 때만 보이도록
visible = (room == room_Mine && global.is_playing == false && global.game_time <= 0);
