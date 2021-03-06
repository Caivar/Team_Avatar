function plotColorHistogram(hist, figureHandle, subplotHandle)
%UNTITLED Summary of this function goes here
%   hist is an N x N x N matrix
%   N =< 256

N = size(hist,1);
multiple = 256/N;
scale = 100;

% positive values as normal colors
linearIndices = find(hist > 0);
[x, y, z] = ind2sub([N, N, N], linearIndices);
x = multiple*x;
y = multiple*y;
z = multiple*z;
figure(figureHandle);
subplotHandle;
warning('off','all')
scatter3(x,y,z,scale*hist(linearIndices),[x, y, z]/256, 'filled');
hold on;

% negative values as inverse
linearIndices = find(hist < 0);
[x, y, z] = ind2sub([N, N, N], linearIndices);
x = multiple*x;
y = multiple*y;
z = multiple*z;
figure(figureHandle);
subplotHandle;
warning('off','all')
scatter3(x,y,z,scale*-hist(linearIndices),1-[x, y, z]/256, 'filled');
hold off;

xlabel('R');
ylabel('G');
zlabel('B');
xlim([0, 256]);
ylim([0, 256]);
zlim([0, 256]);

end

