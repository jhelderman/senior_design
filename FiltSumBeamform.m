function y = FiltSumBeamform(X, Hw)
Xfilt = real(DiscreteSys(Hw, X));
y = sum(Xfilt, 1);
end