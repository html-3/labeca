function [Ka, Kt, K_barra, Ki, tau] = closed_loop_integral_parameters()

 [Ka, ~, ~] = get_Ka('dados_lin.csv');
 [Kt, ~, ~] = get_Kt('dados_lin.csv');
 [tau] = get_tau_area('dados.csv');
 Ki = 1; % Precisamos encontrar a fórmula
 K_barra = 1; % Precisamos encontrar a fórmula