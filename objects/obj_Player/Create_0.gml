spd = 3;
image_xscale = 1; // 초기 바라보는 방향(오른쪽)

// 조준 관련
aim_dir = 0;       // 마우스 기준 조준 각도(도)
aim_dist = 28;     // 공격 기준점(플레이어 중심에서 전방 오프셋)

// 공격 관련
atk_cooldown = 0;  // 쿨다운 타이머
atk_cd_max = 15;   // 15스텝(=0.25초@60fps)
atk_range = 36;    // 공격 거리 반경(원형/아크에서 사용)
atk_angle = 70;    // 전방 아크 공격 각도(도), 전체 각도
is_attacking = false;
attack_timer = 0;
attack_time = 8;   // 공격 지속 프레임(히트박스 유효 시간)