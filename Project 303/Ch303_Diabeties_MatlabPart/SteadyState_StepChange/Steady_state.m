clear;
clc;

% Global variables
global p1 p2 p3 V1 n G_basal I_basal
p1 = 0.028735;   % min^-1
p2 = 0.028344;   % min^-1
p3 = 5.035e-5;   % min^-1
V1 = 12;         % L
n = 0.0926;      % min^-1
G_basal = 81;    % mg/dL
I_basal = 15;    % mU/L

% Simulation Parameters
tspan = [0 500];                % Time span in minutes
initial_conditions = [0, 0, 0]; % Initial values for Glucose, X, and Insulin
U = 80;                         % Manipulated variable 
D = 50;                         % Disturbance variable

% Solve the system using ode45
[t, y] = ode45(@(t, y) Diab(t, y, U, D), tspan, initial_conditions);

% Extract the results
G = y(:, 1);  % Glucose concentration deviation
X = y(:, 2);  % Active insulin deviation
I = y(:, 3);  % Insulin concentration deviation

% Plotting results
figure;

% Plot 1: Glucose Concentration
subplot(2, 1, 1);
plot(t, G + G_basal, 'b-', 'LineWidth', 1.5); % Add baseline glucose
hold on;
plot(t, G_basal * ones(size(t)), 'k--', 'LineWidth', 1); % Baseline reference
xlabel('Time (min)', 'FontWeight', 'bold');
ylabel('Glucose (mg/dL)', 'FontWeight', 'bold');
title('Glucose Concentration vs. Time', 'FontWeight', 'bold');
legend({'Glucose Profile', 'Baseline Glucose'}, 'Location', 'best');
grid minor;
hold off;

% Plot 2: Insulin Concentration
subplot(2, 1, 2);
plot(t, I + I_basal, 'r-', 'LineWidth', 1.5); % Add baseline insulin
hold on;
plot(t, I_basal * ones(size(t)), 'k--', 'LineWidth', 1); % Baseline reference
xlabel('Time (min)', 'FontWeight', 'bold');
ylabel('Insulin (mU/L)', 'FontWeight', 'bold');
title('Insulin Concentration vs. Time', 'FontWeight', 'bold');
legend({'Insulin Profile', 'Baseline Insulin'}, 'Location', 'best');
grid minor;
hold off;
