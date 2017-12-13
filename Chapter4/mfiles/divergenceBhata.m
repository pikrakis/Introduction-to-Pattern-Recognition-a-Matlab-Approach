function [D]=divergenceBhata(c1,c2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [D]=divergenceBhata(c1,c2)
% Computes the Bhattacharyya distance between two classes.
%
% INPUT ARGUMENTS:
%   c1:     data of the first class, one pattern per column.
%   c2:     data of the second class, one pattern per column.
%
% OUTPUT ARGUMENTS:
%   D:      Bhattacharyya distance.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

c1=c1';c2=c2';
Covx=cov(c1);
Covy=cov(c2);
mx=mean(c1,1);
my=mean(c2,1);
a1=det((Covx+Covy)/2);
a2=sqrt(det(Covx)*det(Covy));
D1=0.5*log(a1/a2);

a1=(mx-my);
a2=inv((Covx+Covy)/2);
a3=(mx-my)';
D2=(a1*a2*a3)/8;
D=D1+D2;
D=D/size(c1,2);

