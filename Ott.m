clear
clc
close all
%Definisco il numero di variabili decisionali
n=5;
%definisco la matrice A dei vincoli lineari di disuguaglianza
A=[1 2 0 0 0;
3 0 0 -1 0];
%definisco b
b=[50;10];
%definisco la matrice A_eq dei vincoli lineari di uguaglianza
A_eq=[0 1 1 0 1];
%definisco b_eq
b_eq=[20];
%definisco LB e UB
LB=[1 0 5 0 2]';
UB=[10 15 25 10 8]';
%definisco cond iniziale randomica
xo=rand(n,1);
options=optimoptions('fmincon','PlotFcn','optimplotfval');
[x,fval,exitflag]= fmincon(@(x)funzione_13_Gennaio(x), xo,A,b,A_eq,b_eq,LB,UB,@(x)funzione_nl_13_Gennaio(x),options);
disp('la soluzione ottima è:')
disp(x);
 
function L=funzione_13_Gennaio(x)
L=2*x(1)^2+x(2)^2-(x(3)*x(4))+4*x(5)^2+10;
end
 
function [c c_eq]=funzione_nl_13_Gennaio(x);
c_eq=[];
c=[x(2)^2+x(3)-4*x(4)-30;
4*x(1)+3*x(3)*x(5)-60];
end
