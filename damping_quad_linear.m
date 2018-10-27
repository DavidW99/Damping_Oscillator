% Parameters
g = 9.81;
d = 0.03805;
c = 0.25*d^2;      %quadratic term
b = 1.6*10^-4*d;   %linear term
l = 0.315+d/2;     % measure the length from Tracker
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
    -sin(theta(1))*g/l-sign(theta(2))*theta(2)^2*c*l/m-b*theta(2)/m];
[T,Theta] = ode45(M,t_span,[theta_initial theta_dot_initial]);

% Convert from rad to degree
Theta_degree = Theta*180/pi;

% Read data from experiment
filename = 'damping_angle.xlsx';
experiment = xlsread(filename);
t_ex = experiment(:,1);
theta_ex = experiment(:,2);

%Plot simulation and experiment
figure;
plot(T,Theta_degree(:,1),t_ex,theta_ex,'r:','LineWidth', 2);
s=sprintf('Damping Oscillation for Wooden Bob');
title(s);
xlabel('Time [s]'); ylabel('Amplitude [degree]');
legend('Simulation','Experiment');


% See if the period is decaying
[~,peaklocs_1] = findpeaks(Theta_degree(:,1));
period_simu = diff(peaklocs_1)*dt;
[~,peaklocs_2] = findpeaks(theta_ex);
period_ex = diff(peaklocs_2)*dt;

% The 16th's data point from Tracker is clearly an error
period_ex(16) = period_ex(15);

t_simu = linspace(1,length(period_simu),length(period_simu));
t_exp = linspace(1,length(period_ex),length(period_ex));

% Plot the change in period
% May attempt to try simulate 300s and see the damping in period
figure; 
plot(t_simu,period_simu,t_exp,period_ex,'r:','LineWidth', 2);
xlabel('Number of Oscillations'); ylabel('Period [s]');
legend('Simulation','Experiment');
axis([0 29 1 1.5]);



