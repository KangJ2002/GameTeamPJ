if (keyboard_check_pressed(ord("P"))) {
    
    if (room == room_Shop) {
        room_goto(room_Mine);   // 상점 → 광산
    }
    else if (room == room_Mine) {
        room_goto(room_Shop);   // 광산 → 상점
    }
}