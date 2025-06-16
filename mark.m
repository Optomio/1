n = 3;
rendimenti_attesi = [0.3, 0.5, 0.4];
covarianza = [0.10, 0.02, -0.04; 0.02, 0.12, 0; -0.04, 0, 0.11];

Aeq = [rendimenti_attesi; ones(1,n)]; 
beq = [0.1; 1]; %il primo termine è il rendimento atteso, il secondo è il toatale del capitale
LB = -inf(n,1); % Short selling permesso
X0 = ones(n,1)/n; % Punto iniziale uniforme

options = optimoptions('fmincon', 'Algorithm', 'interior-point', ...
                      'Display', 'iter-detailed', 'PlotFcn', 'optimplotx');

[X, fval, exitflag] = fmincon(@(x) x'*covarianza*x, X0, [], [], Aeq, beq, LB, [], [], options);

% Verifica dei risultati
disp('Pesi ottimali:'); disp(X);
disp(['Varianza minima: ', num2str(fval)]);
disp(['Rendimento atteso: ', num2str(rendimenti_attesi * X)]);
disp(['Somma pesi: ', num2str(sum(X))]);
