
figure()
plot(x, y, '*')
%xlim([-10 10])
%ylim([-10 10])
xL = xlim;
yL = ylim;
line([0 0], yL);
line(xL, [0 0]);


titles  = {'pitch', 'pitch_dot', 'elevation', 'elevation_dot','travel', 'travel_dot'}
ylabels = {'pitch', 'pitch_dot', 'elevation', 'elevation_dot','travel', 'travel_dot'}
figure()
for (i = 1:6)
    subplot(3, 2, i)
    plot(x_states1.time, x_states1.signals.values(:,i))
    hold on
    plot(xhat_states1.time, xhat_states1.signals.values(:,i))
    title(titles(i))
    xlabel('Time (sec)')
    
end