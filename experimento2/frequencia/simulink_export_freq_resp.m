function [t, va, vt, K, tau, freq_hz] = simulink_export_freq_resp()

    [K, tau] = frequency_response();
    [~, ~, freq_hz, va_matrix, vt_matrix, t_matrix] = iterate_fourier();
    
    t_upper = [1/freq_hz(1) 1/freq_hz(6) 1/freq_hz(9)];
    col_matrix = [1 6 9];
   
    t = zeros(size(t_matrix,1), 3);
    va = zeros(size(va_matrix,1), 3);
    vt = zeros(size(vt_matrix,1), 3);
    
    for i=1:length(t_upper)
    
        % Intervalo antes do inicio do sinal
        ids_lower = find(0 < t_matrix(:, col_matrix(i)));
        ids_upper = find(t_upper(i) > t_matrix(:, col_matrix(i)));
        ids = intersect(ids_lower, ids_upper);
    
        % Média do inicio do sinal
        va_min = mean(va_matrix(ids,col_matrix(i)));
        vt_min = mean(vt_matrix(ids,col_matrix(i)));
        
        % Deslocando os sinais para zero
        vt_matrix(:,col_matrix(i)) = vt_matrix(:,col_matrix(i)) - vt_min;
        va_matrix(:,col_matrix(i)) = va_matrix(:,col_matrix(i)) - va_min;
        
        vt(:,i) = vt_matrix(:,col_matrix(i));
        va(:,i) = va_matrix(:,col_matrix(i));
        t(:,i) = t_matrix(:,col_matrix(i));
        
    end
    
    % freq_hz = 0.1000    0.2000    0.3000    0.5000    0.8000    1.4000    2.3000    3.8000    6.3000   10.6000   17.6000

end