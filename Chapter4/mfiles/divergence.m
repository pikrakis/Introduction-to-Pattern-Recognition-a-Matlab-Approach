function [D]=divergence(c1,c2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [D]=divergence(c1,c2)
% Computes the divergence between two classes.
%
% INPUT ARGUMENTS:
%   c1:     data of the first class, one pattern per column.
%   c2:     data of the second class, one pattern per column.
%
% OUTPUT ARGUMENTS:
%   D:      value of divergence.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

c1=c1';c2=c2';
Covx=cov(c1);
Covy=cov(c2);
iCovx=inv(Covx);
iCovy=inv(Covy);
m1=mean(c1,1);
m2=mean(c2,1);
D1=0.5*trace((iCovx*Covy)+ (iCovy*Covx)-2);
a1=(m1-m2);
a2=(iCovx+iCovy);
a3=(m1-m2)';
D2=0.5*( a1*a2*a3 );
D=D1+D2;
D=D/size(c1,2);

