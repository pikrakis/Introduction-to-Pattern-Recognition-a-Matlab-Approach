function [piTrained, ATrained, BTrained, AllProb] = MultSeqTrainDoHMMVITsc(pi_init, A, B, NumericData, maxEpoch)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [piTrained, ATrained, BTrained, AllProb] = MultSeqTrainDoHMMVITsc(pi_init, A, B, NumericData, maxEpoch)
% Viterbi training (scaled version) of a Discrete Observation HMM, given multiple training sequences.
%
% INPUT ARGUMENTS:
%   pi_init:        vector of initial state probalities upon initialization.
%   A:              state transition matrix upon initialization. The sum of each row equals 1.
%   B:              observation probability matrix upon initialization. The sum of each columns equals 1.
%   NumericData:    vector of cells, where each cell contains an
%                   observation sequence (sequence of discrete symbol ids).
%
% OUTPUT ARGUMENTS:
%   piTrained:      vector of initial state probalities at the output of
%                   the training stage.
%   ATrained:       state transition matrix at the output of the training stage.         
%   BTrained:       observation probability matrix at the output of the training stage.         
%   AllProb:        vector, each element of which contains the sum of
%                   scaled Viterbi scores of all observation sequences at each iteration.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


L=length(NumericData);
[M,N]=size(B);

theEpoch=1;
AllProb=[];
while theEpoch<=maxEpoch
    Atemp=zeros(N);
    Btemp=zeros(M,N);
    pitemp=zeros(N,1);
    i=1;
    while i<=L
        O=NumericData{i};
        [MatchingProb(i),BestPath]=VitDoHMMsc(pi_init,A,B,O);
        realPath=real(BestPath);
        for k=1:length(realPath)-1
            Atemp(realPath(k),realPath(k+1))=Atemp(realPath(k),realPath(k+1))+1;
        end
        for k=1:length(realPath)
            Btemp(O(k),realPath(k))=Btemp(O(k),realPath(k))+1;
        end
        pitemp(realPath(1))=pitemp(realPath(1))+1;
        i=i+1;
    end
    AllProb(theEpoch)=sum(MatchingProb); 
    if theEpoch>1 & AllProb(theEpoch)<=AllProb(theEpoch-1)
        break;
    end       
    theEpoch
    pi_init=pitemp/sum(pitemp);
    
    [N,N]=size(Atemp);
    for kkk=1:N
        Atemp(kkk,:)=Atemp(kkk,:)/sum(Atemp(kkk,:));
    end
    A=Atemp;
    
    [M,N]=size(Btemp);
    for kkk=1:N
        Btemp(:,kkk)=Btemp(:,kkk)/sum(Btemp(:,kkk));
    end
    B=Btemp;
    
    theEpoch=theEpoch+1;
end

piTrained=pi_init;
ATrained=A;
BTrained=B;
