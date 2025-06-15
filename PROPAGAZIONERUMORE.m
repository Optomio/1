clear
clc
close all
%definisco l'ordine del sistema
n=3;
%definisco la matrice dinamica A
A=[0.3 0 0; 0 0.25 0;0 0 0.33];
%calcolo gli autovalori
autovalori_A=eig(A);
%definisco le matrici di ingresso e uscita B e C
B=[1 2 3]';
C=[1 0 0; 1 1 1];
%definisco il tempo di simulazione
T=50;
%preallocazione dello stato
x=zeros(n,T);
%condizione iniziale
x=rand(n,1);

for k=1:T-1
    x(:,k+1)=A*x(:,k)+B*randn(1);
    y(:,k)=C*x(:,k);
end

%grafico
figure(1)
plot(x','LineWidth',1)
figure(2)
plot(y,'LineWidth',1.5)
