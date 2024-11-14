function [Ka, Kt, K_barra, Kp, tau] = open_loop_parameters()

 [Ka, ~, ~] = get_Ka('dados_lin.csv');
 [Kt, ~, ~] = get_Kt('dados_lin.csv');
 [tau] = get_tau_area('dados.csv');
 Kp = 1/(Ka*Kt);
 K_barra = 1; 