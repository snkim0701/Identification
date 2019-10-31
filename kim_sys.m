

%% ex.2.2 system response method
% (1/k) (dy/dt) + y = u
%state space model
% x = y, --> (dx)/(dt) = -kx + u , y = kx + u
% parameters
clear all
clf
K=0.8;
A= -K;B=1;C=K;D=0;

% sate- space model 
sys1 =ss(A,B,C,D);

% transfer function model
num = [K]; den=[K 1];

sy2= tf(num,den);

% ss to tf
[b,a]=ss2tf(A,B,C,D) 

% tf to ss
[A,B,C,D] = tf2ss(b,a)

% impulse response
%t = linspace(0,10,10);
t=0:0.1:10;
g = impulse(sys1,t);

plot(t,g,'b')   %plot
hold on
grid on
%axis([-1 11 -1 1.2])
%%  step response
y=step(sys1,t) ;
plot( t,y,'b--')  % plot

% estimate impulse rsponse using step input
initial =0;
yd = diff(y);
yd_scale =g(1)/yd(1)*yd + initial;
plot(t(1:100),yd_scale,'r+')  %plot
%axis([0 10 0 1])
legend('impulse response ','step response','differential of step response')
%% rising time = (1/e)*steady state value 

%t = 0 : 0.01 :200;         
%u=pulstran(t,d,@rectpuls,30)';
[u,t]=gensig('square',50,200,1);
figure(2)
plot(t,u); hold on
title('pulse train with the period = 50, sampling time = 0.1')
%axis([0 0.001 0 1.5])

%figure(3)
ylsim=lsim(sys1,u,t);
plot(t,ylsim,'r--'); grid on
title('the output of the pulse train')

