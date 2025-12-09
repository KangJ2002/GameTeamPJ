
var _bgm = snd_Background;

if (!audio_is_playing(_bgm)){
	global.bgm_instance_id = audio_play_sound(_bgm, 0, true, 0.9);
}

if (instance_number(object_index) > 1) {
    instance_destroy();
}

alarm[0] = 60;
global.currency = 0;
// 만약 이 오브젝트(obj_Controller)가 이미 1개보다 많이 있다면?
if (instance_number(obj_Controller) > 1) {
    instance_destroy();
    exit;
}

end_buttons_created = false;

// 아직 전역 곡괭이 정보가 없다면 초기화
if (!variable_global_exists("current_pickaxe")) {
    global.current_pickaxe = 1;  // 처음엔 1번 곡괭이(= obj_Pickax1)를 쓰도록
}

//1. Rock Count
if (!variable_global_exists("rock_max_level")) global.rock_max_level = 0;
if (!variable_global_exists("max_rock_count")) global.max_rock_count = 25; // 노업글시 초기 돌의 양

// 2. 공격 속도 (Mining Speed)
if (!variable_global_exists("level_atk_spd")) global.level_atk_spd = 0;
global.mining_Speed = 1.0 + (global.level_atk_spd * 0.2); // 1.0 + 레벨 * 0.2

// 4. 데미지 (Damage)
if (!variable_global_exists("level_dmg")) global.level_dmg = 0;
global.mining_Damage = 1 + (global.level_dmg * 0.5); // 1 + 레벨 * 0.5

// 5. 사거리 (Range)
if (!variable_global_exists("level_range")) global.level_range = 0;
global.Range_radius = 60 + (global.level_range * 4); // 32 + 레벨 * 4

// 6. 공격 각도 (Angle)
if (!variable_global_exists("level_angle")) global.level_angle = 0;
global.mining_Angle = 40 + (global.level_angle * 5); // 20 + 레벨 * 5

// 7. 제한 시간 (Time)
if (!variable_global_exists("level_time")) global.level_time = 0;
global.game_time_max = 20 + (global.level_time * 2); // 20 + 레벨 * 2 (광산에 들어갈 때 사용됨)

// 8. 광물 해금 레벨 (Mine Unlock Level)
if (!variable_global_exists("level_mine_unlock")) {
    global.level_mine_unlock = 0; // 0: 돌, 1: 은 해금, 2: 금 해금 등 3: diamond
}


// 9. 재화 배율 획득
if (!variable_global_exists("level_currency_gain")) global.level_currency_gain = 0;
global.currency_gain_multiplier = 100000000.0 + (global.level_currency_gain);

// 10. 광석 재생성 주기 (Rock Regen Cooldown)
if (!variable_global_exists("level_regen_cooldown")) global.level_regen_cooldown = 0;

// 툴팁 변수 초기화
if (!variable_global_exists("tooltip_title")) global.tooltip_title = "";
global.tooltip_desc = "";
global.tooltip_cost = "";
global.tooltip_value_current = "";
global.tooltip_value_next = "";

// 기본 주기는 60 프레임 (1초)으로 설정합니다. (room_speed가 60이라고 가정)
var _base_cooldown_max = 60; 

// 레벨당 5 프레임(약 0.08초)씩 주기가 단축된다고 가정합니다.
var _cooldown_reduction_per_level = 5;

global.rock_regen_cooldown_max = _base_cooldown_max - (global.level_regen_cooldown * _cooldown_reduction_per_level);

// 최소 주기는 10프레임(약 0.16초) 미만으로 내려가지 않도록 제한합니다.
if (global.rock_regen_cooldown_max < 10) global.rock_regen_cooldown_max = 10;

global.game_time = 20;		//노업글시 초기 Mine에서 보낼 수 있는 시간
global.is_playing = false;	//현재 채굴 중인가?
global.earned_currency = 0; //이번 판에 얻은 재화(결과창 용)

if(!variable_global_exists("currency")){
	global.currency = 0;
	}
