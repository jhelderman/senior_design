function [ y ] = DelaySumBeamform( X, T, W )
%DELAYSUMBEAMFORM Calculate the weighted sum of delayed sensor signals
% Inputs: 
%   X - m x n matrix of m signals whose length is n
%   T - m length array of delays corresponding to the channels in X
%   W - m length array of weights corresponding to the channels in X
% Outputs:
%   y - n length array that is the output of the Delay-Sum Beamformer

Hz = @(z) repmat(W, 1, size(z,2)).*repmat(z,size(W,1),1).^repmat(-T,1,size(z,2));
Hw = @(w) Hz(exp(1i*w));
Xfilt = real(DiscreteSys(Hw, X));
y = sum(Xfilt, 1);
end

