
function [fun_val] = optimfunc(xo)
    % Load 
    load('result_stepchange.mat'); 
    M = 15; 

    G_Plant_Data = G_step_profile(1501:2000, 1);    % Simulated glucose data
    t_data = Time_profile(1501:2000, 1);            % Corresponding time data
    G_ss = G_Plant_Data(1, 1);                      % Steady state glucose concentration

    % Step response model
    G_model_response =  xo(1) * M * (1 - exp(-(t_data - 1500) / xo(2)));

    %error
    err = G_Plant_Data - G_model_response;

    % Objective function
    fun_val = sum(err.^2);
end