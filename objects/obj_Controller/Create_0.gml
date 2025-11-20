alarm[0] = 60;

// 아직 전역 곡괭이 정보가 없다면 초기화
if (!variable_global_exists("current_pickaxe")) {
    global.current_pickaxe = 1;  // 처음엔 1번 곡괭이(= obj_Pickax1)를 쓰도록
}