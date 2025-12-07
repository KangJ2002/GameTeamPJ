life_time = 10; // 10프레임 (약 0.16초) 동안 존재
image_speed = 0; // 프레임 애니메이션은 사용하지 않음
image_index = 0;

angle_end = image_angle; // obj_Player가 설정한 최종 각도 (35 또는 -35)

var _swing_arc = 40;       // 스윙의 전체 아크 크기 (40도 유지)
var _visual_correction = 35; // 🆕 시각적 비대칭 보정을 위한 각도 (15도 시도)


// 1. 끝 각도의 부호에 따라 스윙 시작 각도를 결정합니다.
if (angle_end > 0) {
    angle_start = angle_end - _swing_arc;
    
} else {
    angle_start = angle_end + _swing_arc;
    angle_start -= _visual_correction; 
}


// 2. 초기 각도는 시작 각도로 설정
image_angle = angle_start;

// 3. 회전 진행도를 추적하기 위한 변수 초기화
rotation_progress = 0;