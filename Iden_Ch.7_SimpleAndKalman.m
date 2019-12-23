%% comparison the simple and Kalman
% the Riccati equation of the discrete version
clear all; clc
R0 = 1;  % state noise variance
N = 10;  % the number of measurements

for i = 1:N  
    R(i) = R0;   % noise intensity is constant
end

Sim_P(1) = 1;  % the simple error variance
for i = 2:N    
    %temp = 1/i^2 *R(i);
    Sim_P(i) = ((i-1)/i)^2 *Sim_P(i-1)*R(i)+ (1/i)^2 * R(i);
end

plot(1:N,Sim_P)

% Kalman filter 
P(1) = R(1);    %the initial error variance 
for i = 2:N
    K(i) = P(i-1)/(P(i-1) +R(i)); 
    P(i)  = (1 - K(i))^2 * P(i-1) + K(i)^2 * R(i);  
end
plot(1:N,Sim_P,'b', 1:N,P,'r'); grid on
title('the variances of the simple and kalman gain')

%% noise variance is time varying
clear all; clc

N = 10;  % the number of measurements

for i =1:N
   if  mode(i) == 1;  % i is odd, the noise variance is 1
       R(i) = 1;
   else           
       R(i) = 2;           % i is even, the noise variance is 2
   end 
end 

% for simple variance 
Sim_P(1) = R(1);  % the simple error variance
for i = 2:N    
    %temp = 1/i^2 *R(i);
    Sim_P(i) = ((i-1)/i)^2 *Sim_P(i-1)*R(i)+ (1/i)^2 * R(i);
end

% for kalman variance 
P(1) = R(1);
for i = 2:N
    Sim_P(i) = 1/i *R(i); 
    K(i) = P(i-1)/(P(i-1) +R(i)); 
    P(i)  = (1 - K(i))^2 * P(i-1) + K(i)^2 * R(i);  
end
plot(1:N,Sim_P,'b',1:N,P,'r'); grid on
title('the variance: the simple one(blue), the kalman(red)')

%%  we do not know the intensity of noise, just guess, in this example the kalman is still better

% fro kalman variance 
TempR(1:N) = 5*R;
P(1) = TempR(1);
for i = 2:N
    Sim_P(i) = 1/i *TempR(i); 
    K(i) = P(i-1)/(P(i-1) +TempR(i)); 
    P(i)  = (1 - K(i))^2 * P(i-1) + K(i)^2 *TempR(i);  
end
plot(1:N,Sim_P,'b',1:N,P,'r'); grid on
title('the variance: the simple one(blue), the kalman(red)')





