function y=lapl_eig(X,e,sigma2,m)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   y=lapl_eig(X,e,sigma2,m)
% Performs Laplacian eigenmap based on the NxN dimensional
% graph Laplacian L, produced by an lxN dimensional matrix X, each column
% of which corresponds to a data vector. The algorithm determines the m
% N-dimensional eigenvectors that correspond to the m smallest nonzero
% eigenvalues.
%
% INPUT ARGUMENTS:
%   X:      lxN matrix each column of which is a data vector.
%   e:      the parameter that defines the size of the neighborhood around
%           each vector.
%   sigma2: the parameter that controls the width of the exponential kernel
%           (here only the case where all the kernels have the same sigma^2
%           parameter is considered).
%   m:      the dimension of the manifold where the data are (assumed to)
%           live.
%
% OUTPUT ARGUMENTS:
%   y:    mxN matrix whose rows are the eigevectors that
%         correspond to the m smallest nonzero eigenvalues of L. In
%         addition, the i-th column of y defines the projection of the i-th
%         data vector to the m-dimensional space.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[l,N]=size(X);
% Computation of the (squared Euclidean) distances between vectors
dist=zeros(N,N);
for i=1:N
    dist(i,:)=sum( (X(:,i)*ones(1,N)-X).^2);
end

% Computation of the weight matrix W
W=exp(-dist/(2*sigma2)).*(dist<e^2);
D=diag(sum(W));

%Computation of the matrices L, L tilda (L1)
L=D-W;

%Eigendecomposition of L (solving L*V=D*V*E).
[V,E]=eig(L,D);
de=diag(E);
[Y,I]=sort(de);

%Number of zero or almost zero eigenvalues
t=sum(Y<10^(-9));

%The m eigenvectors that correspond to m smallest nonzero
%eigenvalues
y=V(:,I(t+1:t+m))';

