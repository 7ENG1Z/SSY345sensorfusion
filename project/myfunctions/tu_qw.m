function [x, P] = tu_qw(x, P, omega, T, Rw)
% TU_QW  EKF time update step
    % Update x and P when w is available
    % omega is the measured angular rate, 
    % T the time since the last measurement,
    % Rw the process noise covariance matrix.
    % Calculate  F G Q
        F = eye(size(x,1))+(T/2)*Somega(omega);
        G = (T/2)*Sq(x);% process noise also has a motion model
        Q=G*Rw*G';
        x = F*x;%process noise is zero mean
        P = F*P*F' + Q;
    
end