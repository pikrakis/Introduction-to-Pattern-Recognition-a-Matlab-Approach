function [E,T]=stEnergy(x,Fs,winlength,winstep)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [E,T]=stEnergy(x,Fs,winlength,winstep)
% Computes the short-term energy envelop of a signal. This is an
% auxiliary function.
%
% INPUT ARGUMENTS:
%   x:              signal (sequence of samples).
%   Fs:             sampling frequency (Hz).
%   winlength:      length of the moving window (number of samples).
%   winstep:        step of the moving window (number of samples).
%
% OUTPUT ARGUMENTS:
%   E:              sequence of short-term energy values.
%   T:              time equivalent of the first sample of each window.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if nargin<4
    return;
end

x=x-mean(x);
i=1;
N=length(x);
m=1;
while (m+winlength-1<=N)
    y=x(m:m+winlength-1);
    E(i)=(1/winlength)*sum(y.^2);
    T(i)=(m-1)*(1/Fs);
    i=i+1;
    m=m+winstep;
end
E=E/max(E);
