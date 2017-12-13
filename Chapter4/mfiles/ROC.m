function [auc]=ROC(x,y,plt)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [auc]=ROC(x,y)
% Plots the ROC curve and computes the area under the curve.
%
% INPUT ARGUMENTS:
%   x:      columun vector of data for both classes.
%   y:      column vector with the respective data labels. Each element
%           is equal to either -1 or 1.
%   plt:    if set to 1, a plot is generated.
% OUTPUT ARGUMENTS:
%   auc:    area under ROC curve.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

patterns = [x y];
patterns = sortrows(patterns,-1);
y = patterns(:,2);
p = cumsum(y==1);
tp = p/sum(y==1);
n = cumsum(y==-1);
fp = n/sum(y==-1);

n = length(tp);
Y=(tp(2:n)+tp(1:n-1))/2;
X = fp(2:n) - fp(1:n-1);
auc=sum(Y.*X)-0.5;

if (plt==1)
    plot(fp,tp,'k','LineWidth',2);grid on;
    hold on;plot(tp,tp,'-.k','LineWidth',2);
    xlabel('\alpha','FontSize',16);ylabel('1-\beta','FontSize',16);
    s=num2str(auc); s=strcat('Area Under Curve= ',s);
    title(['ROC Curve, ' s],'FontSize',14);hold off;
end
