upgrade_type = "UNASSIGNED";

current_level = 0;
max_level = 100; // 모든 업그레이드는 100 레벨이 최대라고 가정


// 버튼의 상태를 나타내는 변수
can_afford = false; // 구매 가능한가?
is_max_level = false; // 최대 레벨인가?

switch (upgrade_type) {
	    case "MINING_DAMAGE":  description_text = "곡괭이의 데미지를 영구적으로 증가시킵니다."; break;
	    case "MINING_SPEED":   description_text = "곡괭이의 초당 공격 횟수를 영구적으로 증가시킵니다."; break;
	    case "RANGE_RADIUS":   description_text = "곡괭이의 공격 사거리를 영구적으로 증가시킵니다."; break;
	    case "MINING_ANGLE":   description_text = "곡괭이의 공격 각도를 영구적으로 증가시킵니다."; break;
	    case "GAME_TIME":      description_text = "광산 탐사 제한 시간을 증가시킵니다."; break;
	    case "ROCK_MAX_COUNT": description_text = "광산에 존재할 수 있는 광석의 최대 개수를 증가시킵니다."; break;
	    case "REGEN_COOLDOWN": description_text = "광석의 재생성 주기를 단축시켜 광물 공급을 빠르게 합니다."; break;
	    case "CURRENCY_GAIN":  description_text = "광석 채굴 시 획득하는 재화의 양을 증가시킵니다."; break;
	    case "MINE_UNLOCK":    description_text = "더 단단하고 더 높은 가치를 가진 광물을 해금합니다."; break;
}