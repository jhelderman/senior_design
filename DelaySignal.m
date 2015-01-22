function X = DelaySignal(x,T)
%% round the delay 
digitsOfPrecision = 3;
p = 10^digitsOfPrecision;
T = round(T*p);

%% resample at the higher rate
xBuf = x;
x = zeros(size(x).*[1,p]);
for n = 1:size(x,1)
  x(n,:) = resample(xBuf(n,:),p,1);
end

%% delay the signal
nSigs = size(T,1);
if size(x,1) == 1
  x = repmat(x,nSigs,1);
end
% nPts = size(x,2);
Hz = @(z) repmat(z,nSigs,1).^repmat(T,1,size(z,2));
Hw = @(w) Hz(exp(1i*w));
% H = @(w) exp(1i*repmat(w,nSigs,1).*repmat(T,1,nPts));
X = real(DiscreteSys(Hw,x));

%% reduce the sampling rate to its original value
xBuf = X;
X = zeros(size(X).*[1,1/p]);
for n = 1:size(X,1)
  X(n,:) = resample(xBuf(n,:),1,p);
end
end