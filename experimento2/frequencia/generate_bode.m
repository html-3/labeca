function generate_bode(directory)

    % Directory path
    % "./experimento2/frequencia/dados_frequencia_hz"
    files = dir(directory);
    files = files(~ismember({files.name}, {'.', '..'}));
    line = 1.50;
    
    figure
    ylabel('Tensão (V)');
    xlabel('Tempo (s)');
    title('Variação do sinal na região linear')
    hold on
    
    
    for file = files.'
        filename = file.name;
        data = readtable(strcat(directory, "/", filename),'ReadVariableNames', false);
        data = table2array(data);
        vt = data(:,3);
        va = data(:,2);
        t = data(:,1);
        
        % Remoção do off-set do sinal
        va = va - mean(va);
        
        % Suavizar a curva para simular observação empírica do sinal
        va_smooth = smooth(va, 100);
        
        % Marcar onde a reta cruza a senoide
        crossings = find(diff(va_smooth > line) ~= 0);
        crossing_times = t(crossings);
        periods = diff(crossing_times(1:2:end));
        freq_estimate = round(1/mean(periods),1);
        
        % Começar tempo em zero
        t = t - min(t);
        
        % Selecionar apenas um período do sinal
        ids = find(t < 1/freq_estimate);
        va = va(ids);
        vt = vt(ids);
        t = t(ids);

        fft(vt);
        
        plot(t,va)
        
        hold on
        grid
    end
    
    yline(line)
end