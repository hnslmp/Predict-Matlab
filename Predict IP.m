%Hansel Matthew
%1806194914

%import data
load('survey')

%Parameter
x1 = Survei.Tidur; %Parameter1
x2 = Survei.SKS; %Parameter2
x3 = Survei.Umur; %Parameter3
x4 = Survei.Belajar; %Parameter4
x5 = Survei.Saudara; %Parameter5
x6 = Survei.Berat; %Parameter6
x7 = Survei.Tinggi; %Parameter7

%Normalisasi
Param = [x1 x2 x3 x4 x5 x6 x7];
Normal = normr(Param);
a1 = Normal(:,1);
a2 = Normal(:,2);
a3 = Normal(:,3);
a4 = Normal(:,4);
a5 = Normal(:,5);
a6 = Normal(:,6);
a7 = Normal(:,7);

ip = Survei.IP;
w = [exp(-a1) exp(-a2) exp(-a3) exp(-a4) a4 a3 a2 a1 exp(-a5) a5 exp(-a6) a6 exp(-a7) a7 exp(-a3.*a2) a3.*a5 a3.*a7 a4.*a5 a5.*a6.*a7 a3.*a4.*a5.*a7 a2.*a6.*a4 a7.*a3.*a5  (a4.*a1.*a6).^3 (a4.*a3).^8 ones(length(a1),1)];

%Regresi Linear
reg = inv(w'*w)*w'*ip;
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
w= reg(23);
y= reg(24);
z= reg(25);

y_pred = a*exp(-a1) + b*exp(-a2) + c*exp(-a3) + d*exp(-a4) + e*a4 + f*a3 + g*a2 + h*a1 + i*exp(-a5) + j*a5 + k*exp(-a6) + l*a6 + m*exp(-a7) + n*a7 + o*exp(-a3.*a2) + p*a3.*a5 + q*a3.*a7 + r*a4.*a5 + s*a5.*a6.*a7 + t*a3.*a4.*a5.*a7 + u*a2.*a6.*a4 + v*a7.*a3.*a5 + w*(a4.*a1.*a6).^3 + y*(a4.*a3).^8 + z;

%Plotting
n=(1:101);
% n = n';
% scatter(n,y);
% hold on;
% plot (n,y_pred);

%Cek SSE
sse = 0;
for i = 1:n
    sse = sse + (y_pred(i)-ip(i)).^2;
end
%Nilai SSE disimpan dalam variabel 'sse'

%Cek Korelasi
korelasi = corrcoef(y_pred,ip);
hasil = korelasi(2);
%Hasil korelasi disimpan dalam variabel 'Hasil'

disp('Korelasi model 1');
disp(hasil);
disp('Nilai sse model 1')
disp(sse);

%Menggunakan fungsi Predict Matlab
mdl = fitlm(Param,ip,'quadratic');
ypred = predict (mdl,Param);
pred = corr(ypred,ip);


%SSE fungsi Predict Matlab
ssepred = 0;
for i = 1:n
    ssepred = ssepred + (ypred(i)-ip(i)).^2;
end

disp('Korelasi model 2:');
disp(pred);
disp('Nilai sse model 2:');
disp(ssepred);
