function [comp_continua,potenza,freq,N,Y] = Show_Periodogram(co2)
%{
Il seguente script effettua il grafico del periodogramma
del fenomeno Mauna Loa
Effettuiamo la "Trasformata di Fourier Discreta" per ottenere 
la trasposizione del fenomeno nel dominio delle frequenze. 
Rimuovendo la componente continua viene calcolata la potenza 
che ci consente di mostrare il periodogramma in termini di rapporto 
tra cicli e mesi che in termini di rapporto tra mesi e cicli.
%}
Fs = 1;
temperature = co2(:,2);
Y = fft(temperature);
comp_continua = Y(1);
Y(1) = [];
n = length(temperature);
N = length(Y);
A = 2.*abs(Y(1:floor(n./2))./n);
freq = (1:floor(n./2)).*Fs./n;
potenza = abs(A).^2;

%PERIODOGRAMMA IN FREQUENZA
figure();
stem(freq,potenza,'fill','MarkerSize',4,'MarkerFaceColor','b');
grid on
title('Periodogramma CO2 espresso in Frequenze');
xlabel('Frequenze in cicli/mesi');
ylabel('Potenza in funzione delle Frequenze');

%PERIODOGRAMMA ESPRESSO IN PERIODO
T = 1./freq;
figure();
stem(T,potenza,'fill','MarkerSize',4,'MarkerFaceColor','b');
grid on
title('Periodogramma CO2 espresso in Periodo');
xlabel('Periodo in cicli/mesi');
ylabel('Potenza in funzione del Periodo');
end