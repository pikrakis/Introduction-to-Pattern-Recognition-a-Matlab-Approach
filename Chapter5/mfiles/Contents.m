% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%
% CHAPTER 5: m-files
%
%   BackTracking       - Performs backtracking on a matrix of node predecessors and returns the best path.
%   DTWItakura         - Computes the Dynamic Time Warping cost between two feature sequences, based on the 
%                        standard Itakura local constraints.
%   DTWItakuraEndp     - Similar to DTWItakura, with the addition that end-points constraints are allowed
%                        in the test sequence.
%   DTWSakoe           - Computes the Dynamic Time Warping cost between two feature sequences, based on the
%                        Sakoe-Chiba local constraints.
%   DTWSakoeEndp       - Similar to DTWSakoe, with the addition that end-points constraints are allowed in
%                        the test sequence.
%   editDistance       - Computes the Edit (Levenstein) distance between two sequences of characters.
%   stEnergy           - Auxiliary function. Computes the short-term energy envelop of a signal.
%   stZeroCrossingRate - Auxiliary function. Computes the zero-crossing rate of a signal.
