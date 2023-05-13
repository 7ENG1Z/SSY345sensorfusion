function [xfp, Pfp, Xp, Wp] = pfFiltermap(x_0, P_0, Y, proc_f, proc_Q, meas_h, meas_R, ...
                             N, bResample, plotFunc)
%PFFILTER Filters measurements Y using the SIS or SIR algorithms and a
% state-space model.
%
% Input:
%   x_0         [n x 1] Prior mean
%   P_0         [n x n] Prior covariance
%   Y           [m x K] Measurement sequence to be filtered
%   proc_f      Handle for process function f(x_k-1)
%   proc_Q      [n x n] process noise covariance
%   meas_h      Handle for measurement model function h(x_k)
%   meas_R      [m x m] measurement noise covariance
%   N           Number of particles
%   bResample   boolean false - no resampling, true - resampling
%   plotFunc    Handle for plot function that is called when a filter
%               recursion has finished.
% Output:
%   xfp         [n x K] Posterior means of particle filter
%   Pfp         [n x n x K] Posterior error covariances of particle filter
%   Xp          [n x N x K] Non-resampled Particles for posterior state distribution in times 1:K
%   Wp          [N x K] Non-resampled weights for posterior state x in times 1:K

% Your code here, please. 
% If you want to be a bit fancy, then only store and output the particles if the function
% is called with more than 2 output arguments.
n=size(x_0,1);
m=size(Y,1);
K=size(Y,2);

Xk=(mvnrnd(x_0,P_0,N))';
Wk=(1/n)*ones(1,N);

xfp=zeros(n,K);
Pfp=zeros(n,n,K);
Xp=zeros(n,N,K);
Wp=zeros(N,K);


for i=1:K
    %%%% need to have bResample 
    if bResample
    [Xk, Wk,j] = resampl(Xk, Wk);
    else
        j=[1:1:N];
    end
    
    [Xk, Wk] = pfFilterStep(Xk, Wk, Y(:,i), proc_f, proc_Q, meas_h, meas_R);
    
    %add map information
    % to know if the particles are on road
    [u] = isOnRoad(Xk(1,:),Xk(2,:));
    % change the weight to if the particle is not on road
    u = reshape(u,1,N);
    Wk=u.*Wk';
    Wk=Wk/sum(Wk);
    %end the addinformation
    
    Xp(:,:,i)=Xk;
    Wp(:,i)=Wk';

     xfp(:, i) = sum(Xp(:, :, i).* Wp(:, i)', 2);
     Pfp(:, :, i) = Wp(:,i)'.*(Xp(:,:,i)- xfp(:,i))*(Xp(:,:,i)- xfp(:,i))';
     if ~isempty(plotFunc)&&i>=2
        plotFunc(i,Xp(:,:,i),Xp(:,:,i-1),j)
     end 
 end



end


function [Xr, Wr, j] = resampl(X, W)
    % Copy your code from previous task! 
    n=size(X,1);
    N=size(X,2);

    Xr=zeros(n,N);
    Wr=(1/N).*ones(1,N);
    j=zeros(1,N);


W=W/sum(W);
for i =1:N
    r=rand;
    c=0;
    for k= 1:N
        c=c+W(k);
        if r<c
            Xr(:,i)=X(:,k);
            j(:,i)=k;
            break;
        end
    end
end



end

function [X_k, W_k] = pfFilterStep(X_kmin1, W_kmin1, yk, proc_f, proc_Q, meas_h, meas_R)
    % Copy your code from previous task!
    n=size(X_kmin1,1);
    N=size(X_kmin1,2);
    m=size(yk,1);

    X_k=zeros(n,N);
    W_k=zeros(1,N);


for i =1:N
     Q = (mvnrnd(zeros(n,1),proc_Q))';
     X_k(:,i)=proc_f(X_kmin1(:,i))+Q;
     W_k(:,i)=W_kmin1(:,i)*mvnpdf(yk-meas_h(X_k(:,i)),0,meas_R);
end

W_k=W_k/sum(W_k);

end
