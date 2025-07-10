clear
clc
close all

% Dati dell'esercizio (aggiungo x2 come seconda variabile indipendente)
x1 = [1; 2; 3; 4; 5; 6];       % Prima variabile (come prima)
x2 = [0.1; 0.5; 1.2; 2.0; 2.5; 3.0]; % %%% NUOVA VARIABILE x2
y = [3.54; 7.83; 6.74; 12.86; 15.32; 16.69]; 

% Diagramma 3D (opzionale)
figure;
scatter3(x1, x2, y, 'filled');
xlabel('x1'); ylabel('x2'); zlabel('y');
title('Regressione Lineare 3D');

%%% CAMBIAMENTO - MATRICE PHI ORA HA 3 COLONNE (intercetta, x1, x2)
PHI = [ones(N,1), x1, x2]; % Forma: [1, x1, x2]
%%% FINE CAMBIAMENTO

% Stima coefficienti (stesso metodo)
theta_ls = PHI \ y;

% Predizioni
y_hat = PHI * theta_ls;

%%% CAMBIAMENTO - EQUAZIONE MODELLO (aggiunge x2)
fprintf('\nModello 3D stimato: y = %.4f + %.4f*x1 + %.4f*x2\n', theta_ls(1), theta_ls(2), theta_ls(3));
%%% FINE CAMBIAMENTO

% Metriche (stesso calcolo, ma su modello 3D)
err = y_hat - y;
Rsq = 1 - sum(err.^2)/sum((y - mean(y)).^2);
disp(['R-squared: ', num2str(Rsq)]);
