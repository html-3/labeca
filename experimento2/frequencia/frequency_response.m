function frequency_response()
    % Obtém os dados de frequência e resposta a partir de outra função
    [magnitude_abs, phase, frequency] = iterate_fourier();

    % Converte a magnitude para escala em decibéis (dB)
    magnitude_db = 20 * log10(magnitude_abs);
    
    % Converte a fase para escala em graus
    phase_deg = rad2deg(phase);

    % Ajuste de baixa frequência usando mínimos quadrados (1º grau)
    low_freq_range = frequency(1:3);
    low_freq_db = magnitude_db(1:3);
    linear_poly_low_freq = polyfit(low_freq_range, low_freq_db, 1);  % Ajuste linear

    % Cálculo do coeficiente de determinação (R^2) para ajuste linear
    linear_trend_low_freq = polyval(linear_poly_low_freq, low_freq_range);
    SS_total_low_freq = sum((low_freq_db - mean(low_freq_db)).^2);
    SS_residual_low_freq = sum((low_freq_db - linear_trend_low_freq).^2);
    R2_low_freq = 1 - SS_residual_low_freq / SS_total_low_freq;

    % Formata a equação do ajuste linear para exibir no gráfico
    linear_eq_low_freq = sprintf('%.3fx + %.3f (R^2 = %.3f)', linear_poly_low_freq(1), linear_poly_low_freq(2), R2_low_freq);

    % Gráfico Bode para magnitude em baixa frequência
    figure(1);
    subplot(2,1,1);  % Subplot superior para a magnitude em dB
    semilogx(frequency, magnitude_db, '+', 'DisplayName', 'Dados originais');
    hold on;
    semilogx(low_freq_range, linear_trend_low_freq, 'r', 'DisplayName', linear_eq_low_freq);
    grid on;
    legend;
    xlabel('Frequência (Hz)');
    ylabel('Magnitude (dB)');
    title('Diagrama de Bode - Magnitude');

    % Gráfico Bode para fase
    subplot(2,1,2);  % Subplot inferior para a fase em graus
    semilogx(frequency, phase_deg, 'o', 'DisplayName', 'Fase');
    grid on;
    legend;
    xlabel('Frequência (Hz)');
    ylabel('Fase (graus)');
    title('Diagrama de Bode - Fase');

    % Calcula K em dB (intercepto do ajuste linear)
    intercept_db = linear_poly_low_freq(2);

    % Ajuste de toda a faixa de frequência usando um polinômio de 3º grau
    cubic_poly_full_range = polyfit(frequency, magnitude_db, 3);  % Ajuste cúbico

    % Cálculo do coeficiente de determinação (R^2) para ajuste cúbico
    cubic_trend_full_range = polyval(cubic_poly_full_range, frequency);
    SS_total_full_range = sum((magnitude_db - mean(magnitude_db)).^2);
    SS_residual_full_range = sum((magnitude_db - cubic_trend_full_range).^2);
    R2_full_range = 1 - SS_residual_full_range / SS_total_full_range;

    % Formata a equação do ajuste cúbico para exibir no gráfico
    cubic_eq_full_range = sprintf('%.3fx^3 + %.3fx^2 + %.3fx + %.3f (R^2 = %.3f)', ...
        cubic_poly_full_range(1), cubic_poly_full_range(2), cubic_poly_full_range(3), ...
        cubic_poly_full_range(4), R2_full_range);
    
    % Gráfico Bode completo de magnitude
    figure(2);
    subplot(2,1,1);  % Subplot superior para a magnitude em dB
    semilogx(frequency, magnitude_db, '+', 'DisplayName', 'Dados originais');
    hold on;
    semilogx(frequency, cubic_trend_full_range, 'r', 'DisplayName', cubic_eq_full_range);
    grid on;
    legend;
    xlabel('Frequência (Hz)');
    ylabel('Magnitude (dB)');
    title('Ajuste Cúbico de Faixa Completa');

    % Gráfico Bode completo de fase
    subplot(2,1,2);  % Subplot inferior para a fase em graus
    semilogx(frequency, phase_deg, 'o', 'DisplayName', 'Fase');
    grid on;
    legend;
    xlabel('Frequência (Hz)');
    ylabel('Fase (graus)');
    title('Ajuste Cúbico de Faixa Completa');

    % Gera um conjunto de frequências para interpolação do ajuste cúbico
    interpolated_freq = logspace(log10(frequency(1)), log10(frequency(end)), 200);
    interpolated_magnitude_db = polyval(cubic_poly_full_range, interpolated_freq);

    % Gráfico da interpolação do ajuste cúbico
    figure(3);
    semilogx(frequency, magnitude_db, '+', 'DisplayName', 'Dados originais');
    hold on;
    semilogx(interpolated_freq, interpolated_magnitude_db, 'b', 'DisplayName', 'Curva Interpolada');
    legend;
    grid on;
    xlabel('Frequência (Hz)');
    ylabel('Magnitude (dB)');
    title('Interpolação da Curva Cúbica');

    % Calcula o ganho K em escala linear e estima tau
    K = 10^(intercept_db / 20);
    tau = interpolated_freq(find(interpolated_magnitude_db <= intercept_db - 3, 1));  % Revisar cálculo de tau
end
