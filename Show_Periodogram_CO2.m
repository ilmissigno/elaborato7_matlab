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

%Otteniamo la Frequenza di Campionamento che in questo caso indica una
%registrazione al Mese (singolo campione)
Fs = 1;
temperature = co2(:,2);%togliere
%Calcolo della FFT
Y = fft(temperature);
%Rimozione componente continua, prima di farlo ne effettuo una copia
comp_continua = Y(1);
Y(1) = [];
%ricavo il numero di campioni sia dalla trasformata che dalle misurazioni
%(ovviamente la fft produce un vettore in uscita che contiene componente
%reale e immaginaria, la lunghezza di entrambe e' il numero di campioni 
%ed e la stessa ed e' la lunghezza del vettore)
n = length(temperature);%dovrebbe essere lo stesso
N = length(Y);
%Ricavo l'ampiezza della trasformata, ricordo che quella in uscita dalla
%trasformata e' A*(N/2), il calcolo di floor permette di selezionare tutte
%le armoniche di Y prima di N/2 dato che quelle dopo sono simmetriche e
%approssima per difetto alla frequenza piu' vicina. (vedi Frequenza di
%Nyquist
A = 2.*abs(Y(1:floor(n./2))./n);
%Ricavo la frequenze, allo stesso modo considero solo quelle da 0 a N/2
%dato che sono simmetriche e le moltiplico per il rapporto tra la frequenza campione
%e il numero di campioni
freq = (1:floor(n./2)).*Fs./n;
%calcolo la potenza come il modulo dell'ampiezza al quadrato
potenza = abs(A).^2;

%Stampo il periodogramma con la funzione Stem analoga a Plot ma relativa a
%periodogrammi

figure();
stem(freq,potenza,'fill','MarkerSize',4,'MarkerFaceColor','b');
grid on
title('Periodogramma CO2 espresso in Frequenze');
xlabel('Frequenze in cicli/mesi');
ylabel('Potenza in funzione delle Frequenze');

%Stampo il periodogramma in funzione del periodo stavolta

T = 1./freq;
figure();
stem(T,potenza,'fill','MarkerSize',4,'MarkerFaceColor','b');
grid on
title('Periodogramma CO2 espresso in Periodo');
xlabel('Periodo in cicli/mesi');
ylabel('Potenza in funzione del Periodo');

end