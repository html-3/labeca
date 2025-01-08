function [Ka, Kt, K_barra, Kp, tau] = open_loop_parameters()

% Arquivo que calcula o ganho de malha aberta, e então exporta para o simulink.

 [Ka, ~, ~] = get_Ka('dados_lin.csv');
 [Kt, ~, ~] = get_Kt('dados_lin.csv');
 [tau] = get_tau_area('dados.csv');
 Kp = 1/(Ka*Kt);
 K_barra = 1; 