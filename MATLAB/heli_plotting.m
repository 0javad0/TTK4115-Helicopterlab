
% figure()
% plot(real(observer_poles), imag(observer_poles), '*')
% xlim([real(min(observer_poles)) 1])
% ylim([min(imag(observer_poles))-1 max(imag(observer_poles))+1])
% xL = xlim;
% yL = ylim;
% line([0 0], yL);
% line(xL, [0 0]);
% hold on
% plot(real(ctrl_poles), imag(ctrl_poles), 'x')
close all
%Temp
x_states.time = [1 2 3 4 5 6]
x_states.signals.values = ones(6, 6);
xhat_states.time = [1 2 3 4 5 6]
xhat_states.signals.values = ones(6, 6) *2;
%Temp

dateAndTime = strrep(datestr(datetime('now')), ':', '-')
figName = strcat('Estimator\_rGain-', num2str(rGain), '\_angleStep-', num2str(angleStep), '\_', dateAndTime)

titles  = {'pitch', 'pitch rate', 'elevation', 'elevation rate','travel', 'travel rate'}
ylabels = {'pitch (deg)', 'pitch_dot (deg/sec)', 'elevation (deg)', 'elevation_dot (deg/sec)','travel (deg)', 'travel_dot (deg/sec)'}
h = figure()
suptitle(figName)
for (i = 1:6)
    subplot(3, 2, i)
    plot(x_states.time, x_states.signals.values(:,i)*(180/pi), 'b')
    hold on
    plot(xhat_states.time, xhat_states.signals.values(:,i)*(180/pi), 'r')
    title(titles(i))
    ylabel(ylabels(i))
    if(i == 5 || i == 6)
        xlabel('Time (sec)')
    end
    legend('measured','estimated')
end

savefig(h, strcat([pwd '/figures/' figName], '.fig'))