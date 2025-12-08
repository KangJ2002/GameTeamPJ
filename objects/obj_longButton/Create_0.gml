button_type = "UNASSIGNED"; 
button_text = "";
// 이 버튼이 위치한 룸에 따라 기본 텍스트를 설정합니다.
if (room == room_Shop11) {
    // 상점 룸: 광산으로 가는 버튼
    button_type = "GO_MINE";
    button_text = "광산으로";
}