function [w] = bode_ploter()
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

    for i = 1:2
        [mag, phase, w] = bode(systems{i});
        freq = w / (2 * pi);

        figure;
        subplot(2, 1, 1);
        semilogx(freq, 20 * log10(squeeze(mag)), colors{i});
        title(['Magnitude - ', titles{i}]);
        xlabel('Frequency (Hz)');
        ylabel('Magnitude (dB)');
        grid on;

        subplot(2, 1, 2);
        semilogx(freq, squeeze(phase), colors{i});
        title(['Fase - ', titles{i}]);
        xlabel('Frequency (Hz)');
        ylabel('Fase (graus)');
        grid on;
    end

    % Calcula tau para ambos os métodos e ajusta limites de frequência
    w_0 = 20 * log10(K);
    tau_gain = w_0 - 3;

    tau_area = 1 / (2 * pi * freq(find(20 * log10(squeeze(mag)) <= tau_gain, 1)));
    tau_nep = 1 / (2 * pi * freq(find(20 * log10(squeeze(mag)) <= tau_gain, 1)));

    freq_canto_hz = freq(find(20 * log10(squeeze(mag)) <= tau_gain, 1));
    lower_lim_freq_hz = 0.1 * freq_canto_hz;
    upper_lim_freq_hz = 10 * freq_canto_hz;

    w = logspace(log10(lower_lim_freq_hz), log10(upper_lim_freq_hz), 10);
    % Obtenha dados das frequências geradas em logspace + 0.1 Hz
end
