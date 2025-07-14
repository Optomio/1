clear
clc
close all

% Carica i dati
load('data_a.mat');  % Assicurati che il file contenga x1, z, y

% Split train/test
n = length(y);
N = floor(0.75 * n);

x1_train = x1(1:N);
z_train = z(1:N);
y_train = y(1:N);

x1_test = x1(N+1:end);
z_test = z(N+1:end);
y_test = y(N+1:end);

%% Modello (2): y = θ0 + θ1·x1² + θ2·x1 + θ3·z
PHI2_train = [ones(N,1), x1_train.^2, x1_train, z_train];
PHI2_test  = [ones(n-N,1), x1_test.^2, x1_test, z_test];

theta2 = PHI2_train \ y_train;
yhat2_train = PHI2_train * theta2;
yhat2_test  = PHI2_test * theta2;

Rsq2_train = 1 - sum((y_train - yhat2_train).^2) / sum((y_train - mean(y_train)).^2);
Rsq2_test  = 1 - sum((y_test - yhat2_test).^2)   / sum((y_test - mean(y_test)).^2);

%% Modello (3): y = θ0 + θ1·x1² + θ2·z² + θ3·x1 + θ4·z
PHI3_train = [ones(N,1), x1_train.^2, z_train.^2, x1_train, z_train];
PHI3_test  = [ones(n-N,1), x1_test.^2, z_test.^2, x1_test, z_test];

theta3 = PHI3_train \ y_train;
yhat3_train = PHI3_train * theta3;
yhat3_test  = PHI3_test * theta3;

Rsq3_train = 1 - sum((y_train - yhat3_train).^2) / sum((y_train - mean(y_train)).^2);
Rsq3_test  = 1 - sum((y_test - yhat3_test).^2)   / sum((y_test - mean(y_test)).^2);

%% Stampa risultati
fprintf('\n--- MODELLO 2 ---\n');
fprintf('R^2 TRAIN: %.4f\n', Rsq2_train);
fprintf('R^2 TEST:  %.4f\n', Rsq2_test);
fprintf('θ = [%s]\n', num2str(theta2', '%.4f '));

fprintf('\n--- MODELLO 3 ---\n');
fprintf('R^2 TRAIN: %.4f\n', Rsq3_train);
fprintf('R^2 TEST:  %.4f\n', Rsq3_test);
fprintf('θ = [%s]\n', num2str(theta3', '%.4f '));

%% Confronto
if Rsq2_test > Rsq3_test
    fprintf('\nIl modello 2 interpreta meglio i dati (R^2 TEST più alto).\n');
else
    fprintf('\nIl modello 3 interpreta meglio i dati (R^2 TEST più alto).\n');
end
