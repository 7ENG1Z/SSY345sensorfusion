function [x,P] = mu_g(x,P,yacc,Ra,g0)
            
            %calculate Hx and hx
            [a, b ,c ,d]= dQqdq(x);
            Hx=[a ,b, c, d];
            hx=g0*Qq(x)';
            %implement EKF update
            S=(g0^2)*Hx*P*Hx'+Ra;
            k=g0*P*Hx'*inv(S);
                       
            x=x+k*(yacc-hx);
            P=P-k*S*k';

end