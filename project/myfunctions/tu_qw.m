function [x, P] = tu_qw(x, P, omega, T, Rw)
% TU_QW  EKF time update step
    % Update x and P when w is available
    % Calculate  F G Q
        F = eye(size(x,1))+(T/2)*Somega(omega);
        G = (T/2)*Sq(x);
        Q=G*Rw*G';
        x = F*x;
        P = F*P*F' + Q;
    
end