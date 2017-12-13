% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%
% CHAPTER 4: m-files
%
%   compositeFeaturesRanking           - Scalar feature ranking that takes into account 
%                                        the cross-correlation coefficient.
%   divergence                         - Computes the divergence between two classes.
%   divergenceBhata                    - Computes the Bhattacharyya distance between two classes.
%   exhaustiveSearch                   - Exhaustive search for the best feature combination, 
%                                        depending on the adopted class separability measure.
%   Fisher                             - Computes Fisher’s discriminant ratio of a scalar feature in 
%                                        a two-class problem.
%   normalizeMnmx                      - Performs MinMax normalization in a given interval [l r].
%   normalizeSoftmax                   - Performs Softmax normalization in the interval [0 1].
%   normalizeStd                       - Performs data normalization to zero mean and standard deviation equal to 1.
%   plotData                           - Plotting utility for class data. 
%   plotHist                           - Plots the histograms of two classes for the same feature.
%   ROC                                - Plots the ROC curve and computes the area under the curve.
%   ScalarFeatureSelectionRanking      - Features are treated individually and are ranked according to the
%                                        adopted class separability criterion.
%   ScatterMatrices                    - Class separability measure, which is computed using the 
%                                        within-class and mixture scatter matrices.
%   SequentialBackwardSelection        - Feature vector selection by means of the Sequential Backward
%                                        Selection technique.
%   SequentialForwardFloatingSelection - Feature vector selection by means of the Sequential Forward
%                                        Floating Selection technique.
%   SequentialForwardSelection         - Feature vector selection by means of the Sequential Forward Selection
%                                        technique.
%   simpleOutlierRemoval               - Removes outliers from a normally distributed dataset by means of the
%                                        thresholding method.
