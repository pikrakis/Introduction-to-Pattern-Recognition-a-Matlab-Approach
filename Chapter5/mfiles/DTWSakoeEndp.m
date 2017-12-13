function [MatchingCost,BestPath,D,Pred]=DTWSakoeEndp(ref,test,omitLeft,omitRight,genPlot)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [MatchingCost,BestPath,D,Pred]=DTWSakoeEndp(ref,test,omitLeft,omitRight,genPlot)
% Computes the Dynamic Time Warping cost between two feature sequences. The first
% argument is the prototype which is placed on the horizontal axis of the matching
% grid. The function employs the Sakoe-Chiba local constraints on
% a type N cost grid, where the Euclidean distance has been used as the
% distance metric. End-points constraints are permitted for the test sequence.
% This function calls BackTracking.m to extract the best path.
%
% INPUT ARGUMENTS:
%   ref:            reference sequence. Its size is mxI, where m is
%                   the number of features and I the number of feature vectors.
%   test:           test sequence. Its size is mxJ, where m is
%                   the number of features and J the number of feature vectors.
%   omitLeft:       left endpoint constraint for the test sequence. This is the
%                   number of feature vectors that can be omitted from the beginning
%                   of the test sequence.
%   omitRight:      right endpoint constraint for the test sequence. This is the
%                   number of feature vectors that can be omitted from the end
%                   of the test sequence.
%   genPlot:        if set to 1, a plot of the best path is generated.
%
% OUTPUT ARGUMENTS:
%   MatchingCost:   matching cost. The matching cost is
%                   normalized, i.e., it is divided with the length of the best path.
%   BestPath:       backtracking path. Each node of the best path is represented as a complex
%                   number, where the real part stands for the row index and the
%                   imaginary part stands for the column index of the node.
%   D:              cost grid. Its size is JxI (remember that the prototype
%                   is placed on the horizontal axis).
%   Pred:           matrix of node predecessors. The real part of Pred(j,i) is the row
%                   index and the imaginary part of Pred(j,i) is the column index of the
%                   predecessor of node (j,i).
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Initialization
[D1,I]=size(ref);
[D2,J]=size(test);

if D1~=D2
    msgbox('Mismatch of dimensions between feature sequences');
    MatchingCost=[]; BestPath=[]; D=[]; Pred=[];
    return;
end

for j=1:J
    for i=1:I
        %Euclidean distance
        NodeCost(j,i)=sqrt(sum((ref(:,i)-test(:,j)).^2));
    end
end

%Initialization
for j=1:omitLeft+1 %due to the left endpoint constraint
    D(j,1)=NodeCost(j,1);
    Pred(j,1)=0;
end

for j=omitLeft+2:J
    D(j,1)=D(j-1,1)+NodeCost(j,1);
    Pred(j,1)=(j-1) + sqrt(-1)*1;
end

for i=2:I
    D(1,i)=D(1,i-1)+NodeCost(1,i);
    Pred(1,i)=1 + sqrt(-1)*(i-1);
end

for j=2:J
    for i=2:I
        %Sakoe-Chiba local path constraints
        [D(j,i),ind]=min([D(j-1,i-1) D(j,i-1) D(j-1,i)]+NodeCost(j,i));
        if ind==1
            Pred(j,i)=(j-1)+sqrt(-1)*(i-1);
        elseif ind==2
            Pred(j,i)=(j)+sqrt(-1)*(i-1);
        else
            Pred(j,i)=(j-1)+sqrt(-1)*(i);
        end
    end
end

MatchingCost=inf;
for k=J:-1:J-omitRight %due to the right endpoint constraint
    tempPath=BackTracking(Pred,k,I,0,ref,test);
    [mB,nB]=size(tempPath);
    tempCost=D(k,I)/mB;
    if tempCost<MatchingCost
        winner=k;
        MatchingCost=tempCost;
        BestPath=tempPath;
    end
end

if genPlot==1
    tempPath=BackTracking(Pred,winner,I,1,ref,test);
end
