if (instance_exists(obj_Player)) {
    // 1) 현재 룸에서 기존 곡괭이 인스턴스 삭제
    with (obj_Pickaxe1) instance_destroy();
    with (obj_Pickaxe4) instance_destroy();  // 혹시 이미 4번이 있었다면 정리

    // 2) 전역 상태에 "이제부터는 4번 곡괭이"라고 기록
    global.current_pickaxe = 4;

    // 3) 플레이어 옆에 새 곡괭이 생성
    instance_create_layer(obj_Player.x, obj_Player.y, "Instances", obj_Pickaxe4);
}