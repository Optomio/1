n = 3;
rendimenti_attesi = [0.3 0.5 0.4];
covarianza = [0.10 0.02 -0.04;
              0.02 0.12 0;
             -0.04 0 0.11];
A = -rendimenti_attesi;   % vincolo: rendimento ≥ 0.1
b = -0.1; %inseriamo il rendimento atteso
Aeq = ones(1,n);
beq = 1; %inseriamo il valore del capitale totale
LB = zeros(n,1);
X0 = ones(n,1)/n;  % oppure [0.2; 0.3; 0.5];
options = optimoptions('fmincon', 'Algorithm', 'interior-point', 'Display', 'iter-detailed','PlotFcn', 'optimplotx', 'EnableFeasibilityMode', true);  % ATTIVATO
[X, fval, exitflag] = fmincon(@(x) x'*covarianza*x, X0, A, b, Aeq, beq, LB, [], [], options);
disp('Soluzione ottima:');
disp(X)
