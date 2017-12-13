function [w,iter,mis_clas]=perce(X,y,w_ini,rho)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%  [w,iter,mis_clas]=perce(X,y,w_ini,rho)
% Separates the vectors of two classes contained in a data
% set X with a hyperplane, which is iteratively adjusted via the perceptron
% learning rule. Note that the updating of the parameter vector at the t-th
% iteration is carried out after all the data vectors have been processed
% by the algorithm. 
%
% NOTE: In this implementation, the learning rate is chosen to be constant.
%
% INPUT ARGUMENTS:
%  X:       lxN matrix whose columns are the data vectors to
%           be classfied.
%  y:       N-dimensional vector whose i-th  component contains the
%           label of the class where the i-th data vector belongs (+1 or
%           -1).
%  w_ini:   l-dimensional vector, which is the initial estimate of the
%           parameter vector that corresponds to the separating hyperplane.
%  rho:     the learning rate parameter for the perceptron algorithm.
%
% OUTPUT ARGUMENTS:
%  w:       the final estimate of the parameter vector.
%  iter:    the number of iterations required for the convergence of the
%           algorithm.
%  mis_clas: number of misclassified data vectors.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[l,N]=size(X);
max_iter=20000; % Maximum allowable number of iterations

w=w_ini;        % Initilaization of the parameter vector
iter=0;         % Iteration counter

mis_clas=N;     % Number of misclassfied vectors

while(mis_clas>0)&&(iter<max_iter)
    iter=iter+1;
    mis_clas=0;
    
    gradi=zeros(l,1); % Computation of the "gradient" term
    for i=1:N
        if((X(:,i)'*w)*y(i)<0)
            mis_clas=mis_clas+1;
            gradi=gradi+rho*(-y(i)*X(:,i));
        end
    end
    
    if(iter==1)
        fprintf('\n First Iteration: # Misclassified points = %g \n',mis_clas);        
    end
    
    w=w-rho*gradi; % Updating the parameter vector
end