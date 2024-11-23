% Script para comparar sinais e calcular o ganho entre os dados do osciloscópio e Arduino Due

close all;

% Carregar os dados do osciloscópio (CSV)
osc_data = readmatrix('ard_test.csv'); % Substituir pelo nome do seu arquivo
osc_t_raw = osc_data(:, 1); % Primeira coluna: tempo (s)
osc_signal_raw = osc_data(:, 2); % Segunda coluna: amplitude (V)

% Carregar os dados do Arduino Due (MAT)
arduino_data = load('out.mat'); % Substituir pelo nome do seu arquivo
arduino_t_raw = arduino_data.out.ScopeData.time; 
arduino_signal_raw = double(arduino_data.out.ScopeData.signals.values); 

ard_signal = zeros(1, size(arduino_signal_raw,3));

for i = 1:size(arduino_signal_raw,3)
    
    ard_signal(i) = arduino_signal_raw(:,:,i);
    
end

% Converter os valores de 12 bits para tensão (0 a 3.3V)
sinal_arduino_v = (ard_signal ./ 4095) * 3.3; % 4095 é 2^12 - 1

% Ajustar o tempo (opcional)
% Se necessário, alinhe os sinais em tempo
[tempo_osc, sinal_osc, tempo_arduino, sinal_arduino_v] = alinharSinais(osc_t_raw, osc_signal_raw, arduino_t_raw, sinal_arduino_v);

% Interpolar os sinais para comparação (mesma base de tempo)
tempo_comum = linspace(max(tempo_osc(1), tempo_arduino(1)), min(tempo_osc(end), tempo_arduino(end)), 1000);
sinal_osc_interp = interp1(tempo_osc, sinal_osc, tempo_comum);
sinal_arduino_interp = interp1(tempo_arduino, sinal_arduino_v, tempo_comum);

% Calcular o ganho (sinal Arduino / sinal Osciloscópio)
ganho_max = max(sinal_arduino_interp)/ max(sinal_osc_interp);

% Plotar os resultados
subplot(3, 1, 1);
plot(tempo_comum, sinal_osc_interp, 'b', 'LineWidth', 1.5); 
hold on;
plot(tempo_comum, sinal_arduino_interp, 'r--', 'LineWidth', 1.5);
%xlabel('Tempo (s)');
ylabel('Amplitude (V)');
%title(sprintf('Comparação dos Sinais Alinhados no Tempo com Ganho Médio de %3.f', ganho_medio), 'Interpreter', 'none');
title(['Comparação dos Sinais Alinhados no Tempo com Ganho de ', num2str(ganho_max)])
legend('Osciloscópio', 'Arduino Due');
grid on;

subplot(3, 1, 2);
plot(arduino_t_raw, sinal_arduino_v, 'm', 'LineWidth', 1.5);
%xlabel('Tempo (s)');
ylabel('Amplitude (V)');
title('Dados Crus do Arduino Due (V)');
grid on;

subplot(3, 1, 3);
plot(osc_t_raw, osc_signal_raw, 'b', 'LineWidth', 1.5);
xlabel('Tempo (s)');
ylabel('Amplitude (V)');
title('Dados Crus do Osciloscópio (V)');
grid on;

% Função auxiliar para ajustar os sinais para começar na mesma base de tempo
function [t1_al, y1_al, t2_al, y2_al] = alinharSinais(t1, y1, t2, y2)

    t_inicio = max(t1(1), t2(1));
    t_fim = min(t1(end), t2(end));
    idx1 = (t1 >= t_inicio) & (t1 <= t_fim);
    idx2 = (t2 >= t_inicio) & (t2 <= t_fim);
    t1_al = t1(idx1);
    y1_al = y1(idx1);
    t2_al = t2(idx2);
    y2_al = y2(idx2);
end
