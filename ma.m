clear
clc
close all

load my_id_data.mat %carico i dati

figure(1)
plot(y_MA) %grafico serie storica
figure(2)
autocorr(y_MA) %grafico autocorrelazione totale
figure(3)
parcorr(y_MA) %grafico autocorrelazione parziale

%Verificato l'andamento degli autocorrelogrammi posso definire un modello
%MA 
%Definisco l'ordine andando per tentativi
n_D=17;

for kk=1:n_D
    PHI(:,kk)=y_MA(n_D+1-kk:end-kk);
end

theta_eq=PHI\y_MA(n_D+1:end)
y_hat_AR=PHI*theta_eq
w_hat=y_MA(n_D+1:end)-y_hat_AR
[h,p]=lbqtest(w_hat)
close all
figure(4)
autocorr(w_hat)
y=y_MA(n_D+1:end);
n_N=3;

for kk=1:n_N
    PHI_MA(:,kk)=w_hat(n_N+1-kk:end-kk);

end

theta_MA=PHI_MA\(y(n_N+1:end)-w_hat(n_N+1:end))
