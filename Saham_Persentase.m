%Hansel Matthew
%1806194914

%import data
load('Saham_Persentase');
begin = 117;
interval=500;
bound = begin+interval-1;

%Parameter
x1 = Data.BTPN(begin:bound); %Parameter1
x2 = Data.BLUE(begin:bound); %Parameter2
x3 = Data.BBCA(begin:bound); %Parameter3
x4 = Data.POOL(begin:bound); %Parameter4
x5 = Data.PNIN(begin:bound); %Parameter5
x6 = Data.TGKA(begin:bound); %Parameter6
x7 = Data.TPIA(begin:bound); %Parameter7
x8 = Data.TALF(begin:bound);%Parameter8
x9 = Data.TURI(begin:bound);%Parameter9
x10 = Data.TRIS(begin:bound);%Parameter10

%Normalisasi
Param = [x1 x2 x3 x4 x5 x6 x7 x8 x9 x10];
Normal = normr(Param);
a1 = Normal(:,1);
a2 = Normal(:,2);
a3 = Normal(:,3);
a4 = Normal(:,4);
a5 = Normal(:,5);
a6 = Normal(:,6);
a7 = Normal(:,7);
a8 = Normal(:,8);
a9 = Normal(:,9);
a10 = Normal(:,10);
saham = Data.TLKM(1:interval);

param1 = exp(-a3);
param2 = exp(-a3.^2.*a8);
param3 = exp(-a3.*a8);
param4 = exp(-a2);
param5 = exp(a8.^5);
param6 = log(exp(a4.*a2.*a5));
param7 = a3.^2.*a8;
param8 = a7.*a3;
param9 = -a5.*a2.*a1;
param10 = a2.*a2.*a4.*a4.*a5.*a6.*a7;

w = [param1 param2 param3 param4 param5 param6 param7 param8 param9 param10];

%Regresi Linear
reg = inv(w'*w)*w'*saham;
a= reg(1);
b= reg(2);
c= reg(3);
d= reg(4);
e= reg(5);
f= reg(6);
g= reg(7);
h= reg(8);
i= reg(9);
j= reg(10);

y_pred = a*param1 + b*param2 + c*param3 + d*param4 + e*param5 + f*param6 + g*param7 + h*param8 + i*param9 + j*param10; 


%Plotting
n=(1:interval);
n = n';
scatter(n,saham);
hold on;
plot (n,y_pred);

%Cek SSE
sse = 0;
for i = 1:n
    sse = sse + (y_pred(i)-saham(i)).^2;
end
%Nilai SSE disimpan dalam variabel 'sse'

%Cek Korelasi
korelasi = corrcoef(y_pred,saham);
hasil = korelasi(2);
%Hasil korelasi disimpan dalam variabel 'Hasil'

disp('Korelasi model 1');
disp(hasil);
disp('Nilai sse model 1')
disp(sse);

% %Menggunakan fungsi Predict Matlab
% mdl = fitlm(Param,saham,'quadratic');
% ypred = predict (mdl,Param);
% pred = corr(ypred,saham);
% 
% 
% %SSE fungsi Predict Matlab
% ssepred = 0;
% for i = 1:n
%     ssepred = ssepred + (ypred(i)-saham(i)).^2;
% end
% 
% disp('Korelasi model 2:');
% disp(pred);
% disp('Nilai sse model 2:');
% disp(ssepred);
