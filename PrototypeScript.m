clc; clear; close all;

%% parameters
f = 106.8; % tone frequency
A = 1; % tone amplitude
theta = 179*pi/180; % source direction
nSensors = 2; % # of sensors in the ULA
d = 0.8; % distance between ULA element
c = 340.29; % speed of sound in air
lam = c/f; % wavelength
N = 1024; % # of samples
Fs = f*50; % sampling frequency (set so high so that data is easier to read)
tEnd = N/Fs; % simulation end time
% phi = 50*pi/180; % angle of sensitivity
phi = 0;

%% generate signal
t = linspace(0,tEnd,N);
X = sin(2*pi*f*t);

%% delay the signal
Tau = 25.5;
Y = DelaySignal(X,Tau);

%% plot results
figure; plot(t,X);
hold on;
plot(t,Y,'g');
hold  off;