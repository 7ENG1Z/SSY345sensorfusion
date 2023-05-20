function [x, P] = tu_qw(x, P, omega, T, Rw)
% TU_QW  EKF time update step
% Calculate  G and Q
    G = (T/2)*Sq(x);
    Q=G*Rw*G';
%to determine if the omega is empty
    if isempty(omega)
    % Update x and P when w is not available
        P = P + Q;
        x=eye(4)*x;
    else
    % Update x and P when w is available
    % Calculate  F
        F = eye(size(x,1))+(T/2)*Somega(omega);
        x = F*x;
        P = F*P*F' + Q;
    end
end