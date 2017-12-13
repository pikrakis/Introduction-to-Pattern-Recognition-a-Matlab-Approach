function [pos,thres,a,sleft_fin,P,y_est]=base_clas_coord(X,y,w)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [pos,thres,a,sleft_fin,P,y_est]=base_clas_coord(X,y,w)
% Implements a simple weak classifier known as "stump".
% Specifically, a dimension is chosen randomly and a threshold is chosen
% on it. The vectors whose value according to the chosen dimension are
% less than the threshold are classified to one class while the rest to
% the other class. The labeling of the left and right to the threshold
% regions is carried out so as to minimize the (weighted) classification
% error.
%
% INPUT ARGUMENTS:
%   X:      lxN matrix, each column of which is a feature vector.
%   y:      N-dimensional vector, whose i-th coordinate is the class
%           label (+1 or -1) of the class where the i-th data vector
%           belongs.
%   w:      N-dimensional vector, whose i-th element is the weight
%           corresponding to the i-th data vector (data vectors with
%           greater weight values require more attention of the weak
%           classfier).
%
% OUTPUT ARGUMENTS:
%   pos:    integer indicating the chosen dimension.
%   thres:  value of threshold on the chosen dimension.
%   a:      weight for the current (weak) classfier.
%   sleft_fin:  a variable taking the values 1 (-1) depending on whether
%           the range left to the threshold is assigned to class -1 (1).
%   P:      the (weighted) probability of classification error.
%   y_est:  N-dimensional vector, whose i-th coordinate is the class
%           label (1 or -1) of the class where the i-th data vector has
%           been assigned by the classifier.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[l,N]=size(X);

%Choosing randomly the dimension with respect to which the
%classification will take place
helpy=rand;
t=fix(helpy*l);

temp=1:1:l;

s=(t>=temp);
pos=sum(s)+1;  %Chosen dimension


thres=0; % The threshold which distinguishes the classes along the chosen dimension
sleft_fin=0; % Takes the value 1 (-1) if the points left to the threshold are classified in class -1 (1).
P=0;     % The probability of error

maxi=max(X(pos,:)); %Maximum value of among all the data vectors along the chosen dimension
mini=min(X(pos,:)); %Minimum value of among all the data vectors along the chosen dimension

e=1;
while(e>0)   %Loop until a (weak) classifier with success classification rate >0.5 is determined.
    t=rand;
    v=mini+(maxi-mini)*t;
    y_temp=X(pos,:)-v;
    
    b1=sum((y.*y_temp>0).*w);
    b2=sum((y.*y_temp<0).*w);
    
    [c,ind]=max([b1 b2]);
    if(ind==1)
        sleft=1;
    else
        sleft=-1;
    end
    
    if(c>.5)
        P=1-c;
        sleft_fin=sleft;
        thres=v;
        y_est=2*(sleft*y_temp>0)-1; %It take values -1 or 1
        a=0.5*log((1-P)/P);   %Weight factor for the current classifier
        e=0;
    end
end
