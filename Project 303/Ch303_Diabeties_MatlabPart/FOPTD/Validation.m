clear all;
clc;

% Define optimal values for process gain, time constant, and time delay
optimal_x(1) = 30;      % Process gain
optimal_x(2) = 355.7685;     % Time constant
optimal_x(3) = 100;     % Time delay

% Display
xo(1) = optimal_x(1);
disp(['Process gain: ', num2str(xo(1))]);
xo(2) = optimal_x(2);
disp(['Time constant: ', num2str(xo(2))]);
xo(3) = optimal_x(3);
disp(['Time delay: ', num2str(xo(3))]);

% Loading the data
load('result_stepchange.mat'); 

% Validation of the process model (with the trained dataset 1)
G_in1 = U(4001:4500);                       % Manipulated input for dataset 1
G_Data1 = G_step_profile(4001:4500);        % Simulated glucose data
t_data1 = Time_profile(4001:4500);          % Time data for dataset 1
G_ss1 = G_Data1(1);                          % Initial steady-state glucose concentration

% Initialize the model response array
G_model_response1 = zeros(length(t_data1), 1);

% Compute the model response using FOPTD for each time step
for i = 1:length(t_data1)
    if (t_data1(i) >= xo(3))  % Check if the time is greater than or equal to the time delay
        % Apply the FOPTD model
        G_model_response1(i) = G_ss1 + xo(1) * (G_in1(i) - G_in1(1)) * (1 - exp(-(t_data1(i) - xo(3)) / xo(2)));
    else
        % Before the time delay, the response is the steady-state value
        G_model_response1(i) = G_ss1; 
    end
end

% Plotting results for dataset 1
figure;
plot(t_data1, G_Data1, 'b', 'LineWidth', 1.5, 'DisplayName', 'Plant Data');
hold on;
plot(t_data1, G_model_response1, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Model Response');
legend('Location', 'best');
title('Validation with Dataset 1 (FOPTD Model)');
xlabel('Time (min)');
ylabel('Glucose Concentration (mg/dL)');
grid on;
