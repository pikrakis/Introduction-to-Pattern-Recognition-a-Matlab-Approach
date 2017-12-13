function [editCost,Pred]=editDistance(refStr,testStr)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [editCost,Pred]=editDistance(refStr,testStr) 
% Computes the edit (Levenstein) distance between two strings (sequences of
% characters), where the first argument is the reference string (prototype). 
% The prototype is placed on the horizontal axis of the matching grid.
%
% INPUT ARGUMENTS:
%   refStr:         reference string.
%   testStr:        string to compare with prototype.
%
% OUTPUT ARGUMENTS:
%   editCost:       edit distance (matching cost).
%   Pred:           auxiliary matrix of node predecessors. The real part of
%                   Pred(j,i) is the row index of the  predecessor of node 
%                   (j,i) and the imaginary part of Pred(j,i) is the 
%                   column index of the predecessor of node (j,i). 
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

I=length(refStr);
J=length(testStr);
if I==0 | J==0
    editCost=inf;
    Pred=[];
    return;
end
D=zeros(J,I);

%Initialization
D(1,1)=~(refStr(1)==testStr(1));
Pred(1,1)=0;

for j=2:J
    D(j,1)=D(j-1,1)+1;
    Pred(j,1)=(j-1) + sqrt(-1)*1;
end

for i=2:I
    D(1,i)=D(1,i-1)+1;
    Pred(1,i)=1+ sqrt(-1)*(i-1);
end
%Main Loop
for i=2:I
    for j=2:J
        if refStr(i)==testStr(j)
            d(j,i)=0;
        else
            d(j,i)=1;
        end
        c1=D(j-1,i-1)+d(j,i); 
        c2=D(j,i-1)+1; 
        c3=D(j-1,i)+1;
        [D(j,i),ind]=min([c1 c2 c3]);
        if ind==1
            Pred(j,i)=(j-1)+sqrt(-1)*(i-1);
        elseif ind==2
            Pred(j,i)=j+sqrt(-1)*(i-1);
        else
            Pred(j,i)=(j-1)+sqrt(-1)*i;
        end
    end
end

editCost=D(J,I);

