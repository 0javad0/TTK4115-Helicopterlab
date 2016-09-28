% This file contains the initialization for the helicopter assignment in
% the course TTK4115. Run this file before you execute QuaRC_ -> Build 
% to build the file heli_q8.mdl.

% Oppdatert høsten 2006 av Jostein Bakkeheim
% Oppdatert høsten 2008 av Arnfinn Aas Eielsen
% Oppdatert høsten 2009 av Jonathan Ronen
% Updated fall 2010, Dominik Breu
% Updated fall 2013, Mark Haring
% Updated spring 2015, Mark Haring


%%%%%%%%%%% Calibration of the encoder and the hardware for the specific
%%%%%%%%%%% helicopter
Joystick_gain_x = 0; % Var 1 /// 0.5
Joystick_gain_y = -0.5; % Var -1 /// -1


%%%%%%%%%%% Physical constants
g = 9.81; % gravitational constant [m/s^2]
l_c = 0.46; % distance elevation axis to counterweight [m]
l_h = 0.66; % distance elevation axis to helicopter head [m]
l_p = 0.175; % distance pitch axis to motor [m]
m_c = 1.92; % Counterweight mass [kg]
m_p = 0.72; % Motor mass [kg]


%%%%%%%%%%% User defined constants
%V_s_s = 7.5; % Vs* voltage Vs when e~, p~, lambda~, and their derivatives are 0
J_p = 2*m_p*l_p^2;
J_e = m_c*l_c^2+2*m_p*l_h^2;
J_lambda = m_c*l_c^2+2*m_p*(l_h^2+l_p^2);





L_2 = m_c*g*l_c-2*m_p*g*l_h;
L_1 = l_p*K_f; % Pitch is defined as positive in the counter clockwise direction
L_3 = l_h*K_f;
V_s_s = -L_2/L_3
K_f = -L_2/(l_h*V_s_s);


K_1 = L_1/J_p;
K_2 = L_3/J_e;


%{
%For god fasemargin:
K_pp = 3;
K_pd = 4*K_pp/K_1 + 10;

s = tf('s');


tran = K_1*K_pp/(s^2+K_1*K_pd*s+K_1*K_pp);
margin(tran);
%}

K_pp = 12.5;
K_pd = 0.7*K_pp;
K_rp = -2;

A=[0 1 0; 0 0 0; 0 0 0];
B=[0 0; 0 K_1; K_2 0];
Q=diag([1/(pi/64)^2 ; 1 ; 1/(pi/64)^2]);
%Q=diag([9 0.1 25]);

R=[1 0; 0 1];
K=lqr(A,B,Q,R)
C=[1 0 0; 0 0 1]
P = inv(C*inv(B*K-A)*B)
