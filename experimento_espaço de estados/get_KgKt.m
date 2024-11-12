function [KgKt,x,y] = get_KgKt(filename)
    % Retorna ganho da relacao tensao entrada-saida
    
    % Carregar o arquivo CSV
    data = readtable(filename,'ReadVariableNames', false);
    data = table2array(data);
    
    % Valores dentro da oscilação
    index_lower = find(data(:,3)> -2);
    index_upper = find(data(:,3)< 2);
    index = intersect(index_lower, index_upper);
    
    % Ordem das colunas: 1) tempo 2) Va_sample 3) Vt_sample
    x = data(index,3) - mean(data(index,3));
    y = data(index,2) - mean(data(index,2));

    p = mmq([x y], 1);  % Ajusta a curva dos dados
    KgKt = p(1);
  
    fprintf('Kg/Kt = %.4g V/V \n',KgKt);
end