clear
clc
close all

load data_3d.mat

%Plotto i dati
figure;
scatter3(X(:,1),X(:,2),y,'filled');
hold on;

%scrivo il numero di dati
n=200; %dati utilizzati 
N=150; %dati utilizzati per il training

%Verificato l'andamento lineare facendo ruotare il grafico passo a dividere
%il dataset in training set e test set

X_train=X(1:N,:);
X_test=X(N+1:end,:);
y_train=y(1:N,:);
y_test=y(N+1:end,:);

%Regressione ai minimi quadrati
%costruisco la matrice PHI dei regressori che ha due colonne di cui una è
%il regressore e l'altra l'intercetta
PHI=[X_train ones(N,1)];
theta_ls=PHI\y_train;

%Plotto il piano di regressione, ottenendo il piano che meglio interpola i
%dati

a=linspace(min(X(:,1)),max(X(:,1)),50)';
b=linspace(min(X(:,2)),max(X(:,2)),50)';
[xx,yy]=meshgrid(a,b);
Z=reshape([xx(:),yy(:),ones(size(xx(:)))]*theta_ls,numel(a),[]);
surf(xx,yy,Z)
xlabel('Feature1')
ylabel('Feature2')
zlabel('Target')
hold off;

%Scrivo le metriche (statistiche) relative al training set e test set
%statistiche relative al training set
y_hat=[X_train(:,1) X_train(:,2) ones(N,1)] * theta_ls; %y predette
err_train= y_hat-y_train(:);  %errore di previsione
TSS_train=sum((y_train-mean(y_train)).^2) %Total Sum-Of-Squares
TSS_train_b=(y_train-mean(y_train))'*(y_train-mean(y_train))
RSS_train=sum(err_train.^2) %Residual Sum-Of-Squares
RSS_train_b= err_train' * err_train 
Rsq_train=1-RSS_train/TSS_train

%statistiche relative al test set
y_pred=[X_test(:,1) X_test(:,2) ones(n-N,1)] * theta_ls;
err_test=y_pred-y_test(:);
TSS_test=sum((y_test-mean(y_test)).^2)
RSS_test=sum(err_train.^2)
Rsq_test=1-RSS_test/TSS_test
