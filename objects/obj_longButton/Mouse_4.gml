if (button_type != "UNASSIGNED") { // 네비게이션 버튼인 경우

    with (obj_longButton) instance_destroy();
    
    switch (button_type) {
        case "GO_MINE":
            // 상점에서 광산으로 이동
            room_goto(room_Mine);
            break;
            
        case "RETRY":
            // 광산에서 재시작 (Room을 다시 시작)
            room_restart();
            break;
            
        case "GO_SHOP":
            // 광산에서 상점으로 이동
            room_goto(room_Shop11);
            break;
    }
    // 인스턴스를 파괴했으므로 여기서 함수를 종료합니다.
    exit; 
}