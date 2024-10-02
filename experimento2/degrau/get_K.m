function [K_degrau, y_inf, A] = get_K(filename)
  % Coleta de dados
  data = readtable(filename);
  data = table2array(data);
  vt = data(:,3);
  va = data(:,2);
  t = data(:,1);

  % Intervalo antes do inicio do sinal
  ids_lower_pre = find(t>-0.1);
  ids_upper_pre = find(t<0.0);
  ids_pre = intersect(ids_lower_pre, ids_upper_pre);

  % Média do inicio do sinal
  va_min = mean(va(ids_pre));
  vt_min = mean(vt(ids_pre));
  
  % Deslocando os sinais para zero
  vt = vt- vt_min;
  va = va - va_min;

  % Intervalo do sinal considerado no infinito
  ids_lower_inf = find(t>0.3);
  ids_upper_inf = find(t<0.4);
  ids_inf = intersect(ids_lower_inf, ids_upper_inf);
  
  % Cálculo de K
  y_inf = mean(vt(ids_inf));
  A = mean(va(t_inf_ids));
  K_degrau = (y_inf)/A;
end