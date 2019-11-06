% example 3.2  ETFE 
% data = iddata(output, input, sampling time) , output, input shoud be
% column vectors.
clear all
clc; clf

ts =1;
u = [0 1 0 0 1 1 0 0 0 1 1 1 0 0 0 0]';   % input :  " ' " means transpose. column vector
y = [4.5 0 87.53 11.56 5.5 89.3 97.76 8.47 5.01 0 87.65 101.09 103.97 15.88 0 0]';  % output 
data = iddata(y*0.01,u,ts);
plot(data); grid on

ge = etfe(data);
%gs = spa(data);  % for reference https://www.mathworks.com/help/ident/ref/etfe.html
bode(ge); grid on

%% verification of sysyem defined
K= 0.5;
num = [K]; den=[K 1];
sy2= tf(num,den);
figure(2)
bode(sy2); grid on

%% input generated as Ex. 3.2 
ts=1;
t =0:ts:15;
u = [0 1 0 0 1 1 0 0 0 1 1 1 0 0 0 0]';   % input :  " ' " means transpose. column vector
y = lsim(sy2,u,t);
plot(t,y,'b', t,u,'r'); grid on
%% for identification function in matlab provided iddata
data = iddata(y,u,ts); 

ge=etfe(data); % matlab analyze the in / out data for an estimate of transfer function
figure(3)
bode(ge,'b',sy2,'r');grid on;

%%  using  random binary sequence, as RBS in ch.4
N=2000;
urbs=idinput(N);  % random binary sequence
ts = 0.1;
t=0:ts:199.9;
yrbs=lsim(sy2,urbs,t);
data1 =iddata(yrbs,urbs,ts);

ge = etfe(data1);
%gs = spa(data);  % for reference https://www.mathworks.com/help/ident/ref/etfe.html
figure(4)
bode(sy2,'b',ge,'r'); grid on

%%%compare the resluts with different inputs.

