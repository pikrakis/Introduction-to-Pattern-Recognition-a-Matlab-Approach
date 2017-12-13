function [ap,cp,mv,mc,iter,diffvec]=GMDAS(X,mv_ini,mc_ini,e,maxiter,sed)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%  [ap,cp,mv,mc,iter,diffvec]=GMDAS(X,mv_ini,mc_ini,e,maxiter,sed)
% This function implements the GMDAS (Generalized Mixture Decomposition 
% Algorithmic Scheme) algorithm, where each cluster is characterized by 
% a Gaussian distribution. The aim is to estimate the means and the
% covariance matrices of the distributions characterizing each cluster,
% as well as the a priori probabilities of the clusters. This is carried
% out in an  iterative manner which terminates when no significant change
% in the values of the above parameters is encountered between two
% successive iterations. In contrast to the k-means and the k-medoids
% algorithms, each vector belongs to a cluster with some probability.
% The number of clusters m is assumed to be known. 
%
% INPUT ARGUMENTS:
%  X:       lxN matrix, each column of which corresponds to
%           an l-dimensional data vector.
%  mv_ini:  lxm matrix, each column of which contains an
%           initial estimate of the means that correspond to the clusters.
%  mc_ini:  lxlxm matrix whose j-th lxl two-dimensional
%           "slice" is an initial estimate of the covariance matrix
%           corresponding to the j-th cluster.
%  e:       threshold that is involved in the terminating condition of
%           the algorithm. Specifically, the algorithm terminates when the
%           sum of the absolute differences of mv's, mc's and a priori
%           probabilities between two successive iterations is smaller than
%           e. 
%  maxiter: maximum number of iterations the algorithm is allowed to
%           run. 
%  sed:     seed used for the initialization of the random generator
%           function "rand".
%
% OUTPUT ARGUMENTS:
%  ap:      m-dimensional vector whose i-th coordinate contains the a
%           priori probability of the i-th cluster.
%  cp:      Nxm matrix whose (i,j) element contains the
%           probability of the fact that the i-th vector belongs to the
%           j-th cluster. 
%  mv:      lxm matrix each column of which contains the
%           final estimate of the means that correspond to the clusters.
%  mc:      lxlxm dimensional matrix whose j-th lxl two-dimensional
%           "slice" is the final estimate of the covariance matrix
%           corresponding to the j-th cluster.
%  iter:    number of iterations performed by the algorithm.
%  diffvec: a vector whose i-th cooordinate contains the difference
%           between the sum of the absolute differences of "mv"'s "mc"'s and a 
%           priori probabilities between the i-th and the (i-1)-th iteration.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    mv=mv_ini;
    mc=mc_ini;

    [l,N]=size(X);
    [l,m]=size(mv);
    rand('seed',sed)
    % Initialization of the conditional probabilities
    for i=1:N
        cp(i,:)=rand(1,m);
        sumcp=sum(cp(i,:));
        cp(i,:)=cp(i,:)/sumcp;
    end

    % The iteration scheme
    iter=0;
    diff=e+1;
    mvold=mv;            
    mcold=mc;            
    apold=ones(1,m)/m;   
    diffvec=[];
    while (iter<maxiter)&(diff>e)
        iter=iter+1;
        diffvec=[diffvec diff];

        % Computation of the a priori probabilities
        temp=sum(cp);
        ap=temp/N;

        % Computation of the mean vectors
        for i=1:m
            aux=zeros(l,1);
            for j=1:N
                aux=aux+cp(j,i)*X(:,j);
            end
            mv(:,i)=aux/temp(i);
        end

        % Computation of the covariance matrices
        for i=1:m
            aux=zeros(l);
            for j=1:N
                aux=aux+cp(j,i)*(X(:,j)-mv(:,i))*(X(:,j)-mv(:,i))';
            end
            mc(:,:,i)=aux/temp(i);
        end

        diff=sum(abs(ap-apold))+sum(sum(abs(mv-mvold)))+sum(sum(sum(abs(mc-mcold))));
        apold=ap;
        mvold=mv;
        mcold=mc;

        % Computation of the determinants of the covariance matrices
        for i=1:m
            dete(i)=det(mc(:,:,i));
        end

        % Computation of the conditional probabilities
        for j=1:N
            for i=1:m
                auxvec(j,i)=dete(i)^(-.5)*exp(-.5*(X(:,j)-mv(:,i))'*inv(mc(:,:,i))*(X(:,j)-mv(:,i)) )*ap(i);
            end
            sumaux=sum(auxvec');
        end

        for j=1:N
           for i=1:m
               cp(j,i)=auxvec(j,i)/sumaux(j);
           end
        end
    end