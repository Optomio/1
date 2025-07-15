clear
clc
close all

% Caricamento dati
load('data_b.mat');  % Contiene: investimenti, formazione, performance

% Matrice delle variabili indipendenti con termine noto
X = [ones(length(investimenti), 1), investimenti, formazione];

% Variabile dipendente
Y = performance;

% Regressione lineare multipla
beta = (X' * X) \ (X' * Y);  % Coefficienti minimi quadrati

% Predizione
Y_pred = X * beta;

% Calcolo dell'R^2
SS_tot = sum((Y - mean(Y)).^2);
SS_res = sum((Y - Y_pred).^2);
R2 = 1 - (SS_res / SS_tot);

% Output
fprintf('--- Risultati della regressione ---\n');
fprintf('Intercept: %.4f\n', beta(1));
fprintf('Beta (Investimenti Tecnologici): %.4f\n', beta(2));
fprintf('Beta (Formazione Dipendenti): %.4f\n', beta(3));
fprintf('R^2: %.4f\n', R2);

% Grafico 3D (opzionale)
figure;
scatter3(investimenti, formazione, performance, 'filled'); hold on;
[Xs, Ys] = meshgrid(linspace(min(investimenti), max(investimenti)), ...
                    linspace(min(formazione), max(formazione)));
Zs = beta(1) + beta(2)*Xs + beta(3)*Ys;
mesh(Xs, Ys, Zs);
xlabel('Investimenti Tecnologici');
ylabel('Formazione Dipendenti');
zlabel('Performance Operativa');
title('Regressione Lineare Multipla 3D');
legend('Dati', 'Piano stimato');
grid on;


