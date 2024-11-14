function [Ka, Kt, K_barra, Kp, Ti, tau] = closed_loop_PI_parameters()

 [Ka, ~, ~] = get_Ka('dados_lin.csv');
 [Kt, ~, ~] = get_Kt('dados_lin.csv');
 [tau] = get_tau_area('dados.csv');
 K_barra = 1; 
 Kp = 1; % Rever contas
 Ti = 2/(1+(Kp*Ka*Kt));  % Rever contas