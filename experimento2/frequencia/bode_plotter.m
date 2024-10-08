function bode_plotter()

    clc

    % Importação de parâmetros da Função de Transferência
    [~, ~, ~, K, tau_area, tau_neperiano] = labeca_02_simulink_export();

    close all

    % Função de Transferência pelo método da área
    sys_area = tf([K],[tau_area 1]);

    % Função de Transferência pelo método neperiano
    sys_neperiano = tf([K],[tau_neperiano 1]);

    % Plot de módulo e fase de Boda da F.T. do método da área
    [mag_area, phase_area, w_area] = bode(sys_area);
    bode(sys_area)
    grid

    freq_area = w_area / (2*pi);

    figure;
    subplot(2,1,1);
    semilogx(freq_area, 20*log10(squeeze(mag_area)), '-b'); 
    title('Magnitude - Método da área');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    grid on;

    subplot(2,1,2);
    semilogx(freq_area, (squeeze(phase_area)), '-b'); 
    title('Fase - Método da área');
    xlabel('Frequency (Hz)');
    ylabel('Fase (graus)');
    grid on;

    % Plot de módulo e fase de Boda da F.T. do método neperiano
    [mag_nep, phase_nep, w_nep] = bode(sys_neperiano);
    freq_nep = w_nep / (2*pi);

    figure;
    subplot(2,1,1);
    semilogx(freq_nep, 20*log10(squeeze(mag_nep)), '-r'); 
    title('Magnitude - Método Neperiano');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    grid on;

    subplot(2,1,2);
    semilogx(freq_nep, (squeeze(phase_nep)), '-r'); 
    title('Fase - Método Neperiano');
    xlabel('Frequency (Hz)');
    ylabel('Fase (graus)');
    grid on;


    w_0 = 20*log10(K);
    
    tau_gain = w_0-3
    tau_num_area = 1/freq_area(find(20*log10(squeeze(mag_area))<=tau_gain, 1, 'first'))
    tau_num_nep = 1/freq_nep(find(20*log10(squeeze(mag_nep))<=tau_gain, 1, 'first'))