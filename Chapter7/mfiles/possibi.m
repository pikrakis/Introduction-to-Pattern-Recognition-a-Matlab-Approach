function [U,theta]=possibi(X,m,eta,q,sed,init_proc,e_thres)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%  [U,theta]=possibi(X,m,eta,q,sed,init_proc,e_thres)
% Implements the possibilistic algorithm, when the squared
% Euclidean distance is adopted. The key point on which the algorithm is
% based is that of the "compatibility" of a vector x with a cluster. This
% is quantified by a scalar, which is independent of the compatibility of
% x with the rest clusters. The algorithm moves iteratively the cluster
% representatives to regions that are "dense" in data, so that a suitable
% cost function is minimized. It terminates when no significant
% difference in the values of the representatives is encountered between
% two successive iterations. The number of clusters is a priori required.
% However, when it is overestimated, the algorithm has the ability to
% return a solution where more than one representatives coincide.
%
% INPUT ARGUMENTS:
%  X:       lxN matrix, each column of which corresponds to a data vector.
%  m:       number of clusters.
%  eta:     m-dimensional array of the "eta" parameters of the clusters.
%  q:       the "q" parameter of the algorithm. When this is not equal to 0
%           the original cost function is considered, while if it is 0 the
%           alternative one is considered.
%  sed:     a scalar integer, which is used as the seed for the random
%           generator function "rand".
%  init_proc: an integer "init_proc" taking values "1", "2" or "3" with
%              - "1" corresponding to "rand_init" initialization procedure
%                (this procedure chooses randomly "m" vectors from the
%                smallest hyperrectangular that contains all the vectors of
%                X and its sides are parallel to the axes).
%              - "2" corresponding to "rand_data_init" (this procedure
%                chooses randomly m among the N vectors of X) and
%              - "3" corresponding to "distant_init" (this procedure
%                chooses the m vectors of X that are "most distant" from
%                each other. This is a more computationally demanding
%                procedure).
%  e_thres: threshold that is involved in the terminating condition of
%           the algorithm. Specifically, the algorithm terminates when the
%           sum of the absolute differences of the representatives between
%           two successive iterations is smaller than "e_thres".
%
% OUTPUT ARGUMENTS:
%  U:       Nxm matrix, whose (i,j) element denotes the
%           compatibility of the i-th data vector with the j-th cluster,
%           after the convergence of the algorithm.
%  theta:   lxm matrix, each column of which corresponds to
%           a cluster representative, after the convergence of the
%           algorithm.
%  NOTE:    this function calls functions "rand_init", "rand_data_init"
%           and "distant_init".
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rand('seed',sed)
[l,N]=size(X);

if(init_proc==1)
    theta_ini=rand_init(X,m,sed);
elseif(init_proc==2)
    theta_ini=rand_data_init(X,m,sed);
else(init_proc==3)
    theta_ini=distant_init(X,m,sed);
end
theta_ini

e_thres=.001;   % This threshold is used in the termination condition
e=1;
iter=0;

theta=theta_ini;
if(q~=0)  % Original possibilistic scheme
    while (e>e_thres)
        % Computation of the matrix U
        for i=1:N
            for j=1:m
                U(i,j)=1/(1+ (distan(X(:,i),theta(:,j))/eta(j))^(1/(q-1)) );
            end
        end
        theta_old=theta;
        theta=zeros(l,m);
        iter=iter+1;
        
        %Updating of the representatives
        for j=1:m
            deno=0;
            for i=1:N
                theta(:,j)=theta(:,j)+U(i,j)^q*X(:,i);
                deno=deno+U(i,j)^q;
            end
            theta(:,j)=theta(:,j)/deno;
        end
        e=sum(sum(abs(theta-theta_old)));
    end
else  % Alternative possibilistic scheme
    while (e>e_thres)
        % Computation of the matrix U
        for i=1:N
            for j=1:m
                U(i,j)=exp(-distan(X(:,i),theta(:,j))/eta(j));
            end
        end
        theta_old=theta;
        theta=zeros(l,m);
        iter=iter+1;
        
        %Updating of the representatives
        for j=1:m
            deno=0;
            for i=1:N
                theta(:,j)=theta(:,j)+U(i,j)*X(:,i);
                deno=deno+U(i,j);
            end
            theta(:,j)=theta(:,j)/deno;
        end
        e=sum(sum(abs(theta-theta_old)));
    end
end