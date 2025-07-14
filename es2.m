clear
clc
close all

% Carica i dati
load('data_b.mat');  % Assumiamo che contenga le variabili x, y, z

% Supponiamo che:
% x = Investimenti Tecnologici
% y = Formazione Dipendenti
% z = Performance Operativa

% Creazione matrice X delle variabili indipendenti con colonna di bias (1)
X = [ones(length(x), 1), x, y];  % Aggiunta del termine noto

% Variabile dipendente
Y = z;

% Calcolo dei coefficienti della regressione (beta)
beta = (X' * X) \ (X' * Y);  % Metodo dei minimi quadrati

% Predizione della performance con il modello
Y_pred = X * beta;

% Calcolo dell'R^2
SS_tot = sum((Y - mean(Y)).^2);      % Somma dei quadrati totali
SS_res = sum((Y - Y_pred).^2);       % Somma dei quadrati dei residui
R2 = 1 - (SS_res / SS_tot);

% Output dei risultati
fprintf('Coefficienti della regressione:\n');
fprintf('Intercept: %.4f\n', beta(1));
fprintf('Beta Investimenti Tecnologici: %.4f\n', beta(2));
fprintf('Beta Formazione Dipendenti: %.4f\n', beta(3));
fprintf('R^2 del modello: %.4f\n', R2);

% (Opzionale) Visualizzazione dei risultati
figure;
scatter3(x, y, z, 'filled'); hold on;
[Xs, Ys] = meshgrid(linspace(min(x),max(x)), linspace(min(y),max(y)));
Zs = beta(1) + beta(2)*Xs + beta(3)*Ys;
mesh(Xs, Ys, Zs);
xlabel('Investimenti Tecnologici');
ylabel('Formazione Dipendenti');
zlabel('Performance Operativa');
title('Regressione Lineare Multipla 3D');
legend('Dati', 'Piano stimato');
grid on;

