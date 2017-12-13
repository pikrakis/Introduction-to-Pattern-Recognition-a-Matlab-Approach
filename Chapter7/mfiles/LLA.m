function [w,bel,epoch]=LLA(X,w_ini,m,eta_vec,sed,max_epoch,e_thres,init_proc)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%  [w,bel,epoch]=LLA(X,w_ini,m,eta_vec,sed,max_epoch,e_thres, init_proc)
% This function implements the competitive leaky learning algorithm. The
% basic competitive learning scheme follows as a special case of the
% leaky learning algortihm when "leakage" (learning parameter for the
% losers) is set to 0. 
% IMPORTANT NOTE: In this implementation, (a) the vectors are presented
% in random order within each epoch and (b) the termination condition of
% the  algorithm is (i) "||w_current-w_previous||<e_thres", where
% "e_thres" is small positive constant or (ii) the maximum number of
% iterations is reached.  
%
% INPUT ARGUMENTS:
%  X:       lxN matrix, containing the data vectors in its columns. 
%  w_ini:   lxm matrix, each column of which contains an
%           initial estimate of the representatives. If it is empty, the
%           initialization is carried out automatically.
%  m:       the number of representatives (which should be equal to the
%           number of clusters). This is utilized only when w_ini is empty.
%  eta_vec: a two-dimensional vector, whose first component is the
%           updating parameter for the representative that wins while its 
%           second component is the updating parameter for all the rest
%           representatives (losers).
%  sed:     the ``seed'' for the built-in MATLAB function ``rand''.
%  max_epoch:   the maximum number of epochs, the algorithm is allowed to
%               run.
%  e_thres:     a (scalar) parameter used in the termination condition.
%  init_proc:   an integer taking values "1", "2" or "3" with 
%               - "1" corresponding to "rand_init" initialization procedure
%                (this procedure chooses randomly m vectors from the
%                smallest hyperrectangular that contains all the vectors of
%                X and its sides are parallel to the axes).
%               - "2" corresponding to "rand_data_init" (this procedure
%                chooses randomly m vectors among the vectors of X) and 
%               - "3" corresponding to "distant_init" (this procedure
%                chooses the m vectors of X that are "most distant" from
%                each other. This is a more computationally demanding
%                procedure). This choice is activated only if the user does
%                not give himself the initial conditions. 
%
% OUTPUT ARGUMENTS:
%  w:       lxm matrix containing in its columns the final
%           estimates of the representatives.
%  bel:     N-dimensional vector, whose i-th element contains the index
%           of the closest to xi representative.
%  epochs:  number of epochs required for convergence.
%
% (c) 2010 S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    [l,N]=size(X);
    if isempty(w_ini)
        if(init_proc==1)
            w_ini=rand_init(X,m,sed);
        elseif(init_proc==2)
            w_ini=rand_data_init(X,m,sed);
        else
            w_ini=distant_init(X,m,sed);
        end
    else
        [l,m]=size(w_ini);
    end
    
    w=w_ini;
    bel=zeros(1,N);

    e=1;
    
    epoch=0;
    while (e>0)&(epoch<max_epoch)
        epoch=epoch+1;
        w_old=w;
        a=randperm(N);
        for i=1:N
            temp=[];
            for j=1:m
                temp=[temp; distan(X(:,a(i)),w(:,j))];
            end
            [q1,q2]=min(temp);
            bel(a(i))=q2;
            
            % Update for the winner
            w(:,q2)=w(:,q2)+eta_vec(1)*(X(:,a(i))-w(:,q2));
            % Update for the rest representatives
            for j=1:m
                if(j~=q2)
                    w(:,j)=w(:,j)+eta_vec(2)*(X(:,a(i))-w(:,j));
                end
            end
        end
        e=(sum(sum(abs(w-w_old)))>e_thres);
    end
    
    %Definition of the final hard clustering
    for j=1:m
        for i=1:N
            temp(i,j)=distan(X(:,i),w(:,j));
        end
    end
    if(m==1)
        bel=ones(1,N);
    else
        [qw,bel]=min(temp');
    end    