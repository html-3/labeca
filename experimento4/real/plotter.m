function plotter()
   
    controlData = load('dados\control.mat');
    referenceData = load('dados\reference.mat');
    tacometerData = load('dados\tacometer.mat');
    
    control = controlData.control;
    reference = referenceData.reference;
    tacometer = tacometerData.tacometer;
    
    control_time = control.time;
    control_signal = squeeze(control.signals.values);
    
    reference_time = reference.time;
    reference_signal = squeeze(reference.signals.values);
    
    tacometer_time = tacometer.time;
    tacometer_signal = squeeze(tacometer.signals.values);
    
    % Define the desired time range
    t_start = 5; 
    t_end = 9;  
    
    % Extract indices for the desired time range
    control_time_indices = (control_time >= t_start) & (control_time <= t_end);
    reference_time_indices = (reference_time >= t_start) & (reference_time <= t_end);
    tacometer_time_indices = (tacometer_time >= t_start) & (tacometer_time <= t_end);
    
    % Extract time and control values for the range
    control_time = control_time(control_time_indices);
    control_signal = control_signal(control_time_indices);
    
    reference_time = reference_time(reference_time_indices);
    reference_signal = reference_signal(reference_time_indices);
    
    tacometer_time = tacometer_time(tacometer_time_indices);
    tacometer_signal = tacometer_signal(tacometer_time_indices);
    
    % Plot the data
    figure;
    hold on;
    grid on;
    
    % Plot control signal
    plot(control_time, smooth(control_signal, 20), 'r-', 'LineWidth', 1.5, 'DisplayName', 'Sinal de controle');
    
    % Plot setpoint data
    plot(reference_time, reference_signal, 'k--', 'LineWidth', 1.5, 'DisplayName', 'Sinal de referência');
    
    % Plot tachometer data
    plot(tacometer_time, smooth(tacometer_signal, 20), 'b-', 'LineWidth', 1.5, 'DisplayName', 'Sinal do tacômetro');
    
    % Add labels, legend, and title
    xlabel('Tempo (s)');
    ylabel('Nível de quantização (u.q.)');
    title('Sinais discretos');
    legend('show');
    
    Kd1 = 0.0005399;
    Kd2 = 1232;
    Ko = 5;
    Ki = 4.295 / (22.94 + 4.295);
    [Kp, Ti] = control_params;
    
    Ke = 1.335; % Ganho de correção dentro da malha de controle
    
    % Plot the data
    figure;
    hold on;
    grid on;
    
    % Plot control signal
    plot(control_time, smooth(Kd1 * Ko * control_signal, 20), 'r-', 'LineWidth', 1.5, 'DisplayName', 'Sinal de controle');
    
    % Plot setpoint data
    plot(reference_time, 1/Kd2 * 1/Ki *  (1/Ke * reference_signal - 100), 'k--', 'LineWidth', 1.5, 'DisplayName', 'Sinal de referência');
    
    % Plot tachometer data
    plot(tacometer_time, smooth(1/Kd2 * 1/Ki * (1/Ke * tacometer_signal - 100), 20), 'b-', 'LineWidth', 1.5, 'DisplayName', 'Sinal do tacômetro');
    
    % Add labels, legend, and title
    xlabel('Tempo (s)');
    ylabel('Tensão (V)');
    title('Sinais contínuos');
    legend('show');
    
end

