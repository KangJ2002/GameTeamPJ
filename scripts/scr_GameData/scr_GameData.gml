// [스크립트: scr_GameData]

// ====================================================
// 💾 게임 저장 함수
// ====================================================
function save_game() {
    // 1. 세이브 파일 열기 (없으면 생성됨)
    ini_open("save.ini");

    // 2. 데이터 쓰기 (섹션, 키, 값)
    // [Player] 섹션
    ini_write_real("Player", "Currency", global.currency);

    // [Upgrade] 섹션 (레벨들만 저장하면 됩니다)
    ini_write_real("Upgrade", "Level_RockMax", global.rock_max_level);
    ini_write_real("Upgrade", "Level_AtkSpd", global.level_atk_spd);
    ini_write_real("Upgrade", "Level_MoveSpd", global.level_move_spd);
    ini_write_real("Upgrade", "Level_Dmg", global.level_dmg);
    ini_write_real("Upgrade", "Level_Range", global.level_range);
    ini_write_real("Upgrade", "Level_Angle", global.level_angle);
    ini_write_real("Upgrade", "Level_Time", global.level_time);

    // 3. 파일 닫기
    ini_close();
    
    show_debug_message("💾 게임 저장 완료!");
}

// ====================================================
// 📂 게임 불러오기 함수
// ====================================================
function load_game() {
    if (file_exists("save.ini")) {
        ini_open("save.ini");

        // 1. 데이터 읽기 (값이 없으면 0을 기본값으로 사용)
        global.currency = ini_read_real("Player", "Currency", 0);
        
        global.rock_max_level = ini_read_real("Upgrade", "Level_RockMax", 0);
        global.level_atk_spd = ini_read_real("Upgrade", "Level_AtkSpd", 0);
        global.level_move_spd = ini_read_real("Upgrade", "Level_MoveSpd", 0);
        global.level_dmg = ini_read_real("Upgrade", "Level_Dmg", 0);
        global.level_range = ini_read_real("Upgrade", "Level_Range", 0);
        global.level_angle = ini_read_real("Upgrade", "Level_Angle", 0);
        global.level_time = ini_read_real("Upgrade", "Level_Time", 0);

        ini_close();

        // 2. 읽어온 레벨을 바탕으로 실제 스탯 재계산 (Create_0.gml의 공식 사용)
        // 공식은 작성하신 코드 기준으로 복원했습니다.
        global.max_rock_count = 25 + (global.rock_max_level * 4);
        global.mining_Speed = 1.0 + (global.level_atk_spd * 0.2); 
        global.move_speed = 3 + (global.level_move_spd * 0.5); 
        global.mining_Damage = 1 + (global.level_dmg * 0.5); 
        global.Range_radius = 32 + (global.level_range * 4); 
        global.mining_Angle = 20 + (global.level_angle * 5); 
        global.game_time_max = 20 + (global.level_time * 2); 

        show_debug_message("📂 게임 불러오기 완료!");
        return true; // 성공
    } else {
        show_debug_message("❌ 세이브 파일이 없습니다.");
        return false; // 실패
    }
}