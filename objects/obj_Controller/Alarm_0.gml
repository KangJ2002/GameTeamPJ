var max_count = 10;

if (instance_number(obj_Rock) < max_count) {
    var rx = irandom(room_width);
    var ry = irandom(room_height);
    instance_create_layer(rx, ry, "Instances", obj_Rock);
}


alarm[0] = 180; 