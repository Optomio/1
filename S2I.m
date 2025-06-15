clear 
clc
close all
%definisco l'ordine del sistema
n=3;
%definisco la matrice dinamica A
A=[0.3 0 0; 0 0.25 0; 0 0 0.33];
%calcolo gli autovalori di A
autovalori_A=eig(A);
%definisco il numero di ingressi
m=2;
%definisco le matrici di ingresso e uscita B e C
B=randn(n,m);
C=[1 0 0];
%definisco il tempo di simulazione
T=100;
%preallocazione dello stato
x=zeros(n,T);
%condizione iniziale
x=rand(n,1);

for k=1:T-1
    x(:,k+1)=A*x(:,k)+B*randn(m,1);
    y(:,k)=C*x(:,k);
end

%grafico
figure(1)
plot(x','LineWidth',1)
figure(2)
plot(y,'LineWidth',1.5)
