% Example 7.4.2
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

close('all');
clear

% 1. Generate the required data set
randn('seed',0);
m=[0 0; 4 0; 0 4; 5 4];
S(:,:,1)=eye(2);
S(:,:,2)=[1.0 .2; .2 1.5];
S(:,:,3)=[1.0 .4; .4 1.1];
S(:,:,4)=[.3 .2; .2 .5];
n_points=100*ones(1,4); %Number of points per group
X1=[];
for i=1:4
    X1=[X1; mvnrnd(m(i,:),S(:,:,i),n_points(i))];
end
X1=X1';

% Plot the data set
figure(1), plot(X1(1,:),X1(2,:),'.b')
figure(1), axis equal

% 2. To estimate the number of clusters we proceed as follows:
%(a) Determine the minimum and the maximum distances between points of X1
[l,N]=size(X1);
dista=zeros(N,N);
for i=1:N
    for j=i+1:N
        dista(i,j)=sqrt(sum((X1(:,i)-X1(:,j)).^2));
        dista(j,i)=dista(i,j);
    end
end
true_maxi=max(max(dista));
true_mini=min(dista(~logical(eye(N))));

% (b) Determine min, max and s
meani=(true_mini+true_maxi)/2;
theta_min=.25*meani;
theta_max=1.75*meani;
n_theta=50;
s=(theta_max-theta_min)/(n_theta-1);

% (c) Run ntimes the BSAS for each value of theta each time with different
% ordering of the data
q=N;
n_times=10;
m_tot=[];
for theta=theta_min:s:theta_max
    list_m=zeros(1,q);
    for stat=1:n_times   %for each value of Theta BSAS runs n_times times
        order=randperm(N);
        [bel, m]=BSAS(X1,theta,q,order);
        list_m(size(m,2))=list_m(size(m,2))+1;
    end
    [q1,m_size]=max(list_m);
    m_tot=[m_tot m_size];
end

% (d) Plot m versus theta (see Figure 7.3(a))
theta_tot=theta_min:s:theta_max;
figure(2), plot(theta_tot,m_tot)

% Determine the final estimate of the number of clusters and the corresponding, as it is
% previously described
m_best=0;
theta_best=0;
siz=0;
for i=1:length(m_tot)
    if(m_tot(i)~=1) %Excluding the single-cluster clustering
        t=m_tot-m_tot(i);
        siz_temp=sum(t==0);
        if(siz<siz_temp)
            siz=siz_temp;
            theta_best=sum(theta_tot.*(t==0))/sum(t==0);
            m_best=m_tot(i);
        end
    end
end
%Check for the single-cluster clustering
if(sum(m_tot==m_best)<.1*n_theta)
    m_best=1;
    theta_best=sum(theta_tot.*(m_tot==1))/sum(m_tot==1);
end


% 3. Run the BSAS algorithm for theta_best
order=randperm(N);
[bel, repre]=BSAS(X1,theta_best,q,order);

% Plot the results (see Figure 7.3(b))
figure(11), hold on
figure(11), plot(X1(1,bel==1),X1(2,bel==1),'r.',...
    X1(1,bel==2),X1(2,bel==2),'g*',X1(1,bel==3),X1(2,bel==3),'bo',...
    X1(1,bel==4),X1(2,bel==4),'cx',X1(1,bel==5),X1(2,bel==5),'md',...
    X1(1,bel==6),X1(2,bel==6),'yp',X1(1,bel==7),X1(2,bel==7),'ks')
figure(11), plot(repre(1,:),repre(2,:),'k+')

% 4. Run the reassignment procedure
[bel,new_repre]=reassign(X1,repre,order);

% To plot the results work as in the previous step (see Figure 7.3(c)). By
% comparing the results obtained by the current and the previous step, the
% influence of the reassignment procedure on the results becomes apparent.

figure(12), hold on
figure(12), plot(X1(1,bel==1),X1(2,bel==1),'r.',...
    X1(1,bel==2),X1(2,bel==2),'g*',X1(1,bel==3),X1(2,bel==3),'bo',...
    X1(1,bel==4),X1(2,bel==4),'cx',X1(1,bel==5),X1(2,bel==5),'md',...
    X1(1,bel==6),X1(2,bel==6),'yp',X1(1,bel==7),X1(2,bel==7),'ks')
figure(12), plot(new_repre(1,:),new_repre(2,:),'k+')
