%% example 5.3
t = 0:0.2:1.0;
y=[3 59 98 151 218 264]';
plot(t,y,'o'); grid on

%% generate regressor Phi matrix
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
est = inv((Phi')*(Phi)) *((Phi)' *y);
error = y - Phi*est;
plot(t,y,'bO', t, Phi*est,'r+'); grid on

%% check the estimator
% unbiased estimator if Phi is fixed.
Bias = sum(error);
% calculate the sampe variance , N = 6, p= 3
sampleVariance = (error'*error) /(6-3) ;  %
% covariance of estimator 
covEst = sampleVariance*inv(Phi'*Phi);

% the standard deviation of estimator is
sqrt(diag(covEst))  % standard deviation of estimator [xo vo ao]
est
%in conclusion ; comparing the std of estimator and the value of estimator,
%the velocity vo is estimated accurately compared to initial position and
%acceleration 
%%
diag([1 2;3 4])
%% mean of the least squre estimator
Phi' *(y - Phi*est)

