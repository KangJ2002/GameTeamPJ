// Btn_GoGame - Step Event

// 1) 시간 끝 + 게임 멈춤 + 현재 룸이 room_Mine일 때만 보이도록
visible = (room == room_Mine && global.is_playing == false && global.game_time <= 0);

// 2) 카메라 기준으로 위치 고정
//    (게임이 진행 중일 때도 위치는 계속 갱신되지만, visible = false라 안 보임)
var cam = view_camera[0];                    // 사용하는 뷰/카메라 인덱스 (보통 0번)
var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);
var cam_w = camera_get_view_width(cam);
var cam_h = camera_get_view_height(cam);

// 화면 기준 원하는 위치에 배치
// 예시: 화면 중앙 아래쪽에 고정
x = cam_x + cam_w * 0.5 - 80;
y = cam_y + cam_h * 0.5 + 80;   // 아래로 80px 내려서 배치