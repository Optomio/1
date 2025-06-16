clear
clc
close all

load data_polynomial.mat

plot(x,y,'o')

N_tr = 251;
y_tr = y(1:N_tr);
x_tr = x(1:N_tr);
PHI_lin = [ones(N_tr,1) x_tr];
PHI_quad = [ones(N_tr,1) x_tr x_tr.^2];
PHI_cube = [ones(N_tr,1) x_tr x_tr.^2 x_tr.^3];

th_lin = PHI_lin\y_tr;
th_quad = PHI_quad\y_tr;
th_cube = PHI_cube\y_tr;

y_hat_lin = PHI_lin*th_lin;
y_hat_quad = PHI_quad*th_quad;
y_hat_cube = PHI_cube*th_cube;

hold on
plot(x_tr,y_hat_lin,'LineWidth',4);
plot(x_tr,y_hat_quad,'LineWidth',4);
plot(x_tr,y_hat_cube,'LineWidth',4);

err_lin = y_tr-y_hat_lin;
err_quad = y_tr-y_hat_quad;
err_cube = y_tr-y_hat_cube;
my_err = y_tr-mean(y_tr);
 
RSS_lin = (err_lin'*err_lin)/N_tr
RSS_quad = (err_quad'*err_quad)/N_tr
RSS_cube = (err_cube'*err_cube)/N_tr
TSS = (my_err'*my_err)/N_tr
var(y_tr)

x_test = x(N_tr+1:end);
y_test = y(N_tr+1:end);

%% testing
N_test = 250;

PHI_a = [ones(N_test,1) x_test];
PHI_b = [ones(N_test,1) x_test x_test.^2];
PHI_c = [ones(N_test,1) x_test x_test.^2 x_test.^3];

y_hat_a = PHI_a*th_lin;
y_hat_b = PHI_b*th_quad;
y_hat_c = PHI_c*th_cube;

figure
plot(x,y,'o')
hold on
plot(x_test,y_hat_a,'LineWidth',4);
plot(x_test,y_hat_b,'LineWidth',4);
plot(x_test,y_hat_c,'LineWidth',4);

err_a = y_test-y_hat_a;
err_b = y_test-y_hat_b;
err_c = y_test-y_hat_c;
 
RSS_a = (err_a'*err_a)/N_test
RSS_b = (err_b'*err_b)/N_test
RSS_c = (err_c'*err_c)/N_test
var(y_test)

[my_theta,FitInfo] = lasso(PHI_cube(:,2:end),y_tr,'CV',10)
lassoPlot(my_theta,FitInfo,PlotType='CV')
