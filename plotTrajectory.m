function plotTrajectory(t, p1,v1,a1, p2,v2,a2, T, v_max,a_max)

subplot(3,2,1)
plot(t, p1)
title('position-time (config. space)')
legend({'q1','q2','q3'})
ylabel('rad')
xlim([0 T])

subplot(3,2,2)
plot(t, p2)
title('position-time (task space)')
legend({'px','py','pz'})
ylabel('m')
xlim([0 T])

subplot(3,2,3)
plot(t, v1)
title('velocity-time (config. space)')
legend({'q1','q2','q3'})
ylabel('rad/s')
xlim([0 T]); ylim([-v_max v_max])

subplot(3,2,4)
plot(t, v2)
title('velocity-time (task space)')
legend({'vx','vy','vz'})
ylabel('m/s')
xlim([0 T])

subplot(3,2,5)
plot(t, a1)
title('acceleration-time (config. space)')
legend({'q1','q2','q3'})
ylabel('rad/s^2')
xlabel('time [s]')
xlim([0 T]); ylim([-a_max a_max])

subplot(3,2,6)
plot(t, a2)
title('acceleration-time (task space)')
legend({'ax','ay','az'})
ylabel('m/s^2')
xlabel('time [s]')
xlim([0 T])

end

