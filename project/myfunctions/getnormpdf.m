function [X,Y] =getnormpdf(mu,sigma,a)
%this function get the Gaussian distribution figure
% mu and sigma define distribution
% a defines the sampling range, b defines the sampling interval

X=(mu-6*sqrt(sigma)):a:(mu+6*sqrt(sigma));
Y=normpdf(X,mu,sqrt(sigma));

end