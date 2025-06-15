clear
clc
close all 
n=; %numero di variabili 
%scrivo le equazioni lineari trasformando se ci sono i vincoli
%da maggiore uguale a minore uguale cambiando i segni
A = [];
b =;
A_eq = [];
b_eq = ;
%scrivo i limiti del problema
LB = *ones(n,1);
UB = *ones(n,1);
u_0 = LB + (UB - LB) .* rand(n,1); il pezzo in giallo solo quando ho i limite superiore e inferiore
options = optimoptions('fmincon','Display','iterdetailed','PlotFcn','optimplotfval');
[u,fval,exitflag,output] = fmincon(@(u)fun_obiettivo(u),u_0,A,b,A_eq,b_eq,LB,UB,@(u)my_nl(u),options);
disp('the optimal solution is ')
disp(u)
disp(['la funzione di costo ottimale è $ ‘, num2str(fval)])
%scrivo la funzione obiettivo 
function L = fun_obiettivo(u)
L = ; %devo stare attento se il problema è di max lo devo trasformare in min  max L = min -L
end
%dichiaro la funzione per i vincoli non lineari
function [c,c_eq] = my_nl(u)
c = [];
c_eq = []; 
end
