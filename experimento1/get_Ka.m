function [Ka, x, y] = get_Ka(filename)
    % Retorna ganho da relacao tensao entrada-saida
    
    % Carregar o arquivo CSV
    data = readtable(filename,'ReadVariableNames', false);
    data = table2array(data);
    data(:, 4) = (data(:, 4)*(2*pi))/60; % Conversão de RPM para rad/s.  

    % Ordem das colunas: 1) Va_ref 2) Va_medido 3) Vt_medido 4) w_medidox
    x = data(14:24, 2) - data(14,2);
    y = data(14:24, 4) - data(14,4);

    p = mmq_origin([x y], 1);  % Ajusta a curva dos dados
    Ka = p(1);

    fprintf('Ka = %.4g rad/s/V \n',Ka);
end  