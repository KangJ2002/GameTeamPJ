switch (upgrade_type) {
    case "MINING_DAMAGE": current_level = global.level_dmg; break;
    case "MINING_SPEED":  current_level = global.level_atk_spd; break;
    case "RANGE_RADIUS":  current_level = global.level_range; break;
    case "MINING_ANGLE":  current_level = global.level_angle; break;
    case "GAME_TIME":     current_level = global.level_time; break;
    case "ROCK_MAX_COUNT":current_level = global.rock_max_level; break;
	case "MINE_UNLOCK":	  current_level = global.level_mine_unlock; break;
	case "CURRENCY_GAIN": current_level = global.level_currency_gain; break;
    case "REGEN_COOLDOWN":current_level = global.level_regen_cooldown; break;
	default:
        current_level = 0; 
        break;
}

var _next_level = current_level + 1;
// ----------------------------------------------------
// 💡 최대 레벨(MAX_LEVEL) 설정: 이 부분을 추가 및 수정합니다.
// ----------------------------------------------------
max_level = 500; // 기본값

switch (upgrade_type) {
    case "MINE_UNLOCK":
        max_level = 3;
        break;
    case "ROCK_MAX_COUNT":
        max_level = 42;
        break;
    case "MINING_DAMAGE":
        max_level = 150;
        break;
    case "MINING_SPEED":
        max_level = 80;
        break;
    case "RANGE_RADIUS":
        max_level = 15; 
        break;
    case "MINING_ANGLE":
        max_level = 16;
        break;
    case "GAME_TIME":
        max_level = 5; 
        break;
    case "CURRENCY_GAIN":
        max_level = 50; 
        break;
    case "REGEN_COOLDOWN":
        max_level = 10; 
        break;
}

is_max_level = (current_level >= max_level);

if (is_max_level) {
    next_stat_value = 0;
    upgrade_cost = 0;
    can_afford = false;
}

var _current_mine_type_name = "";
if (upgrade_type == "MINE_UNLOCK") {
    if (current_level == 0) {
        _current_mine_type_name = "Stone Mine"; // Level 0: 돌 광산 (기본)
    } else if (current_level == 1) {
        _current_mine_type_name = "Silver Mine"; // Level 1: 은 광산
    } else if (current_level == 2) {
        _current_mine_type_name = "Gold Mine";  // Level 2: 금 광산
    } else if (current_level >= 3) {
         _current_mine_type_name = "Diamond Mine"; // Level 3 이상: 다이아몬드
    }
}

upgrade_cost = 0;

switch (upgrade_type) {
    case "MINING_DAMAGE":  
        next_stat_value = 1 + (_next_level * 1); 
        upgrade_cost = round(5 * power(1.15, _next_level - 1)); // 기본값 5, 1.15 지수형식증가 최종3000만정도 소비
        break;
        
    case "MINING_SPEED":   
        next_stat_value = 1.0 + (_next_level * 0.1); 
        upgrade_cost = round(5 * power(1.2, _next_level - 1));
        break;
        
    case "RANGE_RADIUS":   
        next_stat_value = 60 + (_next_level * 20); 
        upgrade_cost = round(100 * power(1.9, _next_level - 1));
        break;
        
    case "MINING_ANGLE":   
        next_stat_value = 40 + (_next_level * 20); 
        upgrade_cost = round(70 * power(1.7, _next_level - 1));
        break;
        
    case "GAME_TIME":      
        next_stat_value = 20 + (_next_level * 2); 
        upgrade_cost = round(20 * power(1.7, _next_level - 1));
        break;
        
    case "ROCK_MAX_COUNT": 
        var _base_count = 25; 
        var _per_level_increase = 3; 
        next_stat_value = _base_count + (_next_level * _per_level_increase);
        var _max_limit = 150;
        if (next_stat_value > _max_limit) {
            next_stat_value = _max_limit;
        }
        upgrade_cost = round( 70 * power(1.20, _next_level - 1));
        break;
        
    case "MINE_UNLOCK":
        next_stat_value = 0; 
        upgrade_cost = round(500 * power(20 ,_next_level - 1)); 
        break;    
        
    case "CURRENCY_GAIN":  
        next_stat_value = 1.0 + (_next_level * 1); 
        upgrade_cost = round(30 * power(1.317, _next_level - 1));
        break;
        
    case "REGEN_COOLDOWN": 
        var _base_cooldown = 60; 
        var _reduction = 5;  
        next_stat_value = _base_cooldown - (_next_level * _reduction);
        if (next_stat_value < 10) next_stat_value = 10;
        upgrade_cost = round( 150 * power(1.8 , _next_level - 1));
        break;
        
    default:
        next_stat_value = 0; 
        upgrade_cost = 0;
        break;
}

// 3. 구매 가능 여부 확인
// ----------------------------------------------------
can_afford = (global.currency >= upgrade_cost);


