% Example 7.5.5
% "Introduction to Pattern Recognition: A MATLAB Approach"
% S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

% 1. Generate X3
randn('seed',0)
m=[0 0; 10 0; 0 9; 9 8];
S(:,:,1)=eye(2);
S(:,:,2)=[1.0 .2; .2 1.5];
S(:,:,3)=[1.0 .4; .4 1.1];
S(:,:,4)=[.3 .2; .2 .5];
n_points=100*ones(1,4); %Number of points per group
X3=[];
for i=1:4
    X3=[X3; mvnrnd(m(i,:),S(:,:,i),n_points(i))];
end
X3=X3';

figure(1), plot(X3(1,:),X3(2,:),' b.')
figure(1), axis equal

% Compute J_m and plot J_m versus m
[l,N]=size(X3);
nruns=10;
m_min=2;
m_max=10;
J_m=[];
for m=m_min:m_max
    J_temp_min=inf;
    for t=1:nruns
        rand('seed',100*t)
        theta_ini=rand(l,m);
        [theta,bel,J]=k_means(X3,theta_ini);
        if(J_temp_min>J)
            J_temp_min=J;
        end
    end
    J_m=[J_m J_temp_min];
end
m=m_min:m_max;
figure(2), plot(m,J_m)

%%%%%%%% Repeat with the dataset of Example 7.5.2
randn('seed',0)
m=[0 0; 10 0; 0 9; 9 8];
S(:,:,1)=eye(2);
S(:,:,2)=[1.0 .2; .2 1.5];
S(:,:,3)=[1.0 .4; .4 1.1];
S(:,:,4)=[.3 .2; .2 .5];
n_points=100*ones(1,4); 
X3=[];
for i=1:4
    X3=[X3; mvnrnd(m(i,:),S(:,:,i),n_points(i))];
end
X3=X3';
% Generate the remaining 100 points
noise=rand(2,100)*14-2;
X3=[X3 noise];

% Plot the data set
figure(3), plot(X3(1,:),X3(2,:),'.b')
figure(3), axis equal

% Compute J_m and plot J_m versus m
[l,N]=size(X3);
nruns=10;
m_min=2;
m_max=10;
J_m=[];
for m=m_min:m_max
    J_temp_min=inf;
    for t=1:nruns
        rand('seed',100*t)
        theta_ini=rand(l,m);
        [theta,bel,J]=k_means(X3,theta_ini);
        if(J_temp_min>J)
            J_temp_min=J;
        end
    end
    J_m=[J_m J_temp_min];
end
m=m_min:m_max;
figure(4), plot(m,J_m)

%%%%%%%% Repeat with the dataset of Example 7.4.2
% Generate the required data set
randn('seed',0);
m=[0 0; 4 0; 0 4; 5 4];
S(:,:,1)=eye(2);
S(:,:,2)=[1.0 .2; .2 1.5];
S(:,:,3)=[1.0 .4; .4 1.1];
S(:,:,4)=[.3 .2; .2 .5];
n_points=100*ones(1,4); %Number of points per group
X3=[];
for i=1:4
    X3=[X3; mvnrnd(m(i,:),S(:,:,i),n_points(i))];
end
X3=X3';

% Plot the data set
figure(5), plot(X3(1,:),X3(2,:),'.b')
figure(5), axis equal

% Compute J_m and plot J_m versus m
[l,N]=size(X3);
nruns=10;
m_min=2;
m_max=10;
J_m=[];
for m=m_min:m_max
    J_temp_min=inf;
    for t=1:nruns
        rand('seed',100*t)
        theta_ini=rand(l,m);
        [theta,bel,J]=k_means(X3,theta_ini);
        if(J_temp_min>J)
            J_temp_min=J;
        end
    end
    J_m=[J_m J_temp_min];
end
m=m_min:m_max;
figure(6), plot(m,J_m)


%%%%%%%% Repeat with the dataset of Exercise 7.5.1
% Generate the required data set
randn('seed',0);
m=[0 0];
S(:,:,1)=eye(2);
n_points=300; %Number of points per group
X3=mvnrnd(m,S(:,:,i),n_points)';
% Plot the data set
figure(7), plot(X3(1,:),X3(2,:),'.b')
figure(7), axis equal


% Compute J_m and plot J_m versus m
[l,N]=size(X3);
nruns=10;
m_min=2;
m_max=10;
J_m=[];
for m=m_min:m_max
    J_temp_min=inf;
    for t=1:nruns
        rand('seed',100*t)
        theta_ini=rand(l,m);
        [theta,bel,J]=k_means(X3,theta_ini);
        if(J_temp_min>J)
            J_temp_min=J;
        end
    end
    J_m=[J_m J_temp_min];
end
m=m_min:m_max;
figure(8), plot(m,J_m)

