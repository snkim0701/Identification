

%% generate system  FIR model
% Y(z)  = B(z)U(z) + e

clear all;  clc; clf 

% define a discrete system
%y(t) =  u(t-1) + 0.5u(t-2)
A = [1];
B = [0  1 0.5];  
sys0 = idpoly(A,B)  % original system
                                 % check the sys0 with the original y(t)

% generate input and noise
u = iddata([ ],idinput(300,'rbs'));
%t = 0:1:299;
%input = sin(2*pi*0.1*t);
%u = iddata([ ],input');
e = iddata([ ],randn(300,1));

% generate output
y = sim(sys0,[u e]);

% for regressor matix, 
z = [y,u];
figure(1)
idplot(z); grid on

% LSE 
sys = arx(z,[0 2 1])    % estimate system

% compare the real output with the output of the LSE system
ye =sim(sys,[u e]);
figure(2)
plot(y,'b');grid on;  hold on
plot(ye,'r');
title('FIR sytem : real output(blue) with LSE output(red)')
hold off


%% generate system  ARX model
% A(z)Y(z) = B(z)U(z) + e
clear all;  clc;

% define a discrete system
%y(t) = 1.5y(t-1) - 0.7y(t-2) + u(t-1) + 0.5u(t-2)
A = [1  -1.5  0.7];
B = [0 1 0.5];
sys0 = idpoly(A,B);

% generate input and noise
% input = random bianary sequence
u= iddata([ ],idinput(300,'rbs'));
e = iddata([ ],randn(300,1));

% input = sin wave
% t = 0:0.1:29.9;
% input = sin(2*pi*t);
% u = iddata([ ],input',0.1);
% e = iddata([ ],randn(300,1),0.1);

% generate output
y = sim(sys0,[u e]);

% for regressor matix, 
z = [y,u];
figure(3)
idplot(z); grid on

% LSE 
sys = arx(z,[2 2 1])

% compare the real output with the output of the LSE system
ye =sim(sys,[u e]);
figure(4)
plot(y,'b');grid on;  hold on
plot(ye,'r');
title('ARX system : real output(blue) with LSE output(red)')
hold off




%% generate system  ARMAX model
% A(z)Y(z) = B(z)U(z) + C(Z)E(z)
clear all;  clc

% define a discrete system
%y(t) = 1.5y(t-1) - 0.7y(t-2) + u(t-1) + 0.5u(t-2) + e(t) + 0.5e(t-1)
A = [1  -1.5  0.7];
B = [0 1 0.5];
C = [1 0.5]
sys0 = idpoly(A,B,C)

%
% generate input and noise
% input = random bianary sequence
u= iddata([ ],idinput(300,'rbs'));
e = iddata([ ],randn(300,1));

% input = sin wave
% t = 0:0.1:29.9;
% input = sin(2*pi*t);
% u = iddata([ ],input',0.1);
% e = iddata([ ],randn(300,1),0.1);

% generate output
y = sim(sys0,[u e]);

% for regressor matix, 
z = [y,u];
figure(5)
idplot(z); grid on

% LSE 
sys = armax(z,[2 2 1 1])

% compare the real output with the output of the LSE system
ye =sim(sys,[u e]);
figure(6)
plot(y,'b');grid on;  hold on
plot(ye,'r');
title('ARMAX system : real output(blue) with LSE output(red)')
hold off
