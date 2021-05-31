
no_wds = 256000;
prob = [37/256 56/256 70/256 56/256 37/256];
mean = 2500;
std = sqrt(5000);

WYNIK = liczby;
LOSOWE = dec2bin(WYNIK);

for j = 1:24
    
    first = (2080032*j)-2080031;
    last = 2080032*j;
    samp=LOSOWE(first:last);
    
    %% Tworzenie s³ow
        for i = 1 : 260004
            a = (8*i)-7;    
            b = 8*i;
            bajt = samp(a:b);
            bajt = bajt - '0';
            zliczone(i) = sum(bajt(1:8) == 1);
            if zliczone(i) < 3
                litery(i) = 'A';
            elseif zliczone(i) == 3
                litery(i) = 'B';
            elseif zliczone(i) == 4
                litery(i) = 'C';
            elseif zliczone(i) == 5
                litery(i) = 'D';
            else 
                litery(i) = 'E';
            end
        end
    
    for i = 1:no_wds
        slowa_5(i,1:5) = litery(i:i+4);
        slowa_4(i,1:4) = litery(i:i+3);
    end

    %% Zliczanie wyst¹pieñ s³ów
    slowa_5 = cellstr(slowa_5);
    [uc, ~, idc] = unique(slowa_5);
    no_5 = accumarray( idc, ones(size(idc)) );

    slowa_4 = cellstr(slowa_4);
    [uc, ~, idc] = unique(slowa_4);
    no_4 = accumarray( idc, ones(size(idc)) );

    % plot(no_4)

    %% Wartoœci oczekiwane

    for k = 0:3124 %Dla slow 5-literowych 
          Ef = no_wds;
          wd  = k;
          for l = 1:5
            ltr = mod(wd,5)+1;
            Ef = Ef*prob(ltr);  
            wd = floor( wd/5);
          end
         exp_5(k+1)=Ef; %wartoœæ oczekiwana dla slow 5-literowych
    end

    for k = 0:624 %Dla slow 4-literowych 
          Ef = no_wds;
          wd  = k;
          for l = 1:4
            ltr = mod(wd,5)+1;
            Ef = Ef*prob(ltr);  
            wd = floor( wd/5);
          end
         exp_4(k+1)=Ef; %wartoœæ oczekiwana dla slow 4-literowych
    end

    %% Chi-kwadrat
    for i = 1:3125
        Q5(i) = ((no_5(i) - exp_5(i))^2)/exp_5(i);
    end
    for i = 1:625
        Q4(i) = ((no_4(i) - exp_4(i))^2)/exp_4(i);
    end

    Q(j) = sum(Q5)-sum(Q4);
    
    z = (Q(j) - mean)/std;

    tmp = z/sqrt(2);
    tmp = 1+erf(tmp);
    Phi = tmp/2;
    mphi = 1-Phi;

    pValue(j) = mphi;
    clear slowa_5;
    clear slowa_4;
end

% cdf = makedist('uniform');
% [h,p] = kstest(pValue, cdf);
