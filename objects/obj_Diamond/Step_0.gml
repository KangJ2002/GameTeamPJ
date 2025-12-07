// 1. 체력 비율 계산
var _hp_ratio = hp / hp_max;

// 2. 체력 비율을 기반으로 이미지 인덱스 결정
var _index = 0;

if (_hp_ratio > 0 && _hp_ratio <= 0.2) {
    _index = 4;
}
// 20% < HP 비율 <= 40%
else if (_hp_ratio > 0.2 && _hp_ratio <= 0.4) {
    _index = 3;
}
// 40% < HP 비율 <= 60%
else if (_hp_ratio > 0.4 && _hp_ratio <= 0.6) {
    _index = 2;
}
// 60% < HP 비율 <= 80%
else if (_hp_ratio > 0.6 && _hp_ratio <= 0.8) {
    _index = 1;
}
// 80% < HP 비율 <= 100% (가장 온전함)
else if (_hp_ratio > 0.8 && _hp_ratio <= 1.0) {
    _index = 0;
}

image_index = _index;