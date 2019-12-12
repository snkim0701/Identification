%%  example 5.3
disp('Example 5.3 ')
disp(' ')
t = 0:0.2:1.0;
y=[3 59 98 151 218 264]';
plot(t,y,'o'); grid on
title ('the measured data')
% generate regressor Phi matrix
% model y = xo + vo*t + 1/2 ao**t = [1 t 1/2t**2 ] * [ xo  vo  ao] + v 
% 
Phi = [ ];
for i =1:size(t,2)     
    temp = [1 ; t(i) ; (1/2)*t(i)^2];
    Phi = [Phi temp];
end

% check the value with  the textbook at page 64
Phi=Phi';            
inv((Phi')*(Phi)); 
(Phi)' *y ; 
est = inv((Phi')*(Phi)) *((Phi)' *y); % Least Square estimator
disp('Least Square Estimator for [ x0 v0 a0]')
disp(est)

% the prediction error 
error = y - Phi*est;
disp('the prediction error = y- Phi*LSE')
disp(error)
plot(t,y,'bO', t, Phi*est,'r+'); grid on
title(' comparison between the meaured and the predicted')

% check the preformance of the predicted   error
meanError = sum(error)/(size(error,1));
disp('the mean of the prediction  error')
disp(meanError)

meanSquareError = sqrt(error'*error/(size(error,1)-3));
disp('the mean square root of the prediction error')
disp(meanSquareError)


%%  example 5.8
disp(' Example 5.3. The model is the same as the  the real system ')
disp(' Example 5.8. The model is different form  the real system ')
disp(' In this example, only the regressor Phi is changed from Example 5.3')
disp(' ')
t = 0:0.2:1.0;
y=[3 59 98 151 218 264]';
plot(t,y,'o'); grid on
title ('the measured data')
% generate regressor Phi matrix
% model y =  vo*t + 1/2 ao**t = [ t 1/2t**2 ] * [  vo  ao] + v 
% 
Phi = [ ];
for i =1:size(t,2)     
    temp = [ t(i) ; (1/2)*t(i)^2];
    Phi = [Phi temp];
end

% check the value with  the textbook at page 71
Phi=Phi';            
inv((Phi')*(Phi)); 
(Phi)' *y ; 
est = inv((Phi')*(Phi)) *((Phi)' *y); % Least Square estimator
disp('Least Square Estimator for [ v0 a0]')
disp(est)

% the prediction error 
error = y - Phi*est;
disp('the prediction error = y- Phi*LSE')
disp(error)
plot(t,y,'bO', t, Phi*est,'r+'); grid on
title(' comparison between the meaured and the predicted')

% check the preformance of the predicted   error
meanError = sum(error)/(size(error,1));
disp('the mean of the prediction  error')
disp(meanError)
disp('The  mean of the prredicted error is not zero. if the model is different from the real system')
disp('the bias of LSE is not zero, Hence to get unbiased LSE,you should check the model. ')


disp(' ')
meanSquareError = sqrt(error'*error/(size(error,1)-3));
disp('the mean square root of the prediction error')
disp(meanSquareError)



%% Accuracy of Example 5.11 the standard deviation = the square root of the variance.
% This is the same program to the Example 5.3, in addition to analysis of
% the accuracy

disp('Example 5.11 ')
disp(' ')
t = 0:0.2:1.0;
y=[3 59 98 151 218 264]';
plot(t,y,'o'); grid on
title ('the measured data')
% generate regressor Phi matrix
% model y = xo + vo*t + 1/2 ao**t = [1 t 1/2t**2 ] * [ xo  vo  ao] + v 
% 
Phi = [ ];
for i =1:size(t,2)     
    temp = [1 ; t(i) ; (1/2)*t(i)^2];
    Phi = [Phi temp];
end

% check the value with  the textbook at page 64
Phi=Phi';            
inv((Phi')*(Phi)); 
(Phi)' *y ; 
est = inv((Phi')*(Phi)) *((Phi)' *y); % Least Square estimator
disp('Least Square Estimator for [ x0 v0 a0]')
disp(est)

% the prediction error 
error = y - Phi*est;
disp('the prediction error = y- Phi*LSE')
disp(error)
plot(t,y,'bO', t, Phi*est,'r+'); grid on
title(' comparison between the meaured and the predicted')

% check the preformance of the predicted   error
meanError = sum(error)/(size(error,1));
disp('the mean of the prediction  error')
disp(meanError)

meanSquareError = sqrt(error'*error/(size(error,1)-3));
disp('the mean square root of the prediction error')
disp(meanSquareError)

%
% The variance of LSE is equal to (noise variance) * Phi' * Phi
% We do not know the noise variance, instead of it , we may approximated
% the sample mean variance which is calculated in Example 5.3 as meanSquare
% Error

sampleMeanVariance  = meanSquareError^2;
disp('the sample mean variance')
disp(sampleMeanVariance)

% the variance of LSE is 
CoV = sampleMeanVariance * inv(Phi'*Phi);
disp('the mean square root of the prediction error')
disp(meanSquareError)


StandardDeviation = diag(sqrt(CoV));
disp('the standard deviation of LSE of [x0, v0, a0]')
disp(StandardDeviation)

%confidence check of LSE corresponding to one standard deviation
%(one sigma)
disp('1 sigma deviation of LSE')
100*( 1-(est - StandardDeviation) ./est ) % percentage deviation 
disp('  only the velocity estimator is accurately estimated, the others are very low accuracy') 

%% Example 5.12 Two unbiased estimator  but different square error 
% y = x + e
% E(e)  = 0, Var(e)  = [ 1 4 1 4];
clear all; clc; clf
disp('Example 5.11 ')
y = [ 1 2 3 4];  % a test measurement
VarE = [ 1 4 1 4]; % measurement error variance
disp('the measurement y is')
disp(y)

%simple average estimator is 

AveEst = sum(y)/size(y,2)  % the simple average estimator
disp('the measurement error "e" has mean zero')
disp('then error of the predict is the sample mean')
Error = y - AveEst;
MeanError= sum(y - AveEst)/size(y,2)
disp('which is an unbiased estimator')
disp(' ')
% the square error of the simple estimator
% since we know the variance of measurement error, we use it, 
% the number of measurement data = size(y,2)
VarError = sum((1/size(y,2))^2 .* VarE);
disp('least square error is') 
disp(VarError)