if (point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom)) {
    
	switch (upgrade_type) {
	    case "MINING_DAMAGE":  description_text = "곡괭이의 데미지를 영구적으로 증가시킵니다."; break;
	    case "MINING_SPEED":   description_text = "곡괭이의 초당 공격 횟수를 영구적으로 증가시킵니다."; break;
	    case "RANGE_RADIUS":   description_text = "곡괭이의 공격 사거리를 영구적으로 증가시킵니다."; break;
	    case "MINING_ANGLE":   description_text = "곡괭이의 공격 각도를 영구적으로 증가시킵니다."; break;
	    case "GAME_TIME":      description_text = "광산 탐사 제한 시간을 증가시킵니다."; break;
	    case "ROCK_MAX_COUNT": description_text = "광산에 존재할 수 있는 광석의 최대 개수를 증가시킵니다."; break;
	    case "REGEN_COOLDOWN": description_text = "광석의 재생성 주기를 단축시켜 광물 공급을 빠르게 합니다."; break;
	    case "CURRENCY_GAIN":  description_text = "광석 채굴 시 획득하는 재화의 양을 증가시킵니다."; break;
	    case "MINE_UNLOCK":    description_text = "더 단단하고 더 높은 가치를 가진 광물을 해금합니다."; break;
}

// --- 💡 현재 스탯 값 가져오기 로직 추가 시작 ---
var _current_stat_value = 0;
var _decimals = 0; // 현재 값과 다음 값의 소수점 자릿수 처리를 위한 변수

switch (upgrade_type) {
    case "MINING_DAMAGE":  
        _current_stat_value = global.mining_Damage; // 전역 변수에서 현재 데미지 값 가져오기
        _decimals = 1; 
        break;
    case "MINING_SPEED":  
        _current_stat_value = global.mining_Speed;
        _decimals = 1; 
        break;
    case "RANGE_RADIUS":  
        _current_stat_value = global.Range_radius;
        break;
    case "MINING_ANGLE":  
        _current_stat_value = global.mining_Angle;
        break;
    case "GAME_TIME":     
        _current_stat_value = global.game_time_max;
        break;
    case "ROCK_MAX_COUNT": 
        _current_stat_value = global.max_rock_count;
        break;
    case "CURRENCY_GAIN":
        _current_stat_value = global.currency_gain_multiplier;
        _decimals = 1;
        break;
    case "REGEN_COOLDOWN":
        _current_stat_value = global.rock_regen_cooldown_max;
        break;
    case "MINE_UNLOCK":
		_current_stat_value = current_level + 1; 
	    _decimals = 0; // 정수형이므로 소수점은 0
	    break;
    default:
        _current_stat_value = 0;
        break;
}
// --- 💡 현재 스탯 값 가져오기 로직 추가 끝 ---
	
    // 마우스가 버튼 위에 있다면, 컨트롤러에게 설명을 표시하도록 요청
    // 툴팁에 필요한 모든 정보를 전역 변수에 저장합니다.
  global.tooltip_title = string_upper(upgrade_type); // 제목은 대문자로
    global.tooltip_desc = description_text; 
	var _is_mine_unlock = (upgrade_type == "MINE_UNLOCK");
    
    
    var _next_decimals = (upgrade_type == "MINING_SPEED" || upgrade_type == "CURRENCY_GAIN" || upgrade_type == "MINING_DAMAGE" ? 1 : 0);
    
    if (is_max_level) {
        global.tooltip_cost = "Max Level";
        
        // 💡 수정 1: 현재 수치 할당 (MAX 레벨)
        if (_is_mine_unlock) {
             // MINE_UNLOCK은 '레벨 + 1' 값을 문자로 표시
             global.tooltip_value_current = string(_current_stat_value); 
        } else {
             // 나머지 스탯은 포맷된 수치 사용
             global.tooltip_value_current = string_format(_current_stat_value, 0, _decimals); 
        }
        
global.tooltip_value_next = "MAX";
    } else {
        global.tooltip_cost = string(upgrade_cost);
        
        // 💡 수정 2: 현재 수치 할당 (업그레이드 가능)
        if (_is_mine_unlock) {
            // MINE_UNLOCK은 '레벨 + 1' 값을 문자로 표시
            global.tooltip_value_current = string(_current_stat_value);
        } else {
            // 나머지 스탯은 포맷된 수치 사용
            global.tooltip_value_current = string_format(_current_stat_value, 0, _decimals);
        }
        
        // 💡 수정 3: 다음 수치 할당
        if (_is_mine_unlock) {
            // 다음 레벨 + 1을 문자로 표시
            var _next_level_display = _next_level + 1; 
            global.tooltip_value_next = string(_next_level_display);
        } else {
            // 나머지 스탯에 대한 다음 수치 할당
            global.tooltip_value_next = string_format(next_stat_value, 0, _next_decimals);
        }
	}
}
