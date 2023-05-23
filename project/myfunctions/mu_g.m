function [x,P] = mu_g(x,P,yacc,Ra,g0 )
            %yacc is shorthand for y ka
            %Ra is the measurement noise covariance matrix. 
            %calculate Hx and hx
            [a, b ,c ,d]= dQqdq(x);
            Hx=[a'*g0 ,b'*g0, c'*g0, d'*g0];
            hx=Qq(x)'*g0;
            %implement EKF update
            S=Hx*P*Hx'+Ra;% innovation covariance
            k=P*Hx'/S;%Kalman Gain (K)
            %yacc-hx is the innovation           
            x=x+k*(yacc-hx);
            P=P-k*S*k';

end