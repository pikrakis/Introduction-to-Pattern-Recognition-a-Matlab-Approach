function [Zcr,T]=stZeroCrossingRate(x,Fs,winlength,winstep)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [Zcr,T]=stZeroCrossingRate(x,Fs,winlength,winstep)
% Computes the short-term zero-crossing rate of a signal. This is an
% auxiliary function.
%
% INPUT ARGUMENTS:
%   x:              signal (sequence of samples).
%   Fs:             sampling frequency (Hz).
%   winlength:      length of the moving window (number of samples).
%   winstep:        step of the moving window (number of samples).
%
% OUTPUT ARGUMENTS:
%   Zcr:            zero-crossing rate (sequence of values).
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
    Zcr(i)=0;
    for k=2:winlength
        if y(k)>=0 & y(k-1)<0
            Zcr(i)=Zcr(i)+1;
        elseif y(k)<0 & y(k-1)>=0
            Zcr(i)=Zcr(i)+1;
        end
    end
    Zcr(i)=Zcr(i)/winlength;
    T(i)=(m-1)*(1/Fs);
    i=i+1;
    m=m+winstep;    
end
