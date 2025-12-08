draw_set_font(fnt_tip);
draw_set_halign(fa_left);
draw_set_valign(fa_top);


var _x = 10;
var _y = 10;
var _currency_string;


var _icon_sprite = spr_money; // obj_money의 스프라이트 인덱스를 가져옵니다.
var _icon_x_offset = 10; // 아이콘의 X 위치 (10 + 10 마진)
var _text_x_offset = 35; // 텍스트의 시작 X 위치 (아이콘 너비를 고려한 마진)
var _icon_y_offset = 12; // 폰트 높이에 맞춰 아이콘을 중앙에 배치하기 위한 Y 오프셋 (폰트 크기에 따라 조정 가능)

if (room == room_Mine && global.is_playing == false && alarm[1] > 0) {
    
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    var _cx = _gui_w / 2;
    var _cy = _gui_h / 2;
    
    // 1. 반투명 배경
    draw_set_alpha(0.5);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    draw_set_alpha(1.0);
    
    // 2. 카운트다운 숫자 계산 및 표시
    // ceil() 함수는 남은 프레임을 초로 변환하고 올림하여 3, 2, 1 카운트가 자연스럽게 보이도록 합니다.
    var _countdown_sec = ceil(alarm[1] / room_speed); 
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_set_font(fnt_tip); // 더 크고 잘 보이는 폰트를 사용하세요 (예: fnt_Huge)
    
    // 숫자를 크게 그리기 (크기 3배)
    draw_text_transformed(_cx, _cy, string(_countdown_sec), 3, 3, 0); 
}

if (global.tooltip_title != "") {
    
    var _gui_w = display_get_gui_width();
    var _center_x = _gui_w / 2;
    var _top_y = 40; // 상단 위치
    var _line_h = 24; // 줄 간격
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_font(fnt_tip); // 적절한 폰트 사용
    
    // --- 1. 배경 그리기 ---
    var _box_w = 500; // 박스 너비
    var _box_h = 100; // 박스 높이
    draw_set_color(c_black);
    draw_set_alpha(0.8);
    draw_rectangle(_center_x - _box_w/2, _top_y, _center_x + _box_w/2, _top_y + _box_h, false);
    draw_set_alpha(1.0);
    
    // --- 2. 텍스트 그리기 ---
    
    // 2-1. 제목 (중앙 정렬)
    draw_set_color(c_lime);
    draw_set_font(fnt_tip); // 폰트 크기를 키우고 싶다면 다른 폰트 사용
    draw_text(_center_x, _top_y + 10, global.tooltip_title);
    
    // 2-2. 설명 (중앙 정렬)
    draw_set_color(c_white);
    draw_text(_center_x, _top_y + 10 + _line_h, global.tooltip_desc);
    
    // 2-3. 비용 & 수치 (왼쪽, 오른쪽 정렬)
    draw_set_halign(fa_left); // 왼쪽 정렬로 변경
    draw_set_valign(fa_top);
    var _left_x = _center_x - _box_w/2 + 20; // 좌측 여백 20
    var _right_x = _center_x + _box_w/2 - 20; // 우측 여백 20
    
    // 비용 (왼쪽)
    draw_set_color(c_yellow);
    draw_text(_left_x, _top_y + 10 + _line_h * 2, "Cost:");
    draw_text(_left_x + 60, _top_y + 10 + _line_h * 2, global.tooltip_cost);
    
    // 수치 (오른쪽)
    draw_set_halign(fa_right); // 우측 정렬로 변경
    draw_set_color(c_aqua);
    draw_text(_right_x, _top_y + 10 + _line_h * 2, "-> " + global.tooltip_value_next);
    draw_set_color(c_white);
    draw_text(_right_x - 50, _top_y + 10 + _line_h * 2, "L " + global.tooltip_value_current);
    
    // 툴팁이 켜져 있을 때만 그리는 로직 끝
}


// ----------------------------------------------------
// 1. 재화 표시 (N + M 형식 적용)
// ----------------------------------------------------
if (room != room_Intro) {
	draw_set_halign(fa_left); // 추가: 정렬을 좌측 정렬로 재설정
    draw_set_valign(fa_top); // 추가: 정렬을 상단 정렬로 재설정
	// 광산 룸이고, 현재 플레이 중일 때 (시간이 흐르고 있을 때)
	if (room == room_Mine && global.is_playing == true) {
    
	    // (A) 시작 금액 (N)은 Room Start 이벤트에서 저장된 값입니다.
	    var _original_gold = global.gold_at_start;
    
	    // (B) 획득 금액 (M)은 현재 총액에서 시작 금액을 뺀 값입니다.
	    var _earned_gold = global.currency - _original_gold; 
    
	    // 표시 형식: "Gold : N + M"
	    _currency_string = string(int64(_original_gold)) + " + " + string(int64(_earned_gold));
    
	    draw_set_color(c_lime); // 획득 금액을 강조하기 위해 밝은 색상 사용
    
	} else {
	    // 상점, 허브 룸 또는 광산의 결과창일 때: 총 금액만 표시
		
	    _currency_string = string(int64(global.currency));
	    draw_set_color(c_yellow);
	}

	// 최종 텍스트 그리기
	draw_sprite(_icon_sprite, 0, _x + _icon_x_offset, _y + _icon_y_offset);
    
    // 🆕 2. 텍스트를 아이콘 오른쪽에서 그립니다.
	draw_text(_x + _text_x_offset, _y, _currency_string);

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
			if (alarm[1] <= 0) { 
        
	        var _cx = display_get_gui_width() / 2;
	        var _cy = display_get_gui_height() / 2;
        
		        // 화면 중앙 계산
		        var _cx = display_get_gui_width() / 2;
		        var _cy = display_get_gui_height() / 2;
        
		        // 반투명 검은 배경
		       // draw_set_alpha(0.8);
		       // draw_set_color(c_black);
		       // draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
		      //  draw_set_alpha(1.0);

				// --- [재화 계산] ---
				var _original_gold = global.gold_at_start;              // 원래 있던 돈
				var _current_gold  = global.currency;                   // 현재 총 돈
				var _earned_gold   = _current_gold - _original_gold;    // 이번 판에 번 돈
    
				// --- [텍스트 그리기] ---
				draw_set_halign(fa_center);
    
				// 1. 타이틀
				draw_set_color(c_white);
				draw_set_font(fnt_tip); // 폰트가 있다면 설정
				draw_text_transformed(_cx, _cy - 100, "TIME UP!", 3, 3, 0); // 좀 더 크게 표시
    
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
				
				if (end_buttons_created == false) {
			        var _cx = display_get_gui_width() / 2;
			        var _cy = display_get_gui_height() / 2;
        
			        var _btn_y_offset = -60;

			        // 1. '다시하기' 버튼 생성
			        var _btn_retry = instance_create_layer(_cx - 150, _cy + _btn_y_offset, "Instances", obj_longButton);
			        _btn_retry.button_type = "RETRY"; // 💡 타입 설정
			        _btn_retry.button_text = "다시하기"; // 텍스트 설정
					_btn_retry.depth = -1000;
					
					// 2. '상점으로' 버튼 생성
					var _btn_shop = instance_create_layer(_cx - 270, _cy + _btn_y_offset, "Instances", obj_longButton);
			        _btn_shop.button_type = "GO_SHOP"; // 💡 타입 설정
			        _btn_shop.button_text = "상점으로"; // 텍스트 설정
			        _btn_shop.depth = -1000;
					
					end_buttons_created = true;
				}
		    }
		}
	}
}