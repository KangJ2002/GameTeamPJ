if (visible) {
    // 게임 재시작 로직
    global.game_time = 20;
    global.is_playing = true;
    room_restart(); // 현재 룸 재시작
}