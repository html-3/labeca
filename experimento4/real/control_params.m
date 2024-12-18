function [Kp, Ti, Kd1, Kd2, Ko, Ki, Ka, Kt, Kr, tau] = control_params()
    Kd1 = 0.0005399;
    Kd2 = 1232;
    Ko = 5;
    Ki = 4.295 / (22.94 + 4.295);
    Ka = 9.1061;
    Kt = 0.1530;
    tau = 0.0896;
    Kr = 1/0.7;
    
    Kp = 1 / (Ka * Kt * Kd1 * Kd2 * Ko * Ki * Kr);
    z = tau + 12;
    Ti = 1/z;
end

