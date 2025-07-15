load nomefile   % carica i dati dal file (deve contenere x, y, z)

N = length(y);  % numero di osservazioni

% Primo modello: y ≈ θ1_1 * x^2 + θ1_2 * x + θ1_3 * z + θ1_4 * 1
PHI_1 = [x.^2, x, z, ones(N, 1)];

% Secondo modello: y ≈ θ2_1 * x^2 + θ2_2 * z^2 + θ2_3 * x + θ2_4 * z + θ2_5 * 1
PHI_2 = [x.^2, z.^2, x, z, ones(N, 1)];

% Stima dei parametri con metodo dei minimi quadrati
theta_1 = PHI_1 \ y;
theta_2 = PHI_2 \ y;

% Predizioni dei due modelli
y_hat_1 = PHI_1 * theta_1;
y_hat_2 = PHI_2 * theta_2;

% Errori residui
err_1 = y_hat_1 - y(:);
err_2 = y_hat_2 - y(:);

% Total Sum of Squares
TSS = sum((y - mean(y)).^2);

% Residual Sum of Squares
RSS_1 = sum(err_1.^2);
RSS_2 = sum(err_2.^2);

% Coefficienti di determinazione R^2
Rsq_1 = 1 - (RSS_1 / TSS);
Rsq_2 = 1 - (RSS_2 / TSS);

% Confronto finale
disp(['R^2 modello 1: ', num2str(Rsq_1)])
disp(['R^2 modello 2: ', num2str(Rsq_2)])

if abs(Rsq_1 - Rsq_2) < 0.01
    disp('I modelli hanno prestazioni simili. Si sceglie il più semplice: modello 1.')
elseif Rsq_1 > Rsq_2
    disp('Meglio il modello 1.')
else
    disp('Meglio il modello 2.')
end

