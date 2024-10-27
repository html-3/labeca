function bode_compare()
    % Importa parâmetros da Função de Transferência
    [K, tau_nep, tau_area] = step_params('dados.csv');
    close all;

    % Define Funções de Transferência para os métodos da área e neperiano
    sys_area = tf(K, [tau_area, 1]);
    sys_neperiano = tf(K, [tau_nep, 1]);

    % Calcula e plota Bode para ambos os métodos
    systems = {sys_area, sys_neperiano};
    titles = {'Método da área', 'Método Neperiano'};
    colors = {'-b', '-r'};
    
    [sample_mag, sample_phase, sample_freq] = iterate_fourier();
    close all;
    clc

    % Converte a magnitude para escala em decibéis (dB)
    sample_mag_db = 20 * log10(sample_mag);
    
    % Converte a fase para escala em graus
    sample_phase_deg = rad2deg(sample_phase);

    for i = 1:2
        [mag, phase, w] = bode(systems{i});
        freq = w / (2*pi) ;

        figure;
        subplot(2, 1, 1);
        semilogx(freq, 20 * log10(squeeze(mag)), colors{i});
        hold on
        semilogx(sample_freq, sample_mag_db, '+k', 'DisplayName', 'Dados originais');
        title(['Magnitude - ', titles{i}]);
        xlabel('Frequency (Hz)');
        ylabel('Magnitude (dB)');
        grid on;

        subplot(2, 1, 2);
        semilogx(freq, squeeze(phase), colors{i});
        hold on
        semilogx(sample_freq, squeeze(sample_phase_deg), '+k', 'DisplayName', 'Dados originais');
        title(['Fase - ', titles{i}]);
        xlabel('Frequency (Hz)');
        ylabel('Fase (graus)');
        grid on;
    end
end
