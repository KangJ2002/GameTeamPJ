// 1. 투명도 계산 (life_time이 줄어들수록 투명해짐)
var _alpha = life_time / life_time_max;

// 2. 그리기 설정 적용
draw_set_alpha(_alpha);
draw_set_color(display_color);
draw_set_halign(fa_center);
draw_set_font(fnt_Popup); // 사용하는 폰트로 설정해주세요 (예: fnt_Basic)

// 3. 텍스트 그리기
draw_text(x, y, display_text);

// 4. 그리기 설정 원상 복구 (다른 오브젝트에 영향을 주지 않도록 중요!)
draw_set_alpha(1);
draw_set_color(c_white);