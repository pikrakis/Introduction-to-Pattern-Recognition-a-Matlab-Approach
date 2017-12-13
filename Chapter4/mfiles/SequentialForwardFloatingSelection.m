function [cLbest,maxJ]=SequentialForwardFloatingSelection(class1,class2,CostFunction,NumFeatComb)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%  [cLbest,maxJ]=SequentialForwardFloatingSelection(class1,class2,CostFunction,NumFeatComb);
%  Feature vector selection by means of the Sequential Forward Floating
%  Selection technique, given the desired number of features in the best combination.
%
% INPUT ARGUMENTS:
%   class1:         matrix of data for the first class, one pattern per column.
%   class2:         matrix of data for the second class, one pattern per column.
%   CostFunction:   class separability measure.
%   NumFeatComb:    desired number of features in best combination.
%
% OUTPUT ARGUMENTS:
%   cLbest:         selected feature subset. Vector of row indices.
%   maxJ:           value of the class separabilty measure.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

warning('off');
m=size(class1,1);
k=2;
% Initialization
[X{k},C{k}]=SequentialForwardSelection(class1,class2,CostFunction,2);


while k<=NumFeatComb
    % Step I
    Ct=[];
    Y{m-k}=setdiff(1:m,X{k});
    for i=1:length(Y{m-k})
        t=[X{k} Y{m-k}(i)];
        Ct=[Ct eval([CostFunction '(class1(t,:),class2(t,:));'])];
    end
    [J_of_x,ind]=max(Ct);
    the_x=Y{m-k}(ind);
    X{k+1}=[X{k} the_x];
    
    % Step II:Test
    Ct=[];
    for i=1:length(X{k+1})
        t=setdiff(X{k+1}, X{k+1}(i));
        Ct=[Ct eval([CostFunction '(class1(t,:),class2(t,:));'])];
    end
    [J,r]=max(Ct);
    xr=X{k+1}(r);
    if r==k+1
        C{k+1}=eval([CostFunction '(class1(X{k+1},:),class2(X{k+1},:));']);
        k=k+1;
        continue;
    end
    if r~=k+1 &  J< C{k}
        continue;
    end
    if k==2
        X{k}=setdiff(X{k+1},xr);
        C{k}=J;
        continue;
    end
    
    % Step III: Exclusion
    flag=1;
    while flag
        X_hat{k}=setdiff(X{k+1},xr);
        Ct=[];
        for i=1:length(X_hat{k})
            t=setdiff(X_hat{k}, X_hat{k}(i));
            Ct=[Ct eval([CostFunction '(class1(t,:),class2(t,:));'])];
        end
        [J,s]=max(Ct);
        xs=X_hat{k}(s);
        if J<C{k-1}
            X{k}=X_hat{k};
            C{k}=eval([CostFunction '(class1(X{k},:),class2(X{k},:));']);
            flag=0;
            break;
        end
        X_hat{k-1}=setdiff(X_hat{k},xs);
        k=k-1;
        if k==2
            X{k}=X_hat{k};
            C{k}=eval([CostFunction '(class1(X_hat{k},:),class2(X_hat{k},:));']);
            flag=0;
        end
    end
    if flag==0
        continue;
    end
end

if k>NumFeatComb
    k=k-1;
end
cLbest=sort(X{k},'ascend');
maxJ=C{k};

