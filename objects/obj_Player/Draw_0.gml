draw_self();

// 1. 그리기 설정
draw_set_color(c_red); 
draw_set_alpha(0.3); // 채워지는 영역이므로 투명도를 낮춥니다.

// 2. 공격 방향 계산
var _attack_dir = point_direction(x, y, mouse_x, mouse_y); 
var _start_angle = _attack_dir - (global.mining_Angle / 2); // 원뿔 시작 각도
var _end_angle = _attack_dir + (global.mining_Angle / 2);   // 원뿔 끝 각도

// 3. 원뿔(부채꼴) 그리기
draw_primitive_begin(pr_trianglefan);
draw_vertex(x, y); // 중심점 (부채꼴의 꼭짓점)

// 시작 각도에서 끝 각도까지 10도 간격으로 부채꼴 테두리를 그립니다.
for (var i = _start_angle; i <= _end_angle; i += 10) {
    var px = x + lengthdir_x(global.Range_radius, i);
    var py = y + lengthdir_y(global.Range_radius, i);
    draw_vertex(px, py);
}

// 부채꼴의 마지막 점
var px = x + lengthdir_x(global.Range_radius, _end_angle);
var py = y + lengthdir_y(global.Range_radius, _end_angle);
draw_vertex(px, py);

draw_primitive_end();



// 4. 그리기 설정 초기화
draw_set_alpha(1.0);
draw_set_color(c_white);