function [Ka, Kt, K_barra, Kp, Ti, tau] = closed_loop_PI_parameters()

 [Ka, ~, ~] = get_Ka('dados_lin.csv');
 [Kt, ~, ~] = get_Kt('dados_lin.csv');
 [tau] = get_tau_area('dados.csv');
 Kp = 1; % Precisamos encontrar a fórmula
 Ti = 1;  % Precisamos encontrar a fórmula
 K_barra = 1; % Precisamos encontrar a fórmula