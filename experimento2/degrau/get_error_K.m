function [] = get_error_K(filename)

    % Obter dados
    [K, ~, ~] = get_K(filename);
    Ka = get_Ka(filename);
    Kt = get_Kt(filename);

    error = abs((Ka*Kt - K)/(Ka*Kt))*100;
end