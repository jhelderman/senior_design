function T = CalcNatDelay(nSensors,d,theta,c)
N = (1:nSensors)';
T = (N - 1)*d*cos(theta)/c;
end