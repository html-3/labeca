function root_locus
    % Root Locus Script
    clc;
    clear;
    close all;
    
    Kd1 = 0.0005399;
    Kd2 = 1232;
    Ko = 5;
    Ki = 4.295 / (22.94 + 4.295);
    Ka = 9.106;
    Kt = 0.153;
    tau = 0.08956;
    
    [Kp, Ti] = control_params;

    motor = tf([Ka * Kt], [tau, 1]);
    control = Kp * tf([1, 1/Ti], [1, 0]);
    system = Kd1 * Kd2 * Ko * Ki *motor * control;
 
    % Plot the root locus
    figure;
    rlocus(system);  % Root locus plot
    grid on;

    % Add title and labels
    title('Root Locus');
    xlabel('Real');
    ylabel('Imaginário');
    
    % Plot pole-zero map
    figure;
    pzmap(1/(1 + system));  % Pole-zero map
    grid on;

    % Add title and labels
    title('Lugar das raízes');
    xlabel('Real');
    ylabel('Imaginário');

end

