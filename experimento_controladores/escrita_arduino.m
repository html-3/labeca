% Script para comparar sinais e calcular o ganho entre os dados do osciloscópio e Arduino Due

close all;

% Carregar os dados do osciloscópio (CSV)
osc_data = readmatrix('rect_sig_osc_received.csv'); % Substituir pelo nome do seu arquivo
osc_t_raw = osc_data(:, 1); % Primeira coluna: tempo (s)
osc_signal_raw = osc_data(:, 2); % Segunda coluna: amplitude (V)

osc_t_shift = osc_t_raw(find(osc_t_raw>=-0.3):end)-osc_t_raw(find(osc_t_raw>=-0.3, 1, 'first')); % Shifta o tempo para começar em 0s
osc_t_shift = osc_t_shift(find(osc_t_shift<=0.6));
osc_signal_shift = osc_signal_raw(find(osc_t_raw>=-0.3):end);
osc_signal_shift = osc_signal_shift(find(osc_t_shift<=0.6));

% Carregar os dados do Arduino Due (MAT)
arduino_data = load('ard_pulse_sent.mat'); 

arduino_data_raw = arduino_data.out.rect_arduino;
arduino_t_raw = arduino_data.out.tout;

arduino_t_shift = arduino_t_raw(find(arduino_t_raw>=0.1):end) - arduino_t_raw(find(arduino_t_raw>=0.1, 1, 'first'));
arduino_t_shift = arduino_t_shift(find(arduino_t_shift <= osc_t_shift(end)));

% Converter os valores de 12 bits para tensão (0 a 3.3V)
sinal_arduino_v_raw = (arduino_data_raw ./ 4095) * 3.3; % 4095 é 2^12 - 1
sinal_arduino_v = sinal_arduino_v_raw(find(arduino_t_raw>=0.1):end);
sinal_arduino_v = sinal_arduino_v(find(arduino_t_shift <= osc_t_shift(end)));
% 
% % Cálculo de Ganho
% interv1 = intersect(find(2*10^-3 < arduino_t_shift), find(arduino_t_shift <= 0.1)); % intervalo 1 em que ambos os sinais estão em high
% interv2 = intersect(find(202*10^-3 < arduino_t_shift), find(arduino_t_shift <= 0.3)); % intervalo 2 em que ambos os sinais estão em high
% interv3 = intersect(find(402*10^-3 < arduino_t_shift), find(arduino_t_shift <= 0.5)); % intervalo 3 em que ambos os sinais estão em high
% 
% mean_interv1 = mean(sinal_arduino_v(interv1))/mean(osc_signal_shift(interv1));
% mean_interv2 = mean(sinal_arduino_v(interv2))/mean(osc_signal_shift(interv2));
% mean_interv3 = mean(sinal_arduino_v(interv3))/mean(osc_signal_shift(interv3));
% 
% mean_gain = (mean_interv1 + mean_interv2 + mean_interv3)/3;

% Gráficos 
subplot(3,1,1);
plot(osc_t_shift , osc_signal_shift,'b', 'LineWidth', 1.5); 
hold on 
plot(arduino_t_shift, sinal_arduino_v, '--r', 'LineWidth', 1.5); 
legend('Osciloscópio', 'Arduino Due');
ylabel('Amplitude (V)');
%title(['Comparação dos Sinais Alinhados no Tempo com Ganho de ', num2str(mean_gain), ' V/V'])
axis([-inf inf -0.1 3.3]);
grid on;

subplot(3, 1, 2);
plot(arduino_t_raw, sinal_arduino_v_raw , 'm', 'LineWidth', 1.5);
ylabel('Amplitude (bits)');
title('Dados Crus do Arduino Due (bits)');
grid on;

subplot(3, 1, 3);
plot(osc_t_raw, osc_signal_raw, 'b', 'LineWidth', 1.5);
xlabel('Tempo (s)');
ylabel('Amplitude (V)');
title('Dados Crus do Osciloscópio (V)');
grid on;