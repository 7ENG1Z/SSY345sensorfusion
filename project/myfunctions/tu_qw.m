function [x, P] = tu_qw(x, P, omega, T, Rw)
% TU_QW  EKF time update step
    
% Calculate F , G and Q
    F = eye(size(x,1))+(T/2)*Somega(omega);
    G = (T/2)*Sq(x);
    Q=G*Rw*G';
%to determine if the omega is empty
    if ~isnan(omega)
    % Update x and P when w is not available
        P = P + Q;
    else
    % Update x and P when w is available
        x = F*x;
        P = F*P*F' + Q;
    end

end