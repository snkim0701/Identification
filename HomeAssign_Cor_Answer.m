

%% Home assignment 
% application of correlation - delay time 

% condition
clear all;clc;clf
fs = 2*10^4 ;  % [Hz]
tduration = 10/fs ; % the duration time of sending signal 
vel = 340;  % acoustic speed [m/s]
dis_min = 1; % minimum detectable distance
distance = 25; % the distance between the car and the object

% calculate the delay time
tdelay = 2*distance / vel ; % time delay

% determine the sampling time 
tsamp =1/(fs*20);

%
tstart = 0;
tstop = 1;
% plot send and received signal;
t =tstart:tsamp:tstop;
t_send = tstart:tsamp:tduration;
t_zero  = tduration+tsamp:tsamp:tstop;
t=[t_send t_zero];
% sens signal 
sig = sin(2*pi*fs.*t_send);
send = [sig   zeros(1,size(t_zero,2)) ];

% received signal : we do not assume the signal ttenuation due to the traveling distance
n=floor(tdelay/tsamp);    % the number of sampling time in time delay
rec =[zeros(1,n)  send(1:end -n)];

% plotting the send and the received signals

figure(1)
subplot(3,1,1)
plot(t,send,'b',t,rec,'r');grid on
axis([-0.1 1 -1.5 1.5])

subplot(3,1,2)
[xc, lags] = xcorr(rec,send);
plot(lags,xc); grid on
%
N = (size(lags,2)-1)/2;
subplot(3,1,3)
plot(xc(N:2*N)); grid on
[M,I] = max(xc(N:2*N));
tdelay_est = I*tsamp;
distance_est = vel*tdelay/2
fprintf('this is the estimated distance %4.2f  by the  correlation method. \n ', distance_est)



