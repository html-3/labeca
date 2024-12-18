function [Kp_old, Ti_old, Kd1, Kd2, Ko, Ki, Ka, Kt, Kr_old, tau] = control_params_old()
    Kd1 = 0.0005399;
    Kd2 = 1232;
    Ko = 5;
    Ki = 4.295 / (22.94 + 4.295);
    Ka = 9.1061;
    Kt = 0.1530;
    tau = 0.0896;
    Kr_old = 1.39;
    
    Kp_old = 1 / (Ka * Kt);
    z = tau + 12;
    Ti_old = 1/z;
end

