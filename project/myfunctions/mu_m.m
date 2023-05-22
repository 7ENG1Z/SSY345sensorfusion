function [x,P] = mu_m(x,P,mag,m0,Rm)
            %calculate Hx and hx
            [a, b ,c ,d]= dQqdq(x);
            Hx=[a'*m0,b'*m0, c'*m0, d'*m0];
            hx=Qq(x)'*m0;

            %implement EKF update
            S=Hx*P*Hx'+Rm;
            k=P*Hx'/S;
                       
            x=x+k*(mag-hx);
            P=P-k*S*k';
end 