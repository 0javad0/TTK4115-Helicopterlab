% Problem 5.4.2
A_e = [ 0 1 0 0 0 0; 0 0 0 0 0 0; 0 0 0 1 0 0; 0 0 0 0 0 0; 0 0 0 0 0 1; K_3 0 0 0 0 0];
B_e = [0 0; 0  K_1; 0 0; K_2 0; 0 0;  0 0];
C_e = [0 0 1 0 0 0; 0 0 0 0 1 0];
ctrl_poles = eig(A-B*K);
norm(ctrl_poles)

%Largest radius of the controller poles:
max_rad_ctrl = norm(max(ctrl_poles));

Lmax = 100000000;
rBest = 0;
thBest = 0;
for rGain = 1:.1:10
    for angleStep = 1:.1:10
%         angleStep = 7.5;
%         rGain = 2.7;
        r = -max_rad_ctrl*rGain;
        r = -1*rGain;
        observer_poles = zeros(1, 6);
        for i = 1:3
            height = r*sin(pi*angleStep*i/180-angleStep*pi/180*rGain/8);
            width = sqrt(r^2 - height^2);
            observer_poles(i) = complex(-width, height);
            observer_poles(i+3) = complex(-width, -height);
        end
        L = place(A_e', C_e', observer_poles)';
%         Lmax = max(L(:))
        if (Lmax>= max(L(:)))
            Lmax = max(L(:));
            rBest = rGain;
            thBest = angleStep;
        end
    end
end


% observer_poles = zeros(1, 6);
% for i = 1:3
%     height = 0;%.54*i-0.20;
%     width = 3%.1*i + 2
%     observer_poles(i) = complex(-width, height);
%     observer_poles(i+3) = complex(-width, -height);
% end

% observer_poles(1) = complex(-2.25, 0);
% observer_poles(2) = complex(-2, 0);
% observer_poles(3) = complex(-2, 1);
% observer_poles(4) = complex(-2, -1);
% observer_poles(5) = complex(-2.25, 0.75);
% observer_poles(6) = complex(-2.25, -0.75);

