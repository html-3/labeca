function plotter_real()
   
    controlData = load('control.mat');
    referenceData = load('reference.mat');
    tacometerData = load('tacometer.mat');
    
    control_time = controlData.control.time;
    control_signal = squeeze(controlData.control.signals.values);
    
    reference_time = referenceData.reference.time;
    reference_signal = squeeze(referenceData.reference.signals.values);
    
    tacometer_time = tacometerData.tacometer.time;
    tacometer_signal = squeeze(tacometerData.tacometer.signals.values);
    
    % Define the desired time range
    t_start = 1; 
    t_end = 3;  
    
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
    subplot(1,2,1);
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
    
    Kr = 1.38; % Ganho de correção dentro da malha de controle
    
    % Plot the data
    subplot(1,2,2);
    hold on;
    grid on;
    
    % Plot control signal
    plot(control_time, smooth(Kd1 * Ko * control_signal + 1.5, 20), 'r-', 'LineWidth', 1.5, 'DisplayName', 'Sinal de controle');
    
    % Plot setpoint data
    plot(reference_time, 1/Kd2 * 1/Ki * 1/Kr * (reference_signal + 170), 'k--', 'LineWidth', 1.5, 'DisplayName', 'Sinal de referência');
    
    % Plot tachometer data
    plot(tacometer_time, smooth(1/Kd2 * 1/Ki * 1/Kr * (tacometer_signal + 170), 20), 'b-', 'LineWidth', 1.5, 'DisplayName', 'Sinal do tacômetro');
    
    % Add labels, legend, and title
    xlabel('Tempo (s)');
    ylabel('Tensão (V)');
    title('Sinais contínuos');
    legend('show');
    
end