%% Voronoi Tesselation 
clear all
close all 
clc

%% Input arguments 
size = input('Enter size of grid: ');
no = input('Enter number of grains: ');
v_x = input('Enter velocity in x-direction: ');
v_y = input('Enter velocity in y-direction: '); 
freq = input('Enter frequency of steps: ');

%% Initialisation
gr_id = zeros(size, size); 
x = [];
y = [];
xy = [x(:),y(:)];
XY = zeros(9*no, 3);

%% Random nuclei generation
i = 1;
while i<(no+1)
    x1 = randi(size); 
    y1 = randi(size);
    li = ismember(xy, [x1, y1], 'rows');
    if (sum(li)==0)
        xy(i,1) = x1;
        xy(i,2) = y1; 
        gr_id(x1,y1) = i; % Assigning grain ids
        i = i+1;
    end
end

%% Extending the nucleation
n=1;
for i = 1:no
    for j = -1:1
        for k = -1:1
            XY(n,1) = i;
            XY(n,2) = xy(i,1)+(size*j);
            XY(n,3) = xy(i,2)+(size*k);
            n = n + 1 ;
        end
    end
end

%% Subdivision by minimum distance
for x1 = 1:size
    for y1 = 1:size
        min_dist = 8*(n^2);
        for z = 1:(9*no)
            dist = (((x1-XY(z,2))/(v_y*freq)).^2)+ (((y1-XY(z,3))/(v_x*freq)).^2);
            if (min_dist>dist)
                min_dist = dist;
                gr_id(x1,y1) = XY(z,1);
            end
        end
    end
end
%% Preview the microstructure
figure(1); imagesc(gr_id); 
colorbar; 
title('Generated 2D Microstructure');

