v = VideoReader('film2.mp4'); % Wczytywanie filmu
p=0;
i=1; %Pierwsza czytana klatka
j=47125; %%Liczba klatek filmu
while i<2
    %% Zczytywanie bitów z klatek filmu
    video = read(v, i);
    i = i+150;
    TEMP1 = dec2bin(video);
    
    %% Pierwsza funkcja hashujaca
    TEMP2 = everyOther1(TEMP1);
    TEMP2 = TEMP2 - '0';
    TEMP2  = not(TEMP2);
    TEMP2 = num2str(TEMP2);

    fid = fopen('test.txt','w');
    fprintf(fid,'%c%c%c%c%c%c%c%c',TEMP2');
    fclose(fid);
    TEMP2 = md5('test.txt');
    TEMP2 = reshape(TEMP2, 2, []).';
    TEMP2 = hex2dec(TEMP2);


    %% Druga funkcja hashujaca
    TEMP3 = everyOther2(TEMP1);
    TEMP3 = TEMP3 - '0';
    TEMP3  = not(TEMP3); 
    TEMP3 = num2str(TEMP3);
    TEMP3 = sha256(TEMP3);
    %% Podzia³ wyniku SHA-2 na 2 bloki
    TEMP4 = TEMP3(1:32);
    TEMP5 = TEMP3(33:64);

    TEMP4 = reshape(TEMP4, 2, []).';
    TEMP5 = reshape(TEMP5, 2, []).';
    TEMP4 = hex2dec(TEMP4);
    TEMP5 = hex2dec(TEMP5);

    %% Operacje XOR
    TEMP6 = bitxor(TEMP2, TEMP4);
    TEMP7 = bitxor(TEMP2, TEMP5);

    TEMP6 = dec2hex(TEMP6);
    TEMP7 = dec2hex(TEMP7);

    %% 32 liczby losowe
    TEMP8 = [TEMP6, TEMP7];
    TEMP8 = reshape(TEMP8, 2, [] ).';


    %Zamiana na dziesietne
    TEMP9 = hex2dec(TEMP8)
    
    %% Pêtla tworz¹ca macierz wynikow¹
    if p == 0
        p = 1;
        WYNIK = TEMP9;
    else
        WYNIK = [WYNIK, TEMP9]
    end
end
%% Wyrysowanie histogramu

 histogram(WYNIK, 256, 'normalization','probability')
xlabel('Wartoœæ (x)')
ylabel('Czêstoœæ Wystêpowania (pi)')
title('Empiryczny rozk³ad zmiennych losowych')

%  histogram(video, 256, 'normalization','probability')
% xlabel('Wartoœæ (x)')
% ylabel('Czêstoœæ Wystêpowania (pi)')
% title('Rozk³ad zmiennych losowych generowanych przez Ÿród³o')

%% Wyliczenie entropii

e_wynik = entropia(WYNIK)
e_video = entropia(video)
 
function y = everyOther1(x)
  y = x(1:150:length(x));
end
function y = everyOther2(x)
  y = x(1:250:length(x));
end