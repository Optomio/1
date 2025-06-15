clear
clc
close all

load data_AR.mat %carico i dati

figure(1)
plot(y_AR) %grafico serie storica
figure(2)
autocorr(y_AR) %grafico autocorrelazione totale
figure(3)
parcorr(y_AR) %grafico autocorrelazione parziale

%Verificato l'andamento degli autocorrelogrammi posso definire un modello
%AR
%utilizzo i seguenti dati per l'identificazione:
N=1500;
y=y_AR(101:end);
n_D=3; %ordine del modello
%Costruisco la matrice PHI 
PHI=[y(n_D:N-1) y(n_D-1:N-2) y(n_D-2:N-3)];
theta_hat=PHI\y(n_D+1:N); %vettore dei parametri stimati
%Calcolo l'errore di previsione
my_eps=y(n_D+1:N)-PHI*theta_hat;
%Valuto l'autocorrelazione dell'errore di estrapolazione prima di fare il
%test di bianchezza

figure(4)
autocorr(my_eps)

[H,P]=lbqtest(my_eps)

%Calcolo la deviazione standard/varianza
Var_y=std(y)
Var_eps=std(my_eps)

%CROSS VALIDAZIONE
y_val=y(N+1:end);
PHI_val=[y_val(n_D:end-1) y_val(n_D-1:end-2) y_val(n_D-2:end-3)];
y_hat_val=PHI_val*theta_hat;
my_eps_val=y_val(n_D+1:end)-y_hat_val;

figure(5)
autocorr(my_eps_val)

[H_val,P_val]=lbqtest(my_eps_val)
