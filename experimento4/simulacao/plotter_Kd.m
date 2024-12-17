function plotter_Kd()
    % Load Arduino input data
    arduinoInData = load('dados/arduino_in.mat');
    arduinoOutData = load('dados/arduino_out.mat');
    
    % Extract Arduino output
    arduinoIn = arduinoInData.out;
    arduinoOut_time = arduinoIn.tout;
    arduinoIn_signal = arduinoIn.rect_arduino;
    
     % Extract Arduino input
    arduinoIn = arduinoOutData.arduino;
    [arduinoIn_time, arduinoOut_signal] = arduinoIn.data;
    arduinoOut_signal = squeeze(arduinoOut_signal);
    
    % Load oscilloscope input data
    oscilloscopeIn = readtable('osciloscopio_in.csv', 'ReadVariableNames', false);
    oscilloscopeIn = table2array(oscilloscopeIn);
    oscilloscopeIn_time = oscilloscopeIn(:, 1);
    oscilloscopeIn_signal = oscilloscopeIn(:, 2);
    
    % Load oscilloscope output data
    oscilloscopeOut = readtable('osciloscopio_out.csv', 'ReadVariableNames', false);
    oscilloscopeOut = table2array(oscilloscopeOut);
    oscilloscopeOut_time = oscilloscopeOut(:, 1);
    oscilloscopeOut_signal = oscilloscopeOut(:, 2);
    
    % Find the first rising edge in each signalsi
    [arduinoIn_time, arduinoIn_signal] = align(arduinoIn_time, arduinoIn_signal, 1000, 0.2);
    [arduinoOut_time, arduinoOut_signal] = align(arduinoOut_time, arduinoOut_signal, 1000, 0.4);
    [oscilloscopeIn_time, oscilloscopeIn_signal] = align(oscilloscopeIn_time, oscilloscopeIn_signal, 1.0, 0.2);
    [oscilloscopeOut_time, oscilloscopeOut_signal] = align(oscilloscopeOut_time, oscilloscopeOut_signal, 1.0, 0.4);
    
    % Plot the data
    figure;
    
    % 1st Plot: Arduino Input
    subplot(4, 1, 1);
    plot(arduinoIn_time, arduinoIn_signal, 'b-', 'LineWidth', 1.5);
    grid on;
    xlabel('Tempo (s)');
    ylabel('N. quant. (u.q.)');
    title('Sinal gerado pelo DUE e visto pelo DUE');
    
    % 2nd Plot: Arduino Output
    subplot(4, 1, 2);
    plot(arduinoOut_time, arduinoOut_signal, 'r-', 'LineWidth', 1.5);
    grid on;
    xlabel('Tempo (s)');
    ylabel('N. quant. (u.q.)');
    title('Sinal gerado pelo osciloscógio e visto pelo DUE');
    
    % 3rd Plot: Oscilloscope Input
    subplot(4, 1, 3);
    plot(oscilloscopeIn_time, oscilloscopeIn_signal, 'b-', 'LineWidth', 1.5);
    grid on;
    xlabel('Tempo (s)');
    ylabel('Tensão (V)');
    title('Sinal gerado pelo DUE e visto pelo osciloscógio');
    
    % 4th Plot: Oscilloscope Output
    subplot(4, 1, 4);
    plot(oscilloscopeOut_time, oscilloscopeOut_signal, 'r-', 'LineWidth', 1.5);
    grid on;
    xlabel('Tempo (s)');
    ylabel('Tensão (V)');
    title('Sinal gerado pelo osciloscógio e visto pelo osciloscógio');
    
    k1n1 = mean(oscilloscopeIn_signal(find(oscilloscopeIn_signal>2.5)));
    k1n2 = mean(oscilloscopeIn_signal(find(oscilloscopeIn_signal<0.6)));
    k1d1 = mean(arduinoIn_signal(find(arduinoIn_signal>3000)));
    k1d2 = mean(arduinoIn_signal(find(arduinoIn_signal<300)));
    Kd1 = (k1n1 - k1n2) / (k1d1 - k1d2);
    fprintf('Kd1 = %.4g V/u.q. \n',Kd1);
    
    k2n1 = mean(arduinoOut_signal(find(arduinoOut_signal>3000)));
    k2n2 = mean(arduinoOut_signal(find(arduinoOut_signal<300)));
    k2d1 = mean(oscilloscopeOut_signal(find(oscilloscopeOut_signal>2.9)));
    k2d2 = mean(oscilloscopeOut_signal(find(oscilloscopeOut_signal<0.1)));
    Kd2 = (k2n1 - k2n2) / (k2d1 - k2d2);
    fprintf('Kd2 = %.4g u.q./V \n',Kd2);
    
end

% Helper function to find the first rising edge
function [time, signal] = align(time, signal, threshold, t_end)
    % Calculate the derivative of the signal
    dSignal = diff(signal);
    
    % Find the first index where the derivative exceeds a threshold (rising edge)
    rising_edge_index = find(dSignal > threshold, 1, 'first');
    
    % Get the corresponding time
    if ~isempty(rising_edge_index)
        time = time(rising_edge_index:end) - time(rising_edge_index);
        signal = signal(rising_edge_index:end);
       
        time = time(find(time< t_end));
        signal = signal(find(time< t_end));
        
    else
        time;
        signal;
    end
end