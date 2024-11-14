function [Ka, Kt, K_barra, Ki, tau] = closed_loop_integral_parameters()

 [Ka, ~, ~] = get_Ka('dados_lin.csv');
 [Kt, ~, ~] = get_Kt('dados_lin.csv');
 [tau] = get_tau_area('dados.csv');
 K_barra = 1; 

 % Encontrar Ki 
 % Ki(1) = superamortecido, K(2) = criticamente amortecido, K(3) =
 % subamortecido e K(4) = subamortecido(5% de overshoot)
 zeta = [2, 1, 0.8, 0.69];
 Ki = zeros(4,1);

 for i = 1:4
    Ki(i) = tau/(((2*tau*zeta(i))^2)*Ka*Kt); 
 end