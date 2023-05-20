function [mu, Sigma] = get_mean_cov(Y)
%this function get the mean and cov of Y
mu=mean(Y,2);
Sigma = zeros(length(mu),length(mu));
for i = 1:length(Y)
    sigma = (Y(:,i)-mu)*(Y(:,i)-mu)';
    Sigma = Sigma+sigma;
end    
Sigma= Sigma/(length(Y)-1);
end