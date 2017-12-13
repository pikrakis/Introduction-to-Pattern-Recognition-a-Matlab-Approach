% Example 4.3.1
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear;

% 1. File class1.dat and class2.dat contain the values of Table 4.1.
class1=load('class1.dat')';
class2=load('class2.dat')';

% 2. Normalize data in both classes to zero mean and standard deviation equal
% to one, using the normalizeStd.m

[c1_std,c2_std]=normalizeStd(class1,class2)

% 3. Normalize data so that to lie in [?1, 1]
[c1_Mnmx,c2_Mnmx]=normalizeMnmx(class1,class2,-1,1)

% 4. Normalize data in [0, 1] using softmax
[c1_Softmax,c2_Softmax]=normalizeSoftmax(class1,class2,0.5)

