clear
clc
close all
n = 4; %definisco il numero di variabili decisionali
A = [1 1 1 1]; %definisco la matrice A dei vincoli di disuguaglianza
b = [50]; %definisco il vettore B dei termini noti dei vincoli di disuguaglianza
Aeq = [4 0 3 0]; %definisco la matrice dei vincoli di uguaglianza
beq = [60]; %definisco il vettore dei termini noti dei vincoli di uguaglianza
lb = 1*ones(n,1); %definisco il lower bound
ub = 10*ones(n,1); %definisco l'upper bound
x_0 = [3 3 3 3]'; %definisco la condizione iniziale
options = optimoptions('fmincon','Algorithm','interior-point','Display','iter-detailed','PlotFcn','optimplotfval');
[x, fval, exitflag, output] = fmincon (@(x)funzione_obiettivo(x), x_0, A, b, Aeq, beq, lb, ub, @(x)v_nlineare(x), options);
%stampo le soluzioni
disp('The optimail solution is: ');
disp(x);
disp(['The maximum cost of production is $' num2str(fval)]);
Funzione non lineare
function [c ceq] = v_nlineare(x)
ceq = [];
c = x(1)^2 + x(2)^2 + x(3)^2 -20;
end
Funzione obiettivo
function L = funzione_obiettivo(x)
L = 5*x(1)^2*x(2) + 3*x(3)^3;
end
