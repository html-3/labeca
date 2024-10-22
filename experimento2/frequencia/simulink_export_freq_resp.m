function [t_0_1, t_1_4, t_10_6, va_0_1, va_1_4, va_10_6, vt_0_1, vt_1_4, vt_10_6, K, tau] = simulink_export_freq_resp()

    [K, tau] = frequency_response();
    [~, ~, ~, va_matrix, vt_matrix, t_matrix] = iterate_fourier();
    
    t_0_1 = t_matrix(:,1);
    t_1_4 = t_matrix(:,6);
    t_10_6 = t_matrix(:,10);
    
    va_0_1 = va_matrix(:,1);
    va_1_4 = va_matrix(:,6);
    va_10_6 = va_matrix(:,10);
    
    vt_0_1 = vt_matrix(:,1);
    vt_1_4 = vt_matrix(:,6);
    vt_10_6 = vt_matrix(:,10);
    
    % freq_hz = 0.1000    0.2000    0.3000    0.5000    0.8000    1.4000    2.3000    3.8000    6.3000   10.6000   17.6000
    %clc
    %close all
end