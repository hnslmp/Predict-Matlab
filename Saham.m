%Hansel Matthew
%1806194914

%import data
load('data2')
bound = 500;

%Parameter
x1 = Data.Unilever(1:bound); %Parameter1
x2 = Data.Telkom(1:bound); %Parameter2
x3 = Data.BSD(1:bound); %Parameter3
x4 = Data.Garuda(1:bound); %Parameter4
x5 = Data.Elnusa(1:bound); %Parameter5
x6 = Data.SentulCity(1:bound); %Parameter6
x7 = Data.ElectronicCity(1:bound); %Parameter7
x8 = Data.AlamSutera(1:bound);%Parameter8
x9 = Data.Astra(1:bound);%Parameter9
x10 = Data.BCA(1:bound);%Parameter10

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
saham = Data.Smartfren(1:bound);
w = [exp(-a1) exp(-a2.^2) exp(-a3) exp(-a4) a4.^2 log(exp(a3.*a2.*a5)) a2.^2.*a8 a1.*a3 exp(-a5.*a2) a5.*a3.*a1.*a7.*a8 exp(-a6.*a7) a6 a7.*a8.*a2 a8.^2 a2 a3.*a2 ones(length(a1),1) exp(-a7) exp(-a8) exp(-a9) exp(-a10) log(a1)];

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
k= reg(11);
l= reg(12);
m= reg(13);
n= reg(14);
o= reg(15);
p= reg(16);
q= reg(17);
r= reg(18);
s= reg(19);
t= reg(20);
u= reg(21);
v= reg(22);

y_pred = a*exp(-a1) + b*exp(-a2.^2) + c*exp(-a3) + d*exp(-a4) + e*a4.^2 + f*log(exp(a3.*a2.*a5)) + g*a2.^2.*a8 + h*a1.*a3 + i*exp(-a5.*a2) + j*a5.*a3.*a1.*a7.*a8 + k*exp(-a6.*a7) + l*a6 + m*a7.*a8.*a2 + n*a8.^2 + o*a2 + p*a3.*a2 + q + r*exp(-a7) + s*exp(-a8) + t*(-a9) + u*(-a10) + v*log(a1);


%Plotting
n=(1:bound);
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
