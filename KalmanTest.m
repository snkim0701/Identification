
%% Matlab_Good_lecture
%
%  To run this program, you need  and save 3 files independently
%
%  -predict.m
%  -innovation.m
%  -nnovation_update.m
%
%  I attached end of this subsection.

clear all; 
clc;

% real data
N  = 100;
delT = 1; 
y(1) = 10;   % initial position

for i = 1:N
    Vel(i) = 10;
end


for i = 2:N
    if i < N/2
        Vel(i) = 5;
    else
        Vel(i)=50;
    end
    y(i) = y(i-1) + delT*Vel(i);
end



figure(1)
plot(1:N,y,'b'); grid on

% define model

F = [ 1 delT; 0 1];
H = [ 1 0];
G = [1 0;0 1];

% Initial Data
x = [ 0 ;100];  % assme mean  initial = 0, initial velocity = 100;
P = [ 10  0 ; 0 10];  % assume initial variance = M
Q = [1 1;1 1]; % state noise intensity
R = [ 1]; % measurement  noise intensity

% recursive filter
for i = 1:N    
    [xpred,Ppred]= predict(x,P,F,Q,G);   
    xpredSave(i) = xpred(2);  % prediction velocity 
    z(i) = y(i); % measurement
    [nu,S]=innovation(xpred,Ppred,z(i),H,R);    
    [x ,P] = innovation_update(xpred,Ppred,nu,S,H);  
    xCorrSave(i) = x(2);  % correction velocity = estimation velocity
    %plot(1:5,xNSave,'r+');
end

 plot(1:N, Vel, 'b',1:N,xCorrSave,'r',1:N,xpredSave,'k'); grid on
title('real velocity (blue), estimation velocity(red), prediction,velocity(black)')


%% kalman example
% input =  (x,P,F,Q,G) 
%   x(k+1) = Fx(k) 
% prediction : xpred :  mean of prediction of state
%                     Ppred : variance of prediction state
function [xpred, Ppred] = predict(x,P,F,Q,G)
 xpred = F*x;
 Ppred = F*P*F' + G*Q*G';
end


%%
function [nu,S] = innovation(xpred,Ppred,z,H,R)
nu = z - H*xpred;
S = R+ H*Ppred*H';
end


%%
function [xnew,Pnew] = innovation_update (xpred, Ppred,nu,S,H)
K = Ppred*H'*inv(S);
xnew = xpred + K*nu;
Pnew = Ppred - K*S*K';
end