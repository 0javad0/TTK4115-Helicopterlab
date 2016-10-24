start_time = 7
first_move_delay = 5
second_move_delay = 1
third_move_delay = 5
fourth_move_delay = 5
fifth_move_delay = 2
sixth_move_delay = 2

ctrl_enable = 1

val1 = 0.7; %pitch right
val2 = 0; %pitch 0
val3 = -0.7; %pitch left
val4 = 0;%pitch 0

val5 = 0.5 %elevation up
val6 = -0.5 %elevation down
val7 = 0 %elevation 0

val8_integral = 0.4;

current_v = 0;
v1 = val1;
current_v = current_v + v1;
v2 = val2 - current_v;
current_v = current_v + v2;
v3 = val3 - current_v;
current_v = current_v + v3;
v4 = val4 - current_v;

current_v = 0;
v5 = val5;
current_v = current_v + v5;
v6 = val6 - current_v;
current_v = current_v + v6
v7 = val7 - current_v;

v8_integral = val8_integral;
v9_integral = -val8_integral;

t1 = start_time
t2 = t1 + first_move_delay
t3 = t2 + second_move_delay
t4 = t3 + third_move_delay
t5 = t4 + fourth_move_delay
t6 = t5 + fifth_move_delay
t7 = t6 + sixth_move_delay
t8_integral = t1/8;
