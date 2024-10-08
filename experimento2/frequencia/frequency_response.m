function frequency_response()
    
    gjw_abs = fourier(t,ut,yt);

    % Vetores w e gjwdb
    w = zeros(1,lenght(t));
    gjwdb = 20*log10(gjw_abs);

    semilogx(w, gjwdb, '+'); 
    grid on;



