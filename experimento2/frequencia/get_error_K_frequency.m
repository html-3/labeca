function [] = get_error_K_frequency()
    
    addpath('C:\Users\Guilherme\Documents\UFRJ\2024.2\LABECA\labeca\experimento1'); % Para Guilherme Rodar
    
    % Obter ganhos
    [K, ~] = frequency_response();
    Ka = get_Ka('dados_lin.csv');
    Kt = get_Kt('dados_lin.csv');

    % Calcular erro
    error = abs((Ka*Kt - K)/(Ka*Kt))*100;
    
    fprintf('K     = %.5g V/V \n',K);
    fprintf('Ka*Kt = %.5g V/V \n',Ka*Kt);
    fprintf('error = %.4g %% \n',error);
end