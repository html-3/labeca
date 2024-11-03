function [sample_mag, sample_phase, sample_freq, dataStruct] = iterate_fourier()
    % Retorna o ganho, fase e frequencia da amostragem dos dados na
    % frequencia
  
    % Directory path

    rootDir = pwd; % Obtém o diretório onde o script está 
    %directory = fullfile(rootDir, '\2024.2\labeca\labeca\experimento2\frequencia\dados_frequencia_hz'); % Para Guilherme rodar
    directory = fullfile(rootDir, '\dados_frequencia_hz'); % Para Carolina rodar

    %directory = 'experimento2\frequencia\dados_frequencia_hz'; % Para Henrique rodar
    
    files = dir(directory);
    files = files(~ismember({files.name}, {'.', '..'}));
    line = 1.50;

    sample_mag = zeros(1,length(files));
    sample_phase = zeros(1,length(files));
    sample_freq = zeros(1,length(files));
    
    % Inicializa estrutura para armazenar os dados e resultados da Série de Fourier
    dataStruct = struct();
    
    n_harmonicas = 1;
    
    i = 1;
    for file = files.'
        filename = file.name;
        data = readtable(strcat(directory, "/", filename),'ReadVariableNames', false);
        data = table2array(data);
        vt = data(:,3);
        va = data(:,2);
        t = data(:,1);
        
        % Remoção do off-set do sinal
        vaSemOffSet = va - mean(va);
        %vt = vt - mean(vt);
        
        % Suavizar a curva para simular observação empírica do sinal
        va_smooth = smooth(vaSemOffSet, 100);
        
        % Marcar onde a reta cruza a senoide
        crossings = diff(va_smooth > line) ~= 0;
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

        [abs, phi, va_t, vt_t] = fourier(n_harmonicas, va, vt, t);

        sample_mag(i) = abs;
        sample_phase(i) = phi;
        sample_freq(i) = freq_estimate;
        
        % Salva os dados e resultados na estrutura
        dataStruct(i).va = va;
        dataStruct(i).vt = vt;
        dataStruct(i).t = t;
        dataStruct(i).va_t = va_t;
        dataStruct(i).vt_t = vt_t;
       
        i = i+1;
        
    end
    
    % sample_freq = 0.1000    0.2000    0.3000    0.5000    0.8000    1.4000    2.3000    3.8000    6.3000   10.6000   17.6000
    
    freqPlot = [1, 6];
    
    for i = 1:length(freqPlot)
        
        figure;
        subplot(2,1,1);
        plot(dataStruct(freqPlot(i)).t, dataStruct(freqPlot(i)).va);
        hold on;
        plot(dataStruct(freqPlot(i)).t, dataStruct(freqPlot(i)).va_t, 'LineWidth', 2);
        title(sprintf('Va - Comparação do Sinal Original e sua Série de Fourier - %.3f Hz', sample_freq(freqPlot(i))));
        xlabel('Tempo (s)');
        ylabel('Tensão (V)');
        legend('Dados originais', 'Série de Fourier do Sinal');
        grid on;

        subplot(2,1,2);
        plot(dataStruct(freqPlot(i)).t, dataStruct(freqPlot(i)).vt);
        hold on;
        plot(dataStruct(freqPlot(i)).t, dataStruct(freqPlot(i)).vt_t, 'LineWidth', 2);
        title(sprintf('Vt - Comparação do Sinal Original e sua Série de Fourier - %.3f Hz', sample_freq(freqPlot(i))));
        xlabel('Tempo (s)');
        ylabel('Tensão (V)');
        legend('Dados originais', 'Série de Fourier do Sinal');
        grid on;
        
    end
end