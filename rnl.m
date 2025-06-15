clear
clc
close all

load data_nonlin.mat

%diagrammo i dati a disposizione
figure(1);
scatter(X,y,'filled');
hold on;

%Verificato dal grafico un andamento non lineare scrivo il numero di dati e
%divido il dataset in training set e test set
n=80;
N=20;

X_train=X(1:N);
X_test=X(N+1:end);
y_train=y(1:N);
y_test=y(N+1:end);

figure(2)
scatter(X_train,y_train,'filled');
hold on
scatter(X_test,y_test,'filled');

degrees=[1 2 3 4]; %vettore dei gradi del polinomio

%Per la matrice di regressione PHI costruisco un ciclo for, dato che è
%necessario definirla per ogni grado

%Applico il metodo dei minimi quadrati relativo al training set e al test
%set

for i=1:length(degrees)
    degree=degrees(i);
    PHI_train=ones(N,1);
    for j=1:degree
        PHI_train=[PHI_train,X_train.^j];
    end
    theta=PHI_train\y_train;
    PHI_test=ones(n,1);
    for j=1:degree
        PHI_test=[PHI_test,X_test.^j];
    end

    y_hat_train=PHI_train*theta;
    y_hat_test=PHI_test*theta;

    %Calcolo gli errori di previsione
    eps_train=y_train-y_hat_train;
    eps_test=y_test-y_hat_test;

    %Calcolo le METRICHE (statistiche) relative al training set e test set
    RSS_train=sum(eps_train.^2)
    TSS_train=sum((y_train-mean(y_train)).^2)
    Rsq_train=1-RSS_train/TSS_train

    RSS_test=sum(eps_test.^2)
    TSS_test=sum((y_test-mean(y_test)).^2)
    Rsq_test=1-RSS_test/TSS_test

end
