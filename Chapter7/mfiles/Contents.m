% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%
% CHAPTER 7: m-files
%
%   agglom         - Generalized Agglomerative Scheme (GAS) for data
%                    clustering. It runs, on demand, either the single link or the complete link algorithm.
%   BSAS           - Basic Sequential Algorithmic Scheme (BSAS algorithm) for data clustering.
%   CL_step        - Performs a step of the complete link algorithm.
%   dendrogram_cut - Determines the clusterings of a hierarchy that best fit the underlying clustering
%                    structure of the data set at hand.
%   fuzzy_c_means  - FCM algorithm for data clustering.
%   GMDAS          - Generalized Mixture Decomposition Algorithmic Scheme (GMDAS algorithm) for data clustering.
%   k_means        - k-means clustering algorithm.
%   k_medoids      - k-medoids clustering algorithm.
%   LLA            - Competitive leaky learning algorithm for data clustering.
%   possibi        - Possibilistic clustering algorithm, adopting the squared Euclidean distance.
%   SL_step        - Performs a step of the single link algorithm.
%   spectral_Ncut2 - Spectral clustering based on the normalized cut
%   criterion.
%   valley_seeking - Valley seeking algorithm for data clustering.
%   auxiliary functions - cost_comput, distan, distant_init, rand_data_init, rand_init, reassign