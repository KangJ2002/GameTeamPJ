if (is_max_level) {
    show_debug_message("MAX LEVEL!");
    exit;
}

if (can_afford) {
    // 비용 지불
    global.currency -= upgrade_cost;
	// 해당 스탯 레벨 증가 및 실제 스탯 값 갱신
    switch (upgrade_type) {
        case "MINING_DAMAGE":
            global.level_dmg++;
            global.mining_Damage = next_stat_value;
            break;
        case "MINING_SPEED":
            global.level_atk_spd++;
            global.mining_Speed = next_stat_value;
            // 플레이어 쿨타임 재설정
            with (obj_Player) {
                mining_cooldown_max = room_speed / global.mining_Speed; 
            }
            break;
        case "RANGE_RADIUS":
            global.level_range++;
            global.Range_radius = next_stat_value;
            break;
        case "MINING_ANGLE":
            global.level_angle++;
            global.mining_Angle = next_stat_value;
            break;
        case "GAME_TIME":
            global.level_time++;
            // 최대 시간만 업데이트. 현재 시간은 Room Start 시에만 적용됨
            global.game_time_max = next_stat_value; 
            break;
        case "ROCK_MAX_COUNT":
            global.rock_max_level++;
            global.max_rock_count = next_stat_value;
            break;
		case "MINE_UNLOCK": // 새로 추가
		    global.level_mine_unlock++; // 해금 레벨 증가
		    break;	
		case "CURRENCY_GAIN":
	        global.level_currency_gain++;
	        global.currency_gain_multiplier = next_stat_value;
	        break;
		case "REGEN_COOLDOWN":
	        global.level_regen_cooldown++;
	        global.rock_regen_cooldown_max = next_stat_value; // 새로운 쿨타임 최대값 저장
	        break;
	
    }
}

audio_play_sound(ui, 1, false);