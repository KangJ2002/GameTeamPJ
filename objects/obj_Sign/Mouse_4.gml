if (instance_exists(obj_Player)) {
    // 기존 곡괭이 삭제
    with (obj_Pickax1) instance_destroy();

    // 플레이어 위치에 새 곡괭이 생성
    instance_create_layer(obj_Player.x, obj_Player.y, "Instances", obj_Pickax4);
}