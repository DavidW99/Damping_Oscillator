
% Parameters
g = 9.81;
b = 0.25*0.05^2;
l = 0.30;
m = 0.015;

% Boundary Condition
t_initial  = 0.867;
theta_initial_degree = 55.95;
theta_initial = theta_initial_degree*pi/180;
theta_dot_initial = 0;
t_final = 33;
dt = 1/30;
t_span = t_initial:dt:t_final;

M = @(t,theta)[theta(2); ...
    -sin(theta(1))*g/l-sign(theta(2))*theta(2)^2*b*l/m];
[T,Theta] = ode45(M,t_span,[theta_initial theta_dot_initial]);

% Convert from rad to degree
Theta_degree = Theta*180/pi;

% Read data from experiment
filename = 'damping_angle.xlsx';
experiment = xlsread(filename);
t_ex = experiment(:,1);
theta_ex = experiment(:,2);

figure;
plot(T,Theta_degree(:,1),t_ex,theta_ex,'r:','LineWidth', 2); 
s=sprintf('Damping Oscillation for Wooden Bob');
title(s);
xlabel('Time [s]'); ylabel('Amplitude [degree]');


 

