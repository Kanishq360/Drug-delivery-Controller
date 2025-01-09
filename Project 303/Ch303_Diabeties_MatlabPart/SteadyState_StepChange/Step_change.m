clear;
clc;

global p1 p2 p3 V1 n G_basal I_basal
p1 = 0.028735;   % min^-1
p2 = 0.028344;   % min^-1
p3 = 5.035e-5;   % min^-1
V1 = 12;         % L
n = 0.0926;      % min^-1
G_basal = 81;    % mg/dL
I_basal = 15;    % mU/L

% Time span
time_span = [0 1];

D = 50*ones(5000, 1);  
% Predefined Manipulated (U) 
U = [repmat(45, 500, 1); repmat(38, 500, 1); repmat(30, 500, 1); 
     repmat(45, 500, 1); repmat(70, 500, 1); repmat(62, 500, 1); 
     repmat(44, 500, 1); repmat(67, 500, 1); repmat(42, 500, 1); 
     repmat(39, 500, 1)];  


% Preallocate profiles
G_profile = zeros(5000, 1);
Time_profile = (1:5000)';

% Generate variable random noise
rng('shuffle');
wk = (1 + 0.5 * randn(5000, 1)) .* randn(5000, 1);      

% Initial conditions
initial_conditions = [0; 0; 0];  

% Dynamic simulation with step response and noise
for i = 1:5000
    [t, y] = ode45(@(t, y) Diab(t, y, U(i), D(i)), time_span, initial_conditions);
    
    G_profile(i) = y(end, 1);
    initial_conditions = y(end, :);  
end

G_step_profile = G_profile ;

% Plot the results
figure;
subplot(2, 1, 1);
plot(Time_profile, G_step_profile, 'b', 'LineWidth', 1.5);
xlabel('Time');
ylabel('Glucose Concentration (mg/dL)');
title('Glucose Concentration Profile with Noise');
grid minor;

subplot(2, 1, 2);
plot(Time_profile, U, 'r', 'LineWidth', 1.5);
xlabel('Time');
ylabel('Manipulated Variable (U)');
title('Manipulated Variable (U) During Step Response');
grid minor; 

% Save the results
save('result_stepchange.mat', 'G_step_profile', 'U', 'Time_profile');

