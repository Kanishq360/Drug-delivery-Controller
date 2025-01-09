function [fun_val] = optimfunc(xo)
    % Load step response data
    load('result_stepchange.mat'); % Ensure the data file exists in the correct directory

    M = 15;
    % Extract glucose data for the step response
    G_Plant_Data = G_step_profile(2001:2500, 1);    % Simulated glucose data
    t_data = Time_profile(2001:2500, 1);            % time data
    G_ss = G_Plant_Data(1, 1);                      % Steady state G_conc

    % Step response model
    G_model_response =  G_ss+ xo(1) * M * (1 - exp(-(t_data - 2000 - xo(3)) / xo(2)));

    %error
    err = G_Plant_Data - G_model_response;

    % Objective function
    fun_val = sum(err.^2);
end