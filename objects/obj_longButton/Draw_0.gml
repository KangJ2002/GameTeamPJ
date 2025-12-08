draw_self();

// 🛑 네비게이션 버튼(광산 종료 시 버튼)인 경우
if (button_type == "RETRY" || button_type == "GO_SHOP" || button_type == "GO_MINE") {
    
    // 텍스트를 그리기 위한 설정
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_tip); // 폰트는 적절히 설정 (예: fnt_Basic)
    draw_set_color(c_lime);

    // 텍스트 표시
    draw_text(x, y, button_text); // ⬅️ 중앙에 button_text를 그립니다.

    exit; // 네비게이션 버튼이므로 나머지 업그레이드 로직은 무시하고 종료합니다.
}