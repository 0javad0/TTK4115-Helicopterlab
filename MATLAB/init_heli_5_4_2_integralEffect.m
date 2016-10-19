% This file contains the initialization for the helicopter assignment in
% the course TTK4115. Run this file before you execute QuaRC_ -> Build 
% to build the file heli_q8.mdl.

% Oppdatert høsten 2006 av Jostein Bakkeheim
% Oppdatert høsten 2008 av Arnfinn Aas Eielsen
% Oppdatert høsten 2009 av Jonathan Ronen
% Updated fall 2010, Dominik Breu
% Updated fall 2013, Mark Haring
% Updated spring 2015, Mark Haring
clear all

%%%%%%%%%%% Calibration of the encoder and the hardware for the specific
%%%%%%%%%%% helicopter
Joystick_gain_x = -1; % Var 1 /// 0.5
Joystick_gain_y = -0.5; % Var -1 /// -1


%%%%%%%%%%% Physical constants
g = 9.81; % gravitational constant [m/s^2]
l_c = 0.46; % distance elevation axis to counterweight [m]
l_h = 0.66; % distance elevation axis to helicopter head [m]
l_p = 0.175; % distance pitch axis to motor [m]
m_c = 1.92; % Counterweight mass [kg]
m_p = 0.72; % Motor mass [kg]


%%%%%%%%%%% User defined constants
V_s_s = 7.5; % Vs* voltage Vs when e~, p~, lambda~, and their derivatives are 0
J_p = 2*m_p*l_p^2;
J_e = m_c*l_c^2+2*m_p*l_h^2;
J_lambda = m_c*l_c^2+2*m_p*(l_h^2+l_p^2);

L_2 = m_c*g*l_c-2*m_p*g*l_h;
K_f = -L_2/(l_h*V_s_s);
L_1 = l_p*K_f; % Pitch is defined as positive in the counter clockwise direction
L_3 = l_h*K_f;
L_4 = K_f*l_h;

K_1 = L_1/J_p;
K_2 = L_3/J_e;
K_3 = L_4/J_lambda*(L_2/L_3);


K_pp = 12.5;
K_pd = 0.7*K_pp;
K_rp = -2;

% %Problem 5.3.3
A = [0 1 0 0 0; 0 0 0 0 0 ; 0 0 0 0 0 ; 1 0 0 0 0; 0 0 1 0 0];
B=[0 0; 0 K_1; K_2 0; 0 0; 0 0];
Q=diag([15 0.1 25 1 1]);
R=[1 0; 0 1];
K=lqr(A,B,Q,R);
C=[1 0 0 0 0; 0 0 1 0 0];
P = [0 K(1,3); K(2,1) 0];

% Problem 5.4.2
% A_e = [ 0 1 0 0 0 0 0 0; 0 0 0 0 0 0 0 0; 0 0 0 1 0 0 0 0; 0 0 0 0 0 0 0 0; 0 0 0 0 0 1 0 0; K_3 0 0 0 0 0 0 0; 1 0 0 0 0 0 0 0; 0 0 0 1 0 0 0 0];
% B_e = [0 0; 0  K_1; 0 0; K_2 0; 0 0;  0 0; 0 0; 0 0];
A_e = [0 1 0 0 0 0; 0 0 0 0 0 0; 0 0 0 1 0 0; 0 0 0 0 0 0; 0 0 0 0 0 1; K_3 0 0 0 0 0];
B_e = [0 0; 0  K_1; 0 0; K_2 0; 0 0;  0 0];
C_e = [ 1 0 0 0 0 0 0 0; 0 0 1 0 0 0 0 0; 0 0 0 0 1 0 0 0];
ctrl_poles = eig(A-B*K);

%Largest radius of the controller poles:
max_rad_ctrl = norm(max(ctrl_poles));
observer_poles = [];

angleStep = 5;
r = -max_rad_ctrl*60;
observer_poles = zeros(1, 6);
x = zeros(1, 6);
y = zeros(1, 6);
for i = 1:3
    height = r*sin(pi*angleStep*i/180);
    width = sqrt(r^2 - height^2);
    observer_poles(i) = complex(-width, height);
    observer_poles(i+3) = complex(-width, -height);
    x(i) = -width;
    x(i+3) = -width;
    y(i) = height;
    y(i+3) = -height;
    %poles(i) = -max_rad_ctrl*10 - i;
end

plot(x, y, '*')
xlim([-10 10])
ylim([-10 10])
xL = xlim;
yL = ylim;
line([0 0], yL);
line(xL, [0 0]);
L = place(A_e', C_e', observer_poles)';




