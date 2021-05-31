
Ef=[21.03,57.79,175.54,467.32,1107.83, 2367.84,4609.44,8241.16,13627.81,20968.49,30176.12,40801.97,52042.03,62838.28,72056.37,78694.51,82067.55,81919.35,78440.08,72194.12,63986.79,54709.31,45198.52,36136.61,28000.28,21055.67,15386.52,10940.20,7577.96,5119.56,3377.26,2177.87,1374.39,849.70,515.18,306.66, 179.39, 103.24, 58.51, 32.69, 18.03,  9.82, 11.21];
ratio = 100000/1000000;

Ef = Ef*ratio;

f = zeros(1,43);

n = 2^32;

WYNIK = liczby32;
WYNIK = WYNIK/2^32;

i=1;
k = 2^31;
counter=1;
j = 0;
j_values = zeros(10000, 1);


for i= 1:100000
    while k ~= 1    
        k = ceil(k*WYNIK(counter));
        j = j+1;
        counter = counter+1;
    end
    if j > 48
            j = 48;
    end
    if j < 6
            j = 6;
    end
    j_values(i) = j;
    k = 2^31;
    
    indeks=j-5;
    temp=f(indeks);
    f(indeks)=temp+1;
    j=0;
end

% plot(Ef)
% hold
% plot(f)
%% Wyliczenie chi-kwadrat

    chsq=0;
    chsq = sum(((f-Ef).^2)./Ef);
    p_value = 1-chi2pdf(chsq,42);
    