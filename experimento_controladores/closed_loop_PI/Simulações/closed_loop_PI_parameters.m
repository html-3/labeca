function [Ka, Kt, K_barra, Kp, Ti, tau] = closed_loop_PI_parameters()

 [Ka, ~, ~] = get_Ka('dados_lin.csv');
 [Kt, ~, ~] = get_Kt('dados_lin.csv');
 [tau] = get_tau_area('dados.csv');
 K_barra = 1;
 Ti = 1/(tau+12)*1.4; 
 Kp = 1/(Ka*Kt*1.2); 
  