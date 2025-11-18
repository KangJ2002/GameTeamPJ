// 플레이어 방향에 따라 곡괭이 위치와 좌우 반전 처리
if (obj_Player.image_xscale == 1) {
    // 플레이어가 오른쪽 보는 중
    x = obj_Player.x + 20;   // 플레이어 오른쪽에 위치
    y = obj_Player.y;        // Y 위치 맞춤
    image_xscale = -1;        // 오른쪽으로 보이게
} else {
    // 플레이어가 왼쪽 보는 중
    x = obj_Player.x - 20;   // 플레이어 왼쪽에 위치
    y = obj_Player.y;
    image_xscale = 1;       // 이미지 좌우 반전
}

