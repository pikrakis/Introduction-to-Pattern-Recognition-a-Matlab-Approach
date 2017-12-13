function [MatchingCost,BestPath,D,Pred]=DTWItakuraEndp(ref,test,omitLeft,omitRight,genPlot)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [MatchingCost,BestPath,D,Pred]=DTWItakuraEndp(ref,test,omitLeft,omitRight,genPlot)
% Computes the Dynamic Time Warping cost between two feature sequences. The first
% argument is the prototype, which is placed on the horizontal axis of the matching
% grid. The function employs the standard Itakura local constraints on
% a cost grid, where the Euclidean distance has been used as the
% distance metric. End-points contstraints are permitted for the test sequence. 
% This function calls function BackTracking.m to extract the best path.
%
% INPUT ARGUMENTS:
%   ref:        reference sequence. Its size is mxI, where m is
%               the number of features and I the number of feature vectors.
%   test:       test sequence. The size is mxJ, where m is
%               the number of features and J the number of feature vectors.
%   omitLeft:   left endpoint constraint for the test sequence. This is the
%               number of frames that can be omitted from the beginning
%               of the test sequence.
%   omitRight:  right endpoint constraint for the test sequence. This is the
%               number of frames that can be omitted from the end
%               of the test sequence.
%   genPlot:    if set to 1, a plot of the best path is generated.
%
% OUTPUT ARGUMENTS:
%   MatchingCost:   the matching cost is normalized, i.e., it is divided by 
%                   the length of the best path.
%   BestPath:       backtracking path. Each node of the best path is represented as a complex
%                   number, where the real part stands for the row index and the
%                   imaginary part stands for the column index of the node.
%   D:              cost grid. Its size is JxI.
%   Pred:           matrix of node predecessors. The real part of Pred(j,i) is the row index
%                   and the imaginary part of Pred(j,i) is the column index of the predecessor
%                   of node (j,i).
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
for j=1:omitLeft+1 % due to the left endpoint constraint
    D(j,1)=NodeCost(j,1);
    Pred(j,1)=0;
end


for j=omitLeft+2:J %forbidden transitions
    D(j,1)=inf;
    Pred(j,1)=inf;
end

%Initialization
D(1,2)=NodeCost(1,1)+NodeCost(1,2);
Pred(1,2)=1+sqrt(-1)*1;

for i=3:I %forbidden transitions
    D(1,i)=inf;
    Pred(1,i)=inf;
end


%Main Loop
for j=2:J
    for i=2:I
        if (Pred(j,i-1)==j+sqrt(-1)*(i-2))
            if j>2
                [D(j,i),ind]=min([D(j-1,i-1) D(j-2,i-1)]+NodeCost(j,i));
            else
                [D(j,i),ind]=min([D(j-1,i-1)]+NodeCost(j,i));
            end
            if ind==1
                Pred(j,i)=(j-1)+sqrt(-1)*(i-1);
            else
                Pred(j,i)=(j-2)+sqrt(-1)*(i-1);
            end
        else
            if j>2
                [D(j,i),ind]=min([D(j,i-1) D(j-1,i-1) D(j-2,i-1)]+NodeCost(j,i));
            else
                [D(j,i),ind]=min([D(j,i-1) D(j-1,i-1)]+NodeCost(j,i));
            end
            if ind==1
                Pred(j,i)=(j)+sqrt(-1)*(i-1);
            elseif ind==2
                Pred(j,i)=(j-1)+sqrt(-1)*(i-1);
            else
                Pred(j,i)=(j-2)+sqrt(-1)*(i-1);
            end
        end
    end
end
%End of Main Loop


MatchingCost=inf;
for k=J:-1:J-omitRight %due to the right endpoint constraint
    if D(k,I)<inf
        tempPath=BackTracking(Pred,k,I,0,ref,test);
        [mB,nB]=size(tempPath);
        tempCost=D(k,I)/mB;
        if tempCost<MatchingCost
            winner=k;
            MatchingCost=tempCost;
            BestPath=tempPath;
        end
    end
end

if MatchingCost==inf
    BestPath=inf;
    MatchingCost=inf;
else    
    tempPath=BackTracking(Pred,k,I,genPlot,ref,test);
end
