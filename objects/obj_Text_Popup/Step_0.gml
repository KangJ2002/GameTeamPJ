// 1. y 좌표를 변경하여 위로 상승
y += vspeed;

// 2. 시간이 지날수록 상승 속도를 줄여 부드럽게 정지 (감속)
vspeed *= 0.95; 

// 3. 생명 시간 감소
life_time--;

// 4. 생명 시간이 다 되면 파괴
if (life_time <= 0) {
    instance_destroy();
}