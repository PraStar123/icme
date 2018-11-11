%% Simulations from KObayashi paper - KP
%% Created on 01 Nov 2018
%% Parameters same as in Kobayashi paper
%% Simulated for K = 0.8, 0.9, 1.0, 1.1, 1.2, 1.4, 1.6, 1.8, 2.0
clear all 
close all
clc

%% Initialisation of parameters
size = 300;
eps = 0.01;
tau = 0.0003;
alpha = 0.9;
a = 0.01;
gamma = 10.0;
dt = 0.0002;
dx = 0.03;
dy = 0.03; 
teqbm = 1; 
k = 1.6;

%% Initialisation of problem
t = zeros(size,size);
p = zeros(size,size);
p(:,1:10) = 1; 
 
%% Simulations
for time = 1:5000
    for i = 2:size-1
        for j = 2:size-1
            m = (alpha/pi)*atan(gamma*(teqbm-t(i,j)));
            p2(i,j) = p(i,j) + dt*(eps^2)*(p(i+1,j) + p(i-1,j) + p(i,j+1) + p(i,j-1) - 4*p(i,j))/(tau*dx^2) + dt*(p(i,j)*(1-p(i,j))*(p(i,j) - 0.5 + m))/tau + a*p(i,j)*(1-p(i,j))*(rand - 0.5);
            t2(i,j) = t(i,j) + dt*(t(i+1,j) + t(i-1,j) + t(i,j+1) + t(i,j-1) - 4*t(i,j))/dx^2 + k*(p2(i,j) - p(i,j));
        end
    end
    p2(1,:) = p2(2,:);
    p2(:,1) = p2(:,2);
    p2(size,:) = p2(size-1,:);
    p2(:,size) = p2(:,size-1);
    t2(1,:) = t2(2,:);
    t2(:,1) = t2(:,2);
    t2(size,:) = t2(size-1,:);
    t2(:,size) = t2(:,size-1);
    p = p2;
    t = t2;

    if(mod(time,10)==0)
        h = pcolor(p2); title('K = 1.6')
        set(h, 'EdgeColor', 'none'); 
        pause(1);
    end
end
    





