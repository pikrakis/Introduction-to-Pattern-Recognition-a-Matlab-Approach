function [piTrained, ATrained, BTrained, AllProb]=MultSeqTrainCoHMMBWsc(pi_init, A, B, NumericData, maxEpoch)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [piTrained, ATrained, BTrained, AllProb]=MultSeqTrainCoHMMBWsc(pi_init, A, B, NumericData, maxEpoch)
% Implements scaled  Baum-Welch training for
% continuous-observation HMMs, for the case of l-dimensional observations
% (l-dimensional feature vectors). It is assumed that the observation pdf at each state
% is a Gaussian mixture.
%
% INPUT ARGUMENTS:
%   pi_init:        vector of initial state probalities.
%   A:              state transition matrix. The sum of each row equals 1.
%   B:              B can be:
%                   (a) a 2xN standard array, where N is the number of
%                   states. This case deals with 1-dimensional
%                   observations, i.e.,
%                   B(1,i) contains the mean value and B(2,i) the standard
%                   deviation of the Gaussian that describes the 1-dimensional
%                   pdf of the respective state observations.
%                   (b) a 3xN cell array, where N is the number of states.
%                   In this case, the pdf at each state is a gaussian
%                   mixture and the observations are l-dimensional feature
%                   vectors. Specifically: B{1,i} is a lxc matrix, whose columns contain the means of
%                   the normal distributions involved in the mixture,
%                   B{2,i} is a lxlxc matrix where S(:,:,k) is the covariance
%                   matrix of the k-th normal distribution of the mixture
%                   and B{3,i} is a c-dimensional vector containing the mixing probabilities for
%                   the distributions of the mixture at the i-the state.
%   NumericData:    vector of cells, where each cell contains a sequence of
%                   l-dimensional feature vectors
%   maxEpoch:       maximum number of iterations during training.
%
% OUTPUT ARGUMENTS:
%   piTrained:      vector of initial state probalities at the output of
%                   the training stage. In this implementation
%                   piTrained=pi_init.
%   ATrained:       state transition matrix at the output of the training stage.
%   BTrained:       has the structure of input argument B and holds the respective
%                   values at the end of the training stage.
%   AllProb:        vector, each element of which contains the sum of
%                   scaled recognition probabilities of all observation sequences at each epoch.
%
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[N,N]=size(A);
K=length(NumericData);

the_epoch=1;
while (the_epoch<=maxEpoch)
    % forward variable (alpha)
    for k=1:K
        O=NumericData{k};
        T=size(O,2);
        alpha{k}=zeros(N,T);
        % Initialization
        for i=1:N
            alpha{k}(i,1)=pi_init(i)*mixt_value(B{1,i},B{2,i},B{3,i},O(:,1));
        end
        c{k}(1)=1/sum(alpha{k}(:,1));
        alpha{k}(:,1)=alpha{k}(:,1)*c{k}(1);
        
        % Induction
        for t=1:T-1
            for j=1:N
                alpha{k}(j,t+1)=sum(alpha{k}(:,t).*A(:,j))*mixt_value(B{1,j},B{2,j},B{3,j},O(:,t+1));
            end
            c{k}(t+1)=1/(sum(alpha{k}(:,t+1)));
            alpha{k}(:,t+1)=alpha{k}(:,t+1)*c{k}(t+1);
        end
        
        % Termination
        P(k)=-sum(log10(c{k}));
    end
    
    % backward variable (beta)
    for k=1:K
        O=NumericData{k};
        T=size(O,2);
        beta{k}=zeros(N,T);
        % Initialization
        beta{k}(:,T)=1;
        beta{k}(:,T)=beta{k}(:,T)*c{k}(T);
        % Induction
        for t=T-1:-1:1
            for i=1:N
                beta{k}(i,t)=0;
                for j=1:N
                    beta{k}(i,t)=beta{k}(i,t)+ A(i,j)*mixt_value(B{1,j},B{2,j},B{3,j},O(:,t+1))*beta{k}(j,t+1);
                end
            end
            beta{k}(:,t)=beta{k}(:,t)*c{k}(t);
        end
    end
    
    % gamma variable
    for d=1:K
        O=NumericData{d};
        T=size(O,2);
        for j=1:N
            for t=1:T
                for k=1:size(B{1,j},2)
                    term1 = (alpha{d}(j,t)*beta{d}(j,t))/sum(alpha{d}(:,t).*beta{d}(:,t));
                    term2 = (B{3,j}(k)*mvnpdf(O(:,t),B{1,j}(:,k),B{2,j}(:,:,k)))/ ...
                        mixt_value(B{1,j},B{2,j},B{3,j},O(:,t));
                    gamma{d}(j,k,t)=term1*term2;
                end
            end
        end
    end
    
    
    AllProb(the_epoch)=sum(P);
    if the_epoch>1
        if AllProb(the_epoch)<=AllProb(the_epoch-1)
            Atrained=A;
            BTrained=B;
            piTrained=pi_init;
            break;
        end
    end
    
    % Re-estimation starts here
    % Re-estimate A
    for i=1:N
        % denominator
        den=0;
        for k=1:K
            O=NumericData{k};
            T=size(O,2);
            for t=1:T-1
                for j=1:N
                    den=den+(1/P(k))*alpha{k}(i,t)*A(i,j)*mixt_value(B{1,j},B{2,j},B{3,j},O(:,t+1))*beta{k}(j,t+1);
                end
            end
        end
        %numerator
        for j=1:N
            num=0;
            for k=1:K
                O=NumericData{k};
                T=size(O,2);
                suma=0;
                for t=1:T-1
                    suma=suma+alpha{k}(i,t)*A(i,j)*mixt_value(B{1,j},B{2,j},B{3,j},O(:,t+1))*beta{k}(j,t+1);
                end
                num=num+suma/P(k);
            end
            ATrained(i,j)=num/den;
        end
    end
    
    % Re-estimate B for each state and each mixture component
    for j=1:N
        for k=1:size(B{1,j},2)
            num1=0;
            den1=0;
            num2=0;
            num3=0;
            for d=1:K
                O=NumericData{d};
                T=size(O,2);
                for t=1:T
                    num1 = num1+gamma{d}(j,k,t)/P(d);
                    num2 = num2+gamma{d}(j,k,t)*O(:,t)/P(d);
                    num3 = num3+(1/P(d))*gamma{d}(j,k,t)*(O(:,t)-B{1,j}(:,k))*(O(:,t)-B{1,j}(:,k))';
                    for m=1:size(B{1,j},2)
                        den1 = den1 + gamma{d}(j,m,t)/P(d);
                    end
                end
            end
            den2=num1;
            den3=den2;
            BTrained{1,j}(:,k)=num2/den2;
            BTrained{2,j}(:,:,k)=num3/den3;
            BTrained{3,j}(k)=num1/den1;
        end
    end
    
    piTrained=pi_init;
    A=ATrained;
    B=BTrained;
    pi_init=piTrained;
    the_epoch=the_epoch+1;
end

