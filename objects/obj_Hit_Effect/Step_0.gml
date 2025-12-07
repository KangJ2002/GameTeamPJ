// 1. 회전 진행도 계산 (life_time: 10 -> 0 일 때, progress: 0 -> 1)
rotation_progress = (10 - life_time) / 10; 

// 2. 🆕 각도를 시작 각도에서 끝 각도로 부드럽게 변경하여 스윙 모션을 구현합니다.
image_angle = lerp(angle_start, angle_end, rotation_progress);

// 3. 생명 시간 감소
life_time--;

// 4. 투명도를 서서히 감소 (기존 로직 유지)
image_alpha = life_time / 10; 

if (life_time <= 0) {
    instance_destroy();
}