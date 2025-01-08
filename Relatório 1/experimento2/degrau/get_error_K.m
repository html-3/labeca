function get_error_K()
    
    addpath('..\..\experimento1');
    
    % Obter ganhos
    [K, ~, ~] = get_K('dados.csv'); 
    % Ka e Kt obtidos no Experimento 1
    Ka = get_Ka('dados_lin.csv'); 
    Kt = get_Kt('dados_lin.csv');

    % Calcular erro
    error = abs((Ka*Kt - K)/(Ka*Kt))*100;
    
    fprintf('K     = %.5g V/V \n',K);
    fprintf('Ka*Kt = %.5g V/V \n',Ka*Kt);
    fprintf('error = %.4g %% \n',error);
end