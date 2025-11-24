draw_set_font(fnt_Basic);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var _x = 10;
var _y = 10;
var _currency_string;

// ----------------------------------------------------
// 1. 재화 표시 (N + M 형식 적용)
// ----------------------------------------------------
if (room != room_Intro) {
	// 광산 룸이고, 현재 플레이 중일 때 (시간이 흐르고 있을 때)
	if (room == room_Mine && global.is_playing == true) {
    
	    // (A) 시작 금액 (N)은 Room Start 이벤트에서 저장된 값입니다.
	    var _original_gold = global.gold_at_start;
    
	    // (B) 획득 금액 (M)은 현재 총액에서 시작 금액을 뺀 값입니다.
	    var _earned_gold = global.currency - _original_gold; 
    
	    // 표시 형식: "Gold : N + M"
	    _currency_string = "Gold : " + string(int64(_original_gold)) + " + " + string(int64(_earned_gold));
    
	    draw_set_color(c_lime); // 획득 금액을 강조하기 위해 밝은 색상 사용
    
	} else {
	    // 상점, 허브 룸 또는 광산의 결과창일 때: 총 금액만 표시
	    _currency_string = "Gold : " + string(int64(global.currency));
	    draw_set_color(c_yellow);
	}

	// 최종 텍스트 그리기
	draw_text(_x, _y, _currency_string);

	// ----------------------------------------------------
	// 2. 타이머 및 결과창 표시
	// ----------------------------------------------------

	// 2. 타이머 표시 (광산 룸에서만)
	if (room == room_Mine) {
	    draw_set_color(c_white);
	    if (global.game_time <= 5) draw_set_color(c_red); // 5초 남으면 빨간색
    
	    // 소수점 없이 정수로 표시
	    draw_text(10, 40, "Time : " + string(ceil(global.game_time)));
    
	    // 3. 결과창 표시 (시간이 끝났을 때)
	    if (global.is_playing == false && global.game_time <= 0) {
        
	        // 화면 중앙 계산
	        var _cx = display_get_gui_width() / 2;
	        var _cy = display_get_gui_height() / 2;
        
	        // 반투명 검은 배경
	        draw_set_alpha(0.8);
	        draw_set_color(c_black);
	        draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
	        draw_set_alpha(1.0);

			// --- [재화 계산] ---
			var _original_gold = global.gold_at_start;              // 원래 있던 돈
			var _current_gold  = global.currency;                   // 현재 총 돈
			var _earned_gold   = _current_gold - _original_gold;    // 이번 판에 번 돈
    
			// --- [텍스트 그리기] ---
			draw_set_halign(fa_center);
    
			// 1. 타이틀
			draw_set_color(c_white);
			draw_set_font(fnt_Basic); // 폰트가 있다면 설정
			draw_text_transformed(_cx, _cy - 100, "TIME UP!", 2, 2, 0); // 좀 더 크게 표시
    
			// 2. 재화 정산 내역 표시
			var _line_height = 30; // 줄 간격
			var _start_y = _cy - 20;
    
			// (1) 기존 재화
			draw_set_color(c_ltgray); // 밝은 회색
			draw_text(_cx, _start_y, "Original Gold : " + string(int64(_original_gold)));
    
			// (2) 획득한 재화 (강조)
			draw_set_color(c_lime); // 형광 초록색
			draw_text(_cx, _start_y + _line_height, "Earned : + " + string(int64(_earned_gold)));
    
			// (3) 구분선 (------)
			draw_set_color(c_white);
			draw_text(_cx, _start_y + _line_height * 2, "------------------");
    
			// (4) 최종 합계
			draw_set_color(c_yellow); // 노란색
			draw_text(_cx, _start_y + _line_height * 3, "Total Gold : " + string(int64(_current_gold)));
        
	    }
	}
}