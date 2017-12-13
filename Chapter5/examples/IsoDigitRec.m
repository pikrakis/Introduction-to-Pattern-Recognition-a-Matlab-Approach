% IsoDigitRec.m (Example 5.4)
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

% At a first step, the data folder of Chapter 5 is appended to the existing 
% MATLAB path. It is assumed that the current folder is the "examples" 
% folder of Chapter 5. 
curDir=pwd;
ind=strfind(curDir,'\');
curDir(ind(end)+1:end)=[];
addpath([curDir 'data'],'-end');

close('all');
clear;

% To build the system, we will use short-term Energy and short-term Zero-
% Crossing Rate (Section 7.5.4, [Theo 09]) as features, so that each signal is rep-
% resented by a sequence of two-dimensional feature vectors. Note that this is not
% an optimal feature set in any sense and it has only been adopted on the basis of
% simplicity. The feature extraction stage is accomplished by typing the following
% code:
protoNames={'zero','one','two','three','four','five','six','seven','eight','nine'};
for i=1:length(protoNames)
    [x,Fs,bits]=wavread(protoNames{i});
    winlength = round(0.02*Fs); % 20 ms moving window length
    winstep = winlength; % moving window step. No overlap
    [E,T]=stEnergy(x,Fs,winlength,winstep);
    [Zcr,T]=stZeroCrossingRate(x,Fs,winlength,winstep);
    protoFSeq{i}=[E;Zcr];
end

% To find the best match for an unknown pattern, say a pattern stored in file
% "upattern1.wav", type the following code:
[test,Fs,bits]=wavread('upattern1');
winlength = round(0.02*Fs); % use the same values as before
winstep = winlength;
[E,T]=stEnergy(test,Fs,winlength,winstep);
[Zcr,T]=stZeroCrossingRate(test,Fs,winlength,winstep);
Ftest=[E;Zcr];
tolerance=0.1;
LeftEndConstr=round(tolerance/winstep); % left endpoint constraint
RightEndConstr = LeftEndConstr;
for i=1:length(protoNames)
    [MatchingCost(i),BestPath{i},D{i},Pred{i}]=DTWSakoeEndp(protoFSeq{i},Ftest,LeftEndConstr,RightEndConstr,0);
end
[minCost,indexofBest]=min(MatchingCost);
fprintf('The unknown pattern has been identified as a "%s" \n',protoNames{indexofBest});
