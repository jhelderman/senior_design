clc; clear; close all;

%% parameters
f = 213.1; % tone frequency
tonePrecision = 1;
toneP = 10^tonePrecision;
A = 1; % tone amplitude
% theta = 0; % source direction
theta = linspace(-pi,pi,100); % source direction
nSensors = 16; % # of sensors in the ULA
d = 0.0156; % distance between ULA elements
c = 340.29; % speed of sound in air
lam = c/f; % wavelength
N = 1024; % # of samples
Fs = f*50; % sampling frequency (set so high so that data is easier to read)
tEnd = N/Fs; % simulation end time
% phi = 50*pi/180; % angle of sensitivity
phi = 0;

%% calculate weights
Wts = DSBFWeights(nSensors); % weights

%% calculate delays
Tau = DSBFDelays(nSensors,d,phi,c);
% Tau = [0;0.5];

%% calculate output for all theta values
% outMag = zeros(1,length(theta));
% for n = 1:size(theta,2)
%   %% generate signal
%   t = linspace(0,tEnd,N);
%   X = sin(2*pi*f*t);
%   % X = repmat(X,nSensors,1);
%   X = DelaySignal(X, Fs*CalcNatDelay(nSensors,d,theta(n),c));
% 
%   %% beamforming calculation
%   y = DelaySumBeamform(X,round(Fs*Tau),Wts);
%   
%   %% calculate signal amplitude
%   outMag(n) = max(y(floor(end/2):end));
% 
% end

%% plot results
% figure; plot(repmat(t,size(X,1),1)',X');
% 
% figure; plot(t,y);
% 
% figure; plot(180/pi*theta,outMag);

%% calculate directivity pattern
F = logspace(0,5,2e3);
theta = linspace(-pi,pi,2e3);
DirPat = DSSpecDir(F,theta,phi,d,nSensors,c);

%% plot the directivity pattern
figure; plot(180/pi*theta,abs(DirPat(:,round(toneP*F)/toneP == f)));
figure;
hDir = surf(F,180/pi*theta,abs(DirPat));
set(get(hDir,'Parent'),'XScale','log');
set(hDir,'LineStyle','none');
view([0,90]);
xlabel('Frequency(Hz)'); ylabel('Source Angle (degrees)'); zlabel('Magnitude');
colorbar;