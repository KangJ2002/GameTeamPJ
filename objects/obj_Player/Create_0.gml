spd = 3;
image_xscale = 1; // 초기 바라보는 방향(오른쪽)

global.mining_Damage = 1;	//채굴 데미지
global.mining_Speed = 1.0;	//채굴 공격속도
global.Range_radius = 32;	//채굴 사거리

global.currency = 0;		//재화 

mining_cooldown_timer = 0;	//공격쿨타임
mining_cooldown_max = room_speed / global.mining_Speed;


pickax = instance_create_layer(x, y, "Instances", obj_Pickax1);