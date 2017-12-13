function [T]=ScalarFeatureSelectionRanking(c1,c2,sepMeasure)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [T]=ScalarFeatureSelectionRanking(c1,c2,sepMeasure)
% Features are treated individually and are ranked according to the
% adopted separability criterion.
%
% INPUT ARGUMENTS:
%   c1:         matrix of data for the first class, one pattern per column.
%   c2:         matrix of data for the second class, one pattern per column.
%   sepMeasure: class separability measure. Valid options are: 'divergence',
%               'divergenceBhata', 'Fisher' and 'ROC'.
%
% OUTPUT ARGUMENTS:
%   T:          feature ranking matrix. The first column contains class
%               separability costs and the second column the respective feature ids.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:size(c1,1)
    switch sepMeasure
        case {'divergence','divergenceBhata','Fisher'}
            eval(['t = ' sepMeasure '(c1(i,:),c2(i,:));']);
        case 'ROC'
            superClass=[c1(i,:), c2(i,:)];
            classLabels = round([1*ones(size(class1,2),1); -1*ones(size(class2,2),1)]);
            plot=0; % do not generate a ROC plot
            t = ROC(superClass, classLabels,plt);
        otherwise
            fprintf('Unrecognised separability measure\n');
            T=[]; return;
    end
    T(i,1)=t;
    T(i,2)=i;
end
[T,I]=sortrows(T,-1);
