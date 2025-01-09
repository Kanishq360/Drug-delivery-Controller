% Validation of First Order
clear all;
clc;

% Values from model
optimal_x(1) = 11;   % Process gain
optimal_x(2) = 56.44815;   % Time constant

% Display
xo(1) = optimal_x(1);
disp(['Process gain: ', num2str(xo(1))]);
xo(2) = optimal_x(2);
disp(['Time constant: ', num2str(xo(2))]);


% Load
load('result_stepchange.mat'); 


% Validation with the trained dataset 1
G_in1           = U(4001:4500); 
G_Plant_Data1   = G_step_profile(4001:4500); 
t_data1         = Time_profile(4001:4500); 
G_ss1              = G_Plant_Data1(1); 

% Step response model in time domain for dataset 1
G_model_response1 = zeros(length(t_data1), 1);
for i = 1:length(t_data1)
    G_model_response1(i) = G_ss1 + xo(1) * 25 * (1 - exp(-(t_data1(i) - 4000) / xo(2)));
end

% Plotting results for dataset 1
figure(1);
plot(t_data1, G_Plant_Data1, 'b', 'DisplayName', 'Plant Data');
hold on;
plot(t_data1, G_model_response1, 'r--', 'DisplayName', 'Model Response');
legend('Location', 'best');
title('Validation with Dataset 1');
xlabel('Time');
ylabel('Glucose Concentration (mg/dL)');
grid on;

