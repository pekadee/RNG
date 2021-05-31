
n = 2^32;

LOSOWE = liczby32;
LOSOWE = reshape(LOSOWE, 32, []).';
LOSOWE = dec2bin(LOSOWE);

p=0;

x = 1;
k = 0;
no_Dup = 0;

for z = 1:9
    for no_obs = 1:500

            for x = ((no_obs-1)*1024+1):((no_obs-1)*1024+1024)
                bity = LOSOWE(x, z:z+23);
                if p == 0
                    allBits = bity;
                    p = 1;
                else
                    allBits = [allBits, bity];
                end
                x = x+1;
            end
            x = 1;

            allBits = reshape(allBits, 24, []).';
            allBits = bin2dec(allBits);
            allBits = sort(allBits);

            %% Wyliczenie odstêpów
            while x<1024
                SPACE(x) = allBits(x+1) - allBits(x);
                x = x+1;
            end
            SPACE = sort(SPACE);
            x = 1;
            %% Liczba rownych odstepow
            Y = sort(SPACE);

            while x<1023
                if Y(x) == Y(x+1)
                    no_Dup = no_Dup + 1;
                end
                x = x+1;
            end
            x = 1;
        %% 9 p-wartosci

                    p_i(no_obs) = no_Dup;

            no_Dup = 0;
            p = 0;
    end
clear allBits; 
lambda = 16;
pd = makedist('Poisson','lambda',lambda);  

bins = 0:35;
c = 500;
expCounts = c * pdf(pd,bins);

counts=hist(p_i(1,:),bins);

[h,prob,st] = chi2gof(bins,'Ctrs',bins, 'Frequency', counts, 'Expected',expCounts,  'NParams',1);
 p_value(z)= prob;


end


cdf = makedist('uniform');
[h,p] = kstest(p_value, cdf);

