function [x,P] = mu_g(x,P,yacc,Ra,g0 )
            
            %calculate Hx and hx
            [a, b ,c ,d]= dQqdq(x);
            Hx=[a'*g0 ,b'*g0, c'*g0, d'*g0];
            hx=Qq(x)'*g0;

            %implement EKF update
            S=Hx*P*Hx'+Ra;
            k=P*Hx'/S;
                       
            x=x+k*(yacc-hx);
            P=P-k*S*k';

end