function centroids = computeCentroids(X, idx, K)
%COMPUTECENTROIDS returns the new centroids by computing the means of the 
%data points assigned to each centroid.
%   centroids = COMPUTECENTROIDS(X, idx, K) returns the new centroids by 
%   computing the means of the data points assigned to each centroid. It is
%   given a dataset X where each row is a single data point, a vector
%   idx of centroid assignments (i.e. each entry in range [1..K]) for each
%   example, and K, the number of centroids. You should return a matrix
%   centroids, where each row of centroids is the mean of the data points
%   assigned to it.
%

% Useful variables
[m n] = size(X);

% You need to return the following variables correctly.
centroids = zeros(K, n);


% ====================== YOUR CODE HERE ======================
% Instructions: Go over every centroid and compute mean of all points that
%               belong to it. Concretely, the row vector centroids(i, :)
%               should contain the mean of the data points assigned to
%               centroid i.
%
% Note: You can use a for-loop over the centroids to compute this.
%
tpx = zeros(m,1);
tpy = zeros(m,1);
summ = zeros(m,1);
for i = 1 : m
    tpx(idx(i)) = tpx(idx(i)) +  X(i,1);
    tpy(idx(i)) = tpy(idx(i)) + X(i,2);
    summ(idx(i)) = summ(idx(i)) + 1;
end

for i = 1 : K
%     tpx(i)
%     tpy(i)
%     summ(i)
    centroids(i,1) = tpx(i)/summ(i);
    centroids(i,2) = tpy(i)/summ(i);
end




% =============================================================


end

