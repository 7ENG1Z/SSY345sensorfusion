[xhat, meas] = filterTemplate();
%%
clc
%mean and cov
a_mean=mean(meas.acc(:, ~any(isnan(meas.acc), 1)), 2);
g_mean=mean(meas.gyr(:, ~any(isnan(meas.gyr), 1)), 2);
m_mean=mean(meas.mag(:, ~any(isnan(meas.mag), 1)), 2);





save meas


