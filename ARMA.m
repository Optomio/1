clear
clc
close all

load my_id_b.mat %carico i dati
figure(1)
plot(y_ARMA) %grafico serie storica
figure(2)
autocorr(y_ARMA) %grafico l'autocorrelazione totale
figure(3)
parcorr(y_ARMA) %grafico l'autocorrelazione parziale
%Verificato l'andamento degli autocorrelogrammi posso definire un modello
%ARMA

%Inizio ad identificare la parte AR di un ARMA con le equazioni di Youle
%Walker

N=3000; %utilizzo solo questi dati per l'identificazione
y=y_ARMA(101:N+100);
[acf,lang,bounds]=autocorr(y);

%Non avendo l'ordine vado per tentativi cambiando n_D
n_D=3;

%Scrivo la matrice quadrata R che inizializzo come matrice di zeri per poi
%andarla a riempire
R=zeros(n_D);
acf=acf(2:end);
%Costruisco le colonne di R

for kk=1:n_D
    R(:,kk)=acf(n_D+1-kk:2*n_D-kk);
end

my_rho=acf(n_D+1:2*n_D);
theta_AR=R\my_rho;
%Identifico la componente AR

for kk=1:n_D
    PHI_AR(:,kk)=y(n_D+1-kk:N-kk);
end

y_hat_AR=PHI_AR*theta_AR;

%La stima della componente MA è:
my_eta=y(n_D+1:N)-y_hat_AR;
close all

figure (4)
autocorr(my_eta)

figure(5)
parcorr(my_eta)

%Pongo il problema di identificare la componente MA 
%parto con un ordine di tentativo
n_eq=17;

for kk=1:n_eq
    PHI_eq(:,kk)=my_eta(n_eq+1-kk:end-kk);
end

theta_eq=PHI_eq\my_eta(n_eq+1:end);

%Previsione dell'uscita di un AR
eta_hat=PHI_eq*theta_eq;
w_hat=my_eta(n_eq+1:end)-eta_hat;

%Vedo se w_hat ha le caratteristiche statistiche di un rumore bianco;
%calcolo l'autocorrelazione totale e faccio un test di bianchezza

figure(6)
autocorr(w_hat)
[h_eta,p_eta]=lbqtest(w_hat)

%Scarto le eta per le quali non ho le w precedenti
my_eta=my_eta(n_eq+1:end);
%Faccio la stima ai minimi quadrati
n_N=3; %ordine della componente MA

for kk=1:n_N
    PHI_MA(:,kk)=w_hat(n_N+1-kk:end-kk);
end

theta_MA=PHI_MA\(my_eta(n_N+1:end)-w_hat(n_N+1:end));
