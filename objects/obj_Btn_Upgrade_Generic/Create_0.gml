upgrade_type = "MINING_DAMAGE";

// 사용 가능한 upgrade_type 목록:
/* 
"MINING_SPEED"   // 공격 속도
"MOVE_SPEED"     // 이동 속도
"MINING_DAMAGE"  // 데미지 (기본값)
"RANGE_RADIUS"   // 사거리
"MINING_ANGLE"   // 공격 각도
"GAME_TIME"      // 광산 제한 시간
"ROCK_MAX_COUNT" // 광석 개수 증가
*/


current_level = 0;
max_level = 5; // 모든 업그레이드는 5 레벨이 최대라고 가정


// 버튼의 상태를 나타내는 변수
can_afford = false; // 구매 가능한가?
is_max_level = false; // 최대 레벨인가?