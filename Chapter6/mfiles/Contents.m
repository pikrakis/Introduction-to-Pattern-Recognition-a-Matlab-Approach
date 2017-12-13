% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%
% CHAPTER 6: m-files
%
%   BWDoHMMsc              - Computes the recognition probability of a HMM, given a sequence of discrete
%                            observations, by means of the scaled version of the Baum-Welch (any-path) method
%   BWDoHMMst              - Same as BWDoHMMSc, except that no scaling is employed.
%   MultSeqTrainCoHMMBWsc  - Baum-Welch training (scaled version) of a Continuous Observation
%                            HMM, given multiple training sequences. Each sequence 
%                            consists of l-dimensional feature vectors.
%                            It is assumed that the pdf associated with each state 
%                            is a multivariate Gaussian mixture. 
%   MultSeqTrainDoHMMBWsc  - Baum-Welch training (scaled version) of a Discrete Observation
%                            HMM, given multiple training sequences.
%   MultSeqTrainDoHMMVITsc - Viterbi training (scaled version) of a Discrete ObservationHMM,given
%                            multiple training sequences.
%   VitCoHMMsc             - Computes the scaledViterbi score of aHMM,given a sequence of l-dimensional vectors
%                            of continuous observations, under the assumption that the pdf 
%                            of each state is a Gaussian mixture.
%   VitCoHMMst             - Same as VitCoHMMsc except that no scaling is employed.
%   VitDoHMMsc             - Computes the scaled Viterbi score of a Discrete Observation HMM, 
%                            given a sequence of observations.
%   VitDoHMMst             - Same as VitDoHMMsc, except that no scaling is employed.
