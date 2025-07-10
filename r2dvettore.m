clear
clc
close all

% Dati dell'esercizio
x = [1; 2; 3; 4; 5; 6];      % Vettore colonna dei regressori
y = [3.54; 7.83; 6.74; 12.86; 15.32; 16.69]; % Vettore colonna target

% Diagramma i dati a disposizione
figure;
scatter(x, y, 'filled');
hold on;
title('Regressione Lineare - Esercizio 2');
xlabel('x');
ylabel('y');

%%% CAMBIAMENTO - RIMOSSA DIVISIONE TRAIN/TEST PER PICCOLO DATASET
% Utilizzo tutti i dati (N=6) senza split
X_train = x;
y_train = y;
N = length(x);
%%% FINE CAMBIAMENTO

%%% CAMBIAMENTO - CORRETTO ORDINE MATRICE PHI (prima intercetta)
PHI = [ones(N,1), X_train];  % Forma corretta: [intercetta, regressore]
%%% FINE CAMBIAMENTO

theta_ls = PHI\y_train;
y_hat = PHI*theta_ls;

% Plot della retta di regressione
plot(X_train, y_hat, 'r', 'LineWidth', 2);
legend('Dati osservati', 'Retta di regressione', 'Location', 'northwest');
grid on;
hold off;

%%% CAMBIAMENTO - METRICHE SEMPLIFICATE (solo su dataset completo)
err = y_hat - y_train;
TSS = sum((y_train - mean(y_train)).^2);
RSS = sum(err.^2);
Rsq = 1 - RSS/TSS;
MSE = RSS/N;
%%% FINE CAMBIAMENTO

%%% CAMBIAMENTO - AGGIUNTA VISUALIZZAZIONE MODELLO
fprintf('\nModello stimato: y = %.4f + %.4f*x\n', theta_ls(1), theta_ls(2));
fprintf('MSE: %.4f\n', MSE);
fprintf('R-squared: %.4f\n', Rsq);

% Visualizzazione coefficienti con più precisione
disp('Coefficienti stimati:');
disp(theta_ls');
%%% FINE CAMBIAMENTO
