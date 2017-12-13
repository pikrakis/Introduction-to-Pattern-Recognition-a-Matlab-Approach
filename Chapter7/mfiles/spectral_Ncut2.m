function bel=spectral_Ncut2(X,e,sigma2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%  bel=spectral_Ncut2(X,e,sigma2)
% This function performs spectral clustering based on the NxN dimensional
% normalized graph Laplacian L1, produced by an lxN dimensional matrix
% "X", each column of which corresponds to a data vector. The number of
% clusters in this case is fixed to 2.
% The algorithm determines the N dimensional eigenvector that corresponds
% to the 2nd smallest eigenvalue of L1. A new vector y is produced by
% multiplying the above eigenvector with a suitable matrix D. Finally, the
% elements of y are divided into two groups according to whether they are
% greater or less than the median value of y. This division specifies the
% clustering of the vectors in the original data set X.
% The algorithm minimizes the so-called Ncut criterion.
%
% INPUT ARGUMENTS:
%  X:       lxN matrix each column of which is a data vector.
%  e:       the parameter that defines the size of the neighborhood around
%           each vector.
%  sigma2:  the parameter that controls the width of the Gaussian kernel
%           (here only the case where all the kernels have the same sigma^2
%           parameter is considered).
%
% OUTPUT ARGUMENTS:
%  bel:     N-dimensional vector whose i-th element contains the index
%           of the cluster to which the i-th data vector is assigned.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[l,N]=size(X);

% Computation of the distances between vectors
dist=zeros(N,N);
for i=1:N
    dist(i,:)=sum((X(:,i)*ones(1,N)-X).^2);
end

% Computation of the weight matrix W
W=exp(-dist/(2*sigma2)).*(dist<e^2);
D=diag(sum(W));

%Computation of the matrices L, L tilda (L1)
L=D-W;

L1=D^(-.5)*L*D^(-.5);

%Determination of the eigenvalues/eigenvectors of L1. Identifing the
%eigenvector corresponding to the 2nd smallest eigenvalue.
[V,D1]=eig(L1);

de=diag(D1);
[Y,I]=sort(de);

%Transformation by multiplying with D^(-.5)
y=D^(-.5)*V(:,I(2));

% Discretization
bel=(y>=median(y));