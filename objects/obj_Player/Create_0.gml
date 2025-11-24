spd = 3;
image_xscale = 1; // 초기 바라보는 방향(오른쪽)

if(variable_global_exists("move_speed")){
	spd = global.move_speed;
}
else{
	spd = 3;
}

if (variable_global_exists("mining_Speed")){
	mining_cooldown_max = room_speed / global.mining_Speed;
}
else{
	mining_cooldown_max = room_speed / 1.0;
}

if (!variable_global_exists("currency")) {
    global.currency = 0;
}

mining_cooldown_timer = 0;	//공격쿨타임
mining_cooldown_max = room_speed / global.mining_Speed;

// 1) 전역 곡괭이 상태가 아직 없으면(게임 처음 시작 시) 기본값 설정
if (!variable_global_exists("current_pickaxe")) {
    global.current_pickaxe = 1;  // 처음엔 1번 곡괭이 사용
}

// 2) 혹시 이전 룸에서 남는 곡괭이가 있다면 정리 (안전용)
with (obj_Pickaxe1) instance_destroy();
with (obj_Pickaxe4) instance_destroy();

// 3) 전역 변수에 기록된 현재 곡괭이 종류에 맞춰 생성
switch (global.current_pickaxe) {
    case 1:
        instance_create_layer(x, y, "Instances", obj_Pickaxe1);
        break;

    case 4:
        instance_create_layer(x, y, "Instances", obj_Pickaxe4);
        break;
}