function plotter_perturbacao()
     % Carregar o arquivo CSV
    data = readtable('perturbacao.CSV','ReadVariableNames', false);
    data = table2array(data);
    
    Ko = 5;
    
    % Ordem das colunas: 1) tempo 2) Va 3) Vt
    tempo = data(:,1) - data(1,1);
    va = Ko * data(:,2);
    vt = data(:,3);
    
    t_start = 1; 
    t_end = 4;  
    
    indices = (tempo >= t_start) & (tempo <= t_end);
    tempo = tempo(indices);
    vt = vt(indices);
    va = va(indices);
    
    tempo = tempo - tempo(1);
    
    % Plot the data
    figure;
    hold on;
    grid on;
    
    % Plot control signal
    plot(tempo, smooth(va,10), 'r-', 'LineWidth', 1.5, 'DisplayName', 'Sinal de controle');
    
    % Plot setpoint data
    yline(13.688,'k--', 'LineWidth', 1.5, 'DisplayName', 'Sinal de referência')
    
    % Plot tachometer data
    plot(tempo, smooth(vt+0.908,10), 'b-', 'LineWidth', 1.5, 'DisplayName', 'Sinal do tacômetro');
    
    % Add labels, legend, and title
    xlabel('Tempo (s)');
    ylabel('Tensão (V)');
    title('Sinais com perturbção no eixo');
    legend('show');
end

