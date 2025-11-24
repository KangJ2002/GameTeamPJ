switch (upgrade_type) {
    case "MINING_DAMAGE": current_level = global.level_dmg; break;
    case "MINING_SPEED":  current_level = global.level_atk_spd; break;
    case "MOVE_SPEED":    current_level = global.level_move_spd; break;
    case "RANGE_RADIUS":  current_level = global.level_range; break;
    case "MINING_ANGLE":  current_level = global.level_angle; break;
    case "GAME_TIME":     current_level = global.level_time; break;
    case "ROCK_MAX_COUNT":current_level = global.rock_max_level; break;
}

var _next_level = current_level + 1;
is_max_level = (current_level >= max_level);

if (is_max_level) {
    next_stat_value = 0;
    upgrade_cost = 0;
    can_afford = false;
    exit;
}

upgrade_cost = 5 * _next_level; //업그레이드 비용 (조정필요)

switch (upgrade_type) {
    case "MINING_DAMAGE":  
        next_stat_value = 1 + (_next_level * 1); // 1씩 증가
        break;
    case "MINING_SPEED":   
        next_stat_value = 1.0 + (_next_level * 0.2); // 0.2씩 증가
        break;
    case "MOVE_SPEED":     
        next_stat_value = 3 + (_next_level * 2); // 2씩 증가
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
        next_stat_value = 25 + (_next_level * 4); // 4개씩 증가
        break;
}

// 3. 구매 가능 여부 확인
// ----------------------------------------------------
can_afford = (global.currency >= upgrade_cost);