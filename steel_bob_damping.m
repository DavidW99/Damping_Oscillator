% Parameters
g = 9.81;
d = 0.019;
c = 0.25*d^2;      %quadratic term
b = 1.6*10^-4*d;   %linear term
l = 0.315+d/2;     % measure the length from Tracker
m = 0.029;

% Boundary Condition
t_initial  = 0.867;
theta_initial_degree = 55.95;
theta_initial = theta_initial_degree*pi/180;
theta_dot_initial = 0;
t_final = 33;
dt = 1/30;
t_span = t_initial:dt:t_final;

M = @(t,theta)[theta(2); ...
    -sin(theta(1))*g/l-sign(theta(2))*theta(2)^2*c*l/m-b*theta(2)/m];
[T,Theta] = ode45(M,t_span,[theta_initial theta_dot_initial]);

% Convert from rad to degree
Theta_degree = Theta*180/pi;

% Plot simulation
figure;
plot(T,Theta_degree(:,1),'LineWidth', 2);
s=sprintf('Damping Oscillation for Steel Bob');
title(s);
xlabel('Time [s]'); ylabel('Amplitude [degree]');
legend('Simulation')
