%% Diffusion Limited Aggregation - KP
clear all
close all
clc

%% Initialisation
size = 101;                     % Size of matrix
mat = zeros(size,size);         % Zeros matrix
mat(51,51) = 1;                 % Centre of DLA
n = 0; 

%% Simulation
while(n<200)                            % No. of particles
    theta = 2*pi*rand;                  % Random particle on edge of circle
    x = ceil(51 + 30*cos(theta));   
    y = ceil(51 + 30*sin(theta)); 
    while(1)
        neig = [x-1 y+1; x y+1; x+1 y+1; x-1 y;...
            x+1 y; x-1 y-1; x y-1; x+1 y-1];    % Immediate neighbours
        r = randi([1,8]);                       % Random movement
        x = neig(r,1); 
        y = neig(r,2); 
        if (x-51)^2 + (y-51)^2 > 901            % Boundary condition
            break
        end
        % Conditions for attachment
        if mat(x-1, y+1)==1
            mat(x,y) = 1;
            n = n+1;
            break
        end
        if mat(x, y+1)==1
            mat(x,y) = 1;
            n = n+1;
            break
        end
        if mat(x+1, y+1)==1
            mat(x,y) = 1;
            n = n+1;
            break
        end
        if mat(x-1, y)==1
            mat(x,y) = 1;
            n = n+1;
            break
        end
        if mat(x+1, y)==1
            mat(x,y) = 1;
            n = n+1;
            break
        end
        if mat(x-1, y-1)==1
            mat(x,y) = 1;
            n = n+1;
            break
        end
        if mat(x, y-1)==1
            mat(x,y) = 1;
            n = n+1;
            break
        end
        if mat(x+1, y-1)==1
            mat(x,y) = 1;
            n = n+1;
            break
        end
    end
    % Visualising the growth
    if mod(n,20)==0
        a = n/20; 
        imwrite(not(mat), strcat('DLA_aniso', num2str(a), '.png')); % Saving image
    end
end
