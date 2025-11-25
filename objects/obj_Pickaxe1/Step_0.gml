// 플레이어 방향에 따라 곡괭이 위치와 좌우 반전 처리
if (instance_exists(obj_Player)) {
    if (obj_Player.image_xscale == 1) {
        // 플레이어가 오른쪽 보는 중
        x = obj_Player.x + 10;  // 플레이어 오른쪽
        y = obj_Player.y + 5;
        image_xscale = -1;
    } else {
        // 플레이어가 왼쪽 보는 중
        x = obj_Player.x - 10;  // 플레이어 왼쪽
        y = obj_Player.y + 5;
        image_xscale = 1;
    }
}

// 기본 각도로 서서히 되돌아가기
image_angle = lerp(image_angle, angle_default, return_speed);