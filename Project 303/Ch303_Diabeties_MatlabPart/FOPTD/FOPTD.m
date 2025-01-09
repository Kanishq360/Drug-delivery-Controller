clear all;
clc;

% Bounds for optimization
Up_Bound = [1000 10000 100]; % process gain, time constant, and time delay
Lo_Bound = [-1000 0 0];    

% Initial guess for optimization
x_initial_guess = [10 50 5]; % Initial guess for process gain, time constant, and time delay

% Optimization
options = optimset('Display', 'iter', 'TolX', 1e-10, 'TolFun', 1e-10);

% Optimization using fmincon
[optimal_x, fval, exitflag] = fmincon(@optimfunc, x_initial_guess, [], [], [], [], Lo_Bound, Up_Bound, [], options);

% Optimal values after regression
disp('Optimal values after regression:');
disp(['Process gain: ', num2str(optimal_x(1))]);
disp(['Time constant: ', num2str(optimal_x(2))]);
disp(['Time delay: ', num2str(optimal_x(3))]);
disp(['Objective function value: ', num2str(fval)]);

% Save
save('Model_Identification_time_delay.mat');