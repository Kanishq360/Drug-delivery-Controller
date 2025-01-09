% Function to define the systems
function dydt = Diab(t, y, U, D)
    global p1 p2 p3 V1 n G_basal I_basal 
    
    G = y(1);   % Glucose concentration
    X = y(2);   % Intermediate term
    I = y(3);   % Insulin concentration
    
    % ODE equations
    dGdt = -p1 * G - X * (G + G_basal) + D;  
    dXdt = -p2 * X + p3 * I;
    dIdt = -n * (I + I_basal) + U / V1;      
    
    dydt = [dGdt; dXdt; dIdt];
end