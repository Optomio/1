clear
clc
close all 

load data_2d.mat

%diagrammo i dati a disposizione
figure;
scatter(X,y,'filled');
hold on;
%scrivo il numero di dati utilizzati
n=200; %numero totale di dati utilizzati
N=150; %numero di dati utilizzati per il training

%verificato l'andamento lineare divido il dataset in training set e test
%set

X_train=X(1:N,:);
X_test=X(N+1:end,:);
y_train=y(1:N,:);
y_test=y(N+1:end,:);

%Regressione ai minimi quadrati
%costruisco la matrice PHI dei regressori che ha due colonne di cui una è
%il regressore e l'altra l'intercetta
PHI=[X_train ones(N,1)];
theta_ls=PHI\y_train;
y_hat=PHI*theta_ls;

%PLOTTIAMO I DATI
%plotto la retta di regressione
plot(X_train, y_hat, 'r','LineWidth',2)
xlabel('Feature')
ylabel('Target')
hold off;

%Calcolo le METRICHE (statistiche) relative al training set e al test set

%metriche relative al training set
y_hat=[X_train ones(N,1)]*theta_ls; %y predette
err_train=y_hat-y_train(:); %errore di previsione
TSS_train=sum((y_train-mean(y_train)).^2) %Total Sum-Of-Squares
RSS_train=sum(err_train.^2) %Residual Sum-Of-Squares
Rsq_train=1-RSS_train/TSS_train %R-Squared
MSE_train=RSS_train/N

%metriche relative al test set
y_pred=[X_test ones(n-N,1)]*theta_ls;
err_test=y_pred-y_test(:);
MSE_test=mean(err_test.^2)
TSS_test=sum((y_test-mean(y_test)).^2)
RSS_test=sum(err_test.^2)
Rsq_test=1-RSS_test/TSS_test
