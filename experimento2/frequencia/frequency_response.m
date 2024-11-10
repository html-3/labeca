function [K, tau] = frequency_response()
    
    [gjw_abs,~, w,~] = iterate_fourier(); % esse w está em hz, e não em rad/s
    close all

    % Vetores gjwdb
    gjwdb = 20*log10(gjw_abs);
    
    % Desconsiderando o último ponto por parecer um outlier
    gjwdb = gjwdb(1:end-1);
    w = w(1:end-1);
    
    % Ajuste por mínimos quadrados ponderados para o bode inteiro
    p=[1 1 1 1 1 1 0.5 0.1 0.1 0.1]; % vetor de pesos para considerar mais os ganhos de baixa frequência
  
    polinomio = mmq_weighted([w',gjwdb'],6,p);
    
    eq_3grau = sprintf('%.3fx^6+%.3fx^5+%.3fx^4+%.3fx^3+%.3fx^2+%.3fx+%.3f',polinomio(1),polinomio(2),polinomio(3),polinomio(4),polinomio(5),polinomio(6),polinomio(7)); 
    
    ww = logspace(log10(w(1)),log10(w(end)),200);
    gww = polyval(polinomio,ww);
    
    % Cálculo de Kdb
    % Seleção de um intervalo de baixas frequências para calcular o Kdb posteriormente
    ww_Kdb = intersect(ww(find(ww>=0.1)), ww(find(ww<0.2)));
    gww_Kdb = intersect(gww(find(ww>=0.1)), gww(find(ww<0.2)));
    
    Kdb_mmq = mmq_weighted([ww_Kdb', gww_Kdb'], 1);
    eq_Kdb = sprintf('%.3fx+%.3f (ajuste de Kdb)',Kdb_mmq(1),Kdb_mmq(2)); % 1ª ordem -> Kdb = 2.5502
    
    Kdb = Kdb_mmq(2);
    
    figure(2)
    semilogx(w, gjwdb, '+'); 
    hold on;
    semilogx(ww, gww, 'b');
    hold on;
    semilogx(ww_Kdb, gww_Kdb, 'r');
    title('Bode - Magnitude');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    legend('Dados originais', eq_3grau, eq_Kdb);
    grid on;
    
    %Cálculo de K e Tau
    K = 10^(Kdb/20);
    
    tau_gain = Kdb-3;     
    tau = 1/(2*pi*(ww(find(squeeze(gww)<=tau_gain, 1, 'first'))));
    
    num = K;
    den = [tau 1];
    sys = tf(num, den);
    
    [mag, ~, omega] = bode(sys);
    freq = omega / (2 * pi); % Hz
    mag_db = 20 * log10(squeeze(mag));
    
    % Gráfico para fazer a validação do modelo
    figure(3);
    semilogx(w, gjwdb, '+'); 
    hold on;
    semilogx(freq, mag_db, 'b');
    title('Bode - Magnitude');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    legend('Dados originais', 'Função de Transferência');
    grid on;

end
