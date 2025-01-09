clear all;
clc;

% Define bounds for optimization
Up_Bound = [1000 10000]; % process gain and time constant
Lo_Bound = [0 0];        

% Initial guess
x_initial_guess = [5 100]; 

% Optimization options
options = optimset('Display', 'iter', 'TolX', 1e-10, 'TolFun', 1e-10);

% fmincon
[optimal_x, fval, exitflag] = fmincon(@optimfunc, x_initial_guess, [], [], [], [], Lo_Bound, Up_Bound, [], options);

% Save results


% Optimal values after regression
disp('Optimal values after regression:');
disp(['Process gain: ', num2str(optimal_x(1))]);
disp(['Time constant: ', num2str(optimal_x(2))]);
disp(['Objective function value: ', num2str(fval)]);

save('Model_Identification_FO.mat', 'optimal_x', 'fval', 'exitflag'); % Save the results