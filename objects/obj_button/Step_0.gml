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
if (upgrade_type == "MINE_UNLOCK") { //MINE_UNLOCK의 MAX_LEVEL
    max_level = 3; 
}
if (upgrade_type == "ROCK_MAX_COUNT") {  //ROCK_COUNT의 MAX_LEVEL
    max_level = 42; 
}

is_max_level = (current_level >= max_level);

if (is_max_level) {
    next_stat_value = 0;
    upgrade_cost = 0;
    can_afford = false;
}

upgrade_cost = 5 * _next_level; //업그레이드 비용 (조정필요)

switch (upgrade_type) {
    case "MINING_DAMAGE":  
        next_stat_value = 1 + (_next_level * 1); // 1씩 증가
        break;
    case "MINING_SPEED":   
        next_stat_value = 1.0 + (_next_level * 0.2); // 0.2씩 증가
        break;
    case "RANGE_RADIUS":   
        next_stat_value = 32 + (_next_level * 4); // 4씩 증가
        break;
    case "MINING_ANGLE":   
        next_stat_value = 20 + (_next_level * 5); // 5씩 증가
        break;
    case "GAME_TIME":      
        next_stat_value = 20 + (_next_level * 2); // 2초씩 증가
        break;
    case "ROCK_MAX_COUNT": 
		var _base_count = 25; // 기본값 25
        var _per_level_increase = 3; // 레벨당 3개씩 고정 증가
		next_stat_value = _base_count + (_next_level * _per_level_increase);
		var _max_limit = 150;
        if (next_stat_value > _max_limit) {
            next_stat_value = _max_limit;
        }
		upgrade_cost = 10 * (_next_level * _next_level);
        break;
		
	case "MINE_UNLOCK":
        var _next_mine_type_name = "";
        if (_next_level == 1) {
            _next_mine_type_name = "Silver Mine"; // Level 1 해금: 은 광석
        } else if (_next_level == 2) {
            _next_mine_type_name = "Gold Mine";   // Level 2 해금: 금 광석
        } else if (_next_level == 3) {
             _next_mine_type_name = "Diamond Mine";// Diamond
        }
		// 다음 스탯 값 대신 이 문자열을 저장 (Draw 이벤트에서 사용)
        next_stat_value_string = _next_mine_type_name; 
        
        // MINE_UNLOCK의 비용은 다른 스탯보다 비싸게 설정할 수 있습니다.
		next_stat_value = 0; // 더미 값 0 할당
        upgrade_cost = 50 * _next_level; 
        break;	
		
	// 🆕 재화 획득 증가 (CURRENCY_GAIN) 추가
    case "CURRENCY_GAIN":   
        // 0.2씩 증가하므로, 다음 레벨 값은 1.0 + (다음 레벨 * 0.2)
        next_stat_value = 1.0 + (_next_level); 
        break;
		
	case "REGEN_COOLDOWN":   
        var _base_cooldown = 60; // 기본 60프레임
        var _reduction = 5;      // 레벨당 5프레임 감소
        
        next_stat_value = _base_cooldown - (_next_level * _reduction);
        
        // 최소값 10프레임 제한을 표시
        if (next_stat_value < 10) next_stat_value = 10;
        
        break;
	default:
        // "UNASSIGNED" 또는 정의되지 않은 타입이 들어올 경우
        next_stat_value = 0; // next_stat_value를 0으로 안전하게 설정합니다.
        // 다음 스탯 값은 0이 되고, 툴팁에 "N/A"나 "0"이 표시될 것입니다.
        break;
}

// 3. 구매 가능 여부 확인
// ----------------------------------------------------
can_afford = (global.currency >= upgrade_cost);


if (point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom)) {
    
	switch (upgrade_type) {
	    case "MINING_DAMAGE":  description_text = "곡괭이의 기본 데미지를 영구적으로 증가시킵니다."; break;
	    case "MINING_SPEED":   description_text = "곡괭이의 기본 공격 속도를 영구적으로 증가시킵니다."; break;
	    case "RANGE_RADIUS":   description_text = "곡괭이 공격의 사거리(범위)를 영구적으로 증가시킵니다."; break;
	    case "MINING_ANGLE":   description_text = "곡괭이 공격의 각도(범위)를 영구적으로 증가시킵니다."; break;
	    case "GAME_TIME":      description_text = "광산 탐사 제한 시간을 증가시킵니다."; break;
	    case "ROCK_MAX_COUNT": description_text = "광산에 존재할 수 있는 광석의 최대 개수를 증가시킵니다."; break;
	    case "REGEN_COOLDOWN": description_text = "광석의 재생성 주기를 단축시켜 광물 공급을 빠르게 합니다."; break;
	    case "CURRENCY_GAIN":  description_text = "광석 채굴 시 획득하는 재화의 양을 증가시킵니다."; break;
	    case "MINE_UNLOCK":    description_text = "더 높은 가치를 가진 광물을 해금합니다."; break;

    // 1단계에서 upgrade_type이 ""일 경우(설정 누락)를 대비한 안전 장치
    default: 
        description_text = "⚠️ 업그레이드 타입이 설정되지 않았습니다. (Type: " + upgrade_type + ")"; 
        break;
}
	
    // 마우스가 버튼 위에 있다면, 컨트롤러에게 설명을 표시하도록 요청
    // 툴팁에 필요한 모든 정보를 전역 변수에 저장합니다.
    global.tooltip_title = string_upper(upgrade_type); // 제목은 대문자로
    global.tooltip_desc = description_text; 
    
    if (is_max_level) {
        global.tooltip_cost = "Max Level";
        global.tooltip_value_current = string(current_level);
        global.tooltip_value_next = "MAX";
    } else {
        global.tooltip_cost = string(upgrade_cost);
        global.tooltip_value_current = string(current_level);
        
        // 다음 스탯 값은 소수점 처리 (MINING_SPEED나 CURRENCY_GAIN과 같은 경우)
        var _decimals = (upgrade_type == "MINING_SPEED" || upgrade_type == "CURRENCY_GAIN" ? 1 : 0);
        global.tooltip_value_next = string_format(next_stat_value, 0, _decimals);
    }
}