
g = 9.81;
b = 0.25*0.06^2;
l = 0.2;
m = 0.015;

t_initial  = 0;
theta_initial_degree = 40;
theta_initial = theta_initial_degree*pi/180;
theta_dot_initial = 0;
t_final = 80;
dt = 0.03;
t_span = 0:dt:t_final;

%the sign here has a problem

M = @(t,theta)[theta(2); ...
    -sin(theta(1))*g/l-sign(theta(2))*theta(2)^2*b*l/m];
[T,Theta] = ode45(M,[t_initial t_final],[theta_initial theta_dot_initial]);

% Convert from rad to degree
Theta_degree = Theta*180/pi;

figure;
plot(T,Theta_degree(:,1),'LineWidth', 2); 
s=sprintf('Damping Oscillation for Wooden Bob', dt);
title(s);
xlabel('Time [s]'); ylabel('Amplitude [degree]');

