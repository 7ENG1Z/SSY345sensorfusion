function [X,Y] =getnormpdf(mu,sigma,a,b)
%this function get the Gaussian distribution figure
% mu and sigma define distribution
% a defines the sampling range, b defines the sampling interval
X=(mu-a):b:(mu+a);
Y=normpdf(X,mu,sigma);

end