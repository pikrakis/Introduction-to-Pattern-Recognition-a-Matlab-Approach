% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%
% CHAPTER 3: m-files
%
%   cut_cylinder_3D      - Produces a cut cylinder in the three dimensional space.
%   im_point             - Performs the projection of a vector on the subspace spanned by the first m principal
%                          components, that result after performing kernel PCA on a dataset.
%   K_fun                - Computes the value of a kernel function (polynomial or exponential) for two vectors.
%   kernel_PCA           - Performs kernel PCA based on a given set of data vectors.
%   lapl_eig             - Performs Laplacian eigenmap based on the graph Laplacian matrix L.
%   pca_fun              - Performs Principal Component Analysis (PCA) on a dataset.
%   plot_orig_trans_kPCA - Plots the data points and the classifier in the original (two-dimensional) data
%                          space as well as the space spanned by the two most significant principal components, as they are
%                          computed using the kernel PCA method.
%   scatter_mat          - Computes the within scatter matrix, the between scatter matrix and the mixture scatter
%                          matrix for a c-class classification problem, based on a given dataset.
%   spiral_3D            - Creates a 3-dimensional Archimedes spiral.
%   svd_fun              - Performs Singular Value Decomposition (SVD) of a matrix.
