function [gjw_abs, gjw_phi, f] = iterate_fourier()
  
    % Directory path
    
    directory = 'labeca\experimento2\frequencia\dados_frequencia_hz';
    files = dir(directory);
    files = files(~ismember({files.name}, {'.', '..'}));
    line = 1.50;

    figure
    ylabel('Tensão (V)');
    xlabel('Tempo (s)');
    title('Variação do sinal na região linear')
    hold on

    gjw_abs = zeros(1,length(files));
    gjw_phi = zeros(1,length(files));

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
        
        figure
        plot(t,va,t,vt)
        ylabel('Tensão (V)');
        xlabel('Tempo (s)');
        grid on

        [abs, phi] = fourier(n_harmonicas, va, vt, t);

        gjw_abs(i) = abs;
        gjw_phi(i) = phi;
       
        
        i = i+1;
        
    end

    f = [0.1, round(bode_plotter(),1)];
    w = 2*pi*f;
    close all
 
  
end