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
        case "MOVE_SPEED":
            global.level_move_spd++;
            global.move_speed = next_stat_value;
            //플레이어 이동 속도 재설정
            with (obj_Player) {
                spd = global.move_speed;
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
    }
	show_debug_message("✅ " + upgrade_type + " Upgraded to Level " + string(current_level + 1) + "! Cost: " + string(upgrade_cost));
} else {
    show_debug_message("❌ Not enough gold. Need: " + string(upgrade_cost) + " gold.");
}