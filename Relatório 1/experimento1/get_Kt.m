function [Kt, x, y] = get_Kt(filename)
    % Retorna ganho da relacao tensao-tacometro

    % Carregar o arquivo CSV
    data = readtable(filename,'ReadVariableNames', false);
    data = table2array(data);
    data(:, 4) = data(:, 4)*(2*pi)/60; % Conversão de RPM para rad/s.  

    % Ordem das colunas: 1) Va_ref 2) Va_medido 3) Vt_medido 4) w_medido
    x = data(14:24, 4) - data(14,4);
    y = data(14:24, 3) - data(14,3);

    p = mmq([x y], 1);  % Ajusta a curva dos dados
    Kt = p(1);

    fprintf('Kt = %.4g V*s/rad \n',Kt);
end