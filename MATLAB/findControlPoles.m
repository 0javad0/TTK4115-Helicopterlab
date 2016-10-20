%Find QRL values


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


min = 1000000;
for i=100:200
    for j=100:200
%         for k=.01:.1:1.01
            Q=diag([2 3 6 1 1]);
            R=[i 0; 0 j];
            K=lqr(A,B,Q,R);
            ctrl_poles = eig(A-B*K);
            
            if(norm(ctrl_poles) < min)
                min = norm(ctrl_poles);
                minI = i;
                minJ = j;
%                 minK = k;
            end
%         end
    end
end

C=[1 0 0 0 0; 0 0 1 0 0];
P = [0 K(1,3); K(2,1) 0];

% Problem 5.4.2
A_e = [ 0 1 0 0 0 0; 0 0 0 0 0 0; 0 0 0 1 0 0; 0 0 0 0 0 0; 0 0 0 0 0 1; K_3 0 0 0 0 0];
B_e = [0 0; 0  K_1; 0 0; K_2 0; 0 0;  0 0];
C_e = [0 0 1 0 0 0; 0 0 0 0 1 0];
ctrl_poles = eig(A-B*K);