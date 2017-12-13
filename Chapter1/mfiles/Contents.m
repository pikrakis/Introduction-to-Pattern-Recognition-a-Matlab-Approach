% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%
% CHAPTER 1: m-files
%
%   bayes_classifier       - Bayesian classification rule for c classes, modeled by Gaussian distributions (also used in Chapter 2).
%   comp_gauss_dens_val    - Computes the value of a Gaussian distribution at a specific point (also used in Chapter 2).
%   compute_error          - Computes the error of a classifier based on a data set (also used in Chapter 4).
%   em_alg_function        - EM algorithm for estimating the parameters of a mixture of normal distributions, with diagonal covariance matrices.
%   EM_pdf_est             - EM estimation of the pdfs of c classes. It is assumed that the pdf of each class is a mixture of Gaussians and that the respective covariance matrices are diagonal.
%   euclidean_classifier   - Euclidean classifier for the case of c classes.
%   Gaussian_ML_estimate   - Maximum Likelihood parameters estimation of a multivariate Gaussian distribution.
%   generate_gauss_classes - Generates a set of points that stem from c classes, given the corresponding a priori class probabilities and assuming that each class is modeled by a Gaussian distribution (also used in Chapter 2).
%   k_nn_classifier        - k-nearest neighbor classifier for c classes (also used in Chapter 4).
%   knn_density_estimate   - k-nn-based approximation of a pdf at a given data range.
%   mahalanobis_classifier - Mahalanobis classifier for c classes.
%   mixt_model             - Generates a set of data vectors that stem from a mixture of normal distributions (also used in Chapter 2).
%   mixt_value             - Computes the value of a pdf that is given as a mixture of normal distributions, at a given point.
%   mixture_Bayes          - Bayesian classification rule for c classes, whose pdfs are mixtures of normal distributions.
%   Parzen_gauss_kernel    - Parzen approximation of a pdf using a Gaussian kernel.
%   plot_data              - Plotting utility, capable of visualizing 2-dimensional datasets that consist of, at most, 7 classes.
%   gauss                  - Auxiliary function.
