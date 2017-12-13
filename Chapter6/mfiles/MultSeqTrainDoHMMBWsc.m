function [piTrained, ATrained, BTrained, AllProb] = MultSeqTrainDoHMMBWsc(pi_init, A, B, NumericData, maxEpoch)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [piTrained, ATrained, BTrained, AllProb] = MultSeqTrainDoHMMBWsc(pi_init, A, B, NumericData, maxEpoch)
% Baum-Welch training (scaled version) of a Discrete Observation HMM, given multiple training sequences.
%
% INPUT ARGUMENTS:
%   pi_init:        vector of initial state probalities upon initialization.
%   A:              state transition matrix upon initialization. The sum of each row equals 1.
%   B:              observation probability matrix upon initialization. The sum of each columns equals 1.
%   NumericData:    vector of cells, where each cell contains an observation sequence.
%   maxEpoch:       maximum number of iterations during training.
%
% OUTPUT ARGUMENTS:
%   piTrained:      vector of initial state probalities at the output of
%                   the training stage.
%   ATrained:       state transition matrix at the output of the training stage.         
%   BTrained:       observation probability matrix at the output of the training stage.         
%   AllProb:        vector, each element of which contains the sum of
%                   scaled recognition probabilities of all observation sequences at each epoch.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[M,N]=size(B);

K=length(NumericData);
epoch=1;
curProb=-inf;
AllProb=[];
while epoch<=maxEpoch    
    for k=1:K
        O=NumericData{k};
        T=length(O);
        [alpha{k},beta{k},c{k},P(k),ksi{k},gamma{k}] =TrainDOHMMBaumWelch_Single_Seq_variables(pi_init, A, B, O);
        [Anum{k}, Adenum{k}, Bnum{k}, Bdenum{k}] =TrainDOHMMBaumWelch_Single_Seq_reest_variables(M,N,T,O,gamma{k},ksi{k});
    end
    
    for i=1:N
        pi_init_hat(i,1)=0;
        for k=1:K
            pi_init_hat(i,1) = pi_init_hat(i,1) + gamma{k}(1,i);
        end
    end
    pi_init_hat=pi_init_hat/sum(pi_init_hat(:,1));
    
    for i=1:N
        for j=1:N
            A_hat_num(i,j)=0;
            A_hat_denum(i,j)=0;
            for k=1:K
                A_hat_num(i,j)=A_hat_num(i,j) + (1/P(k))*Anum{k}(i,j);
                A_hat_denum(i,j)=A_hat_denum(i,j) + (1/P(k))*Adenum{k}(i);
            end
            A_hat(i,j)=A_hat_num(i,j)/A_hat_denum(i,j);
        end
    end
    
    for m=1:M
        for j=1:N
            B_hat_num(m,j)=0;
            B_hat_denum(m,j)=0;
            for k=1:K
                B_hat_num(m,j)=B_hat_num(m,j) + (1/P(k))*Bnum{k}(m,j);
                B_hat_denum(m,j)=B_hat_denum(m,j) + (1/P(k))*Bdenum{k}(j);
            end
            B_hat(m,j)=B_hat_num(m,j)/B_hat_denum(m,j);
        end
    end
    
    if sum(P)<=curProb        
        break;
    else
        epoch
        AllProb=[AllProb sum(P)];
        curProb=sum(P);        
    end
    pi_init=pi_init_hat;
    A=A_hat;
    B=B_hat;
    epoch=epoch+1;
end

piTrained=pi_init; ATrained=A; BTrained=B;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [alpha,beta,c,P,ksi,gamma] = TrainDOHMMBaumWelch_Single_Seq_variables(pi_init, A, B, O)

[M,N]=size(B);
T=length(O);
% alpha variable
alpha(1,:)=B(O(1),:)'.*pi_init;
c(1)=1/sum(alpha(1,:));
alpha(1,:)=c(1)*alpha(1,:);

for t=1:T-1
    for j=1:N
        alpha(t+1,j)=B(O(t+1),j)*sum(alpha(t,:).*A(:,j)');
    end
    c(t+1)=1/sum(alpha(t+1,:));
    alpha(t+1,:)=c(t+1)*alpha(t+1,:);
end


P=-sum(log10(c));

% beta variable
beta(T,1:N)=1;
beta(T,:)=beta(T,:)*c(T);

for t=T-1:-1:1
    for i=1:N
        beta(t,i)=sum(A(i,:).*B(O(t+1),:).*beta(t+1,:));
    end
    beta(t,:)=c(t)*beta(t,:);
end


% ksi variable
for t=1:T-1
    denum=0;
    for i=1:N
        for j=1:N
            denum=denum+alpha(t,i)*A(i,j)*B(O(t+1),j)*beta(t+1,j);
        end
    end
    
    for i=1:N
        for j=1:N
            ksi(t,i,j)=(alpha(t,i)*A(i,j)*B(O(t+1),j)*beta(t+1,j))/denum;
        end
    end
    
end

% gamma variable
for t=1:T-1
    for i=1:N
        gamma(t,i)=0;
        for j=1:N
            gamma(t,i)=gamma(t,i)+ksi(t,i,j);
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Anum, Adenum, Bnum, Bdenum] =TrainDOHMMBaumWelch_Single_Seq_reest_variables(M,N,T,O,gamma,ksi)
% reesetimation


for i=1:N
    for j=1:N
        Adenum(i)=0;
        for t=1:T-1
            Adenum(i)=Adenum(i)+gamma(t,i);
        end

        Anum(i,j)=0;
        for t=1:T-1
            Anum(i,j)=Anum(i,j)+ksi(t,i,j);
        end
    end
end

for j=1:N
    for k=1:M
        Bdenum(j)=0;
        for t=1:T-1
            Bdenum(j)=Bdenum(j)+gamma(t,j);
        end

        Bnum(k,j)=0;
        for t=1:T-1
            if O(t)==k
                Bnum(k,j)=Bnum(k,j)+gamma(t,j);
            end
        end
    end
end
