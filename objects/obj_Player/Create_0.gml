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

if (!variable_global_exists("current_pickaxe")) {
    global.current_pickaxe = 1; 
}

with (obj_Pickaxe1) instance_destroy();
