function [m,s,Pa,iter,Q_tot,e_tot]=em_alg_function(x,m,s,Pa,e_min)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [m,s,Pa,iter,Q_tot,e_tot]=em_alg_function(x,m,s,Pa,e_min)
% EM algorithm for estimating the parameters of a mixture of normal
% distributions, with diagonal covariance matrices.
% WARNING: IT ONLY RUNS FOR THE CASE WHERE THE COVARIANCE MATRICES
% ARE OF THE FORM sigma^2*I. IN ADDITION, IF sigma_i^2=0 FOR SOME
% DISTRIBUTION AT AN ITERATION, IT IS ARBITRARILY SET EQUAL TO 0.001.
%
% INPUT ARGUMENTS:
%   x:      lxN matrix, each column of which is a feature vector.
%   m:      lxJ matrix, whos j-th column is the initial
%           estimate for the mean of the j-th distribution.
%   s:      1xJ vector, whose j-th element is the variance
%           for the j-th distribution.
%   Pa:     J-dimensional vector, whose j-th element is the initial
%           estimate of the a priori probability of the j-th distribution.
%   e_min:  threshold used in the termination condition of the EM
%           algorithm.
%
% OUTPUT ARGUMENTS:
%   m:      it has the same structure with input argument m and contains
%           the final estimates of the means of the normal distributions.
%   s:      it has the same structure with input argument s and contains
%           the final estimates of the variances of the normal
%           distributions.
%   Pa:     J-dimensional vector, whose j-th element is the final estimate
%           of the a priori probability of the j-th distribution.
%   iter:   the number of iterations required for the convergence of the
%           EM algorithm.
%   Q_tot:  vector containing the likelihood value at each iteration.
%   e_tot:  vector containing the error value at each itertion.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x=x';
m=m';
[p,n]=size(x);
[J,n]=size(m);

e=e_min+1;

Q_tot=[];
e_tot=[];

iter=0;
while (e>e_min)
    iter=iter+1;
    e;
    
    P_old=Pa;
    m_old=m;
    s_old=s;
    
    % Determine P(j|x_k; theta(t))
    for k=1:p
        temp=gauss(x(k,:),m,s);
        P_tot=temp*Pa';
        for j=1:J
            P(j,k)=temp(j)*Pa(j)/P_tot;
        end
    end
    
    % Determine the log-likelihood
    Q=0;
    for k=1:p
        for j=1:J
            Q=Q+P(j,k)*(-(n/2)*log(2*pi*s(j)) - sum( (x(k,:)-m(j,:)).^2)/(2*s(j)) + log(Pa(j)) );
        end
    end
    Q_tot=[Q_tot Q];
    
    % Determine the means
    for j=1:J
        a=zeros(1,n);
        for k=1:p
            a=a+P(j,k)*x(k,:);
        end
        m(j,:)=a/sum(P(j,:));
    end
    
    % Determine the variances
    for j=1:J
        b=0;
        for k=1:p
            b=b+ P(j,k)*((x(k,:)-m(j,:))*(x(k,:)-m(j,:))');
        end
        s(j)=b/(n*sum(P(j,:)));
        
        if(s(j)<10^(-10))
            s(j)=0.001;
        end
        
    end
    
    % Determine the a priori probabilities
    for j=1:J
        a=0;
        for k=1:p
            a=a+P(j,k);
        end
        Pa(j)=a/p;
    end
    
    e=sum(abs(Pa-P_old))+sum(sum(abs(m-m_old)))+sum(abs(s-s_old));    
    e_tot=[e_tot e];    
end
