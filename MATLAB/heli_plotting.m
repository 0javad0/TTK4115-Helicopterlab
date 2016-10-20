
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


titles  = {'pitch', 'pitch_dot', 'elevation', 'elevation_dot','travel', 'travel_dot'}
ylabels = {'pitch', 'pitch_dot', 'elevation', 'elevation_dot','travel', 'travel_dot'}
figure()
for (i = 1:6)
    subplot(3, 2, i)
    plot(x_states.time, x_states.signals.values(:,i)*(180/pi), 'b')
    hold on
    plot(xhat_states.time, xhat_states.signals.values(:,i)*(180/pi), 'r')
    title(titles(i))
    xlabel('Time (sec)')
    legend('measured','estimated')
end
