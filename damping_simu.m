% Simulation of Damping of Pendulum

g = 9.81;
b = 0.025;
l = 0.2;
m = 0.015;

t_initial  = 0;
theta_initial_degree = 10;
theta_initial  = theta_initial_degree*pi/180;
t_final = 10000;
dt = 0.01;
t_span = 0:dt:t_final;

syms theta(t)
[V] = odeToVectorField(...
    diff(theta, 2) == sin(theta)*g/l-diff(theta)^2*b*l/m);
M = @(t,theta)[theta(2); sin(theta(1))*g/l-theta(2)^2*b*l/m];
[T,Theta] = ode45(M,[t_initial t_final],[t_initial, theta_initial]);

Theta = Theta*180/pi;

figure;
plot(T,Theta,'LineWidth', 2); 
s=sprintf('Damping Oscillation with dt = %4.3f', dt);
title(s);
xlabel('time'); ylabel('amplitude');


%sol = ode45(M,[t_initial t_final],[t_initial, theta_initial]);
%fplot(@(x)deval(sol,x,1),[t_initial t_final])

% % Initial data
% 
% [T1,Y1] = ode45(@damped_pendulum, t_span, [t_initial theta_initial]);
% 
% 
% function [dt1,dt2] = damped_pendulum(theta1,theta2)
% % Initialization:

% 
% dt1 = sqrt(m*g*sin(theta)/(b*l^2)-m*dt2/(b*l));
% dt2 = sin(theta)*g/l-dt1^2*b*l/m;
% end