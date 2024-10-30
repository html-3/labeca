function [sample_mag, sample_phase, sample_freq, va_matrix, vt_matrix ,t_matrix] = iterate_fourier()
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

    %figure
    %ylabel('Tensão (V)');
    %xlabel('Tempo (s)');
    %title('Variação do sinal na região linear')
    %hold on

    sample_mag = zeros(1,length(files));
    sample_phase = zeros(1,length(files));
    sample_freq = zeros(1,length(files));

    data_lenght = 10000;
    va_matrix = zeros(data_lenght,length(files));
    vt_matrix = zeros(data_lenght,length(files));
    t_matrix = zeros(data_lenght,length(files));

    n_harmonicas = 1;
    
    i = 1;
    for file = files.'
        filename = file.name;
        data = readtable(strcat(directory, "/", filename),'ReadVariableNames', false);
        data = table2array(data);
        vt = data(:,3);
        va = data(:,2);
        t = data(:,1);

        va_matrix(:,i) = va;
        vt_matrix(:,i) = vt;
        t_matrix(:,i) = t;

       
        % Remoção do off-set do sinal
        va = va - mean(va);
        
        % Suavizar a curva para simular observação empírica do sinal
        va_smooth = smooth(va, 100);
        
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
        
        %plot(t,va,t,vt)
        %ylabel('Tensão (V)');
        %xlabel('Tempo (s)');
        %grid on

        [abs, phi] = fourier(n_harmonicas, va, vt, t);

        sample_mag(i) = abs;
        sample_phase(i) = phi;
        sample_freq(i) = freq_estimate;
       
        i = i+1;
        
    end
    
    close all 
end