function [cost, grad] = softmaxCost(theta, numClasses, inputSize, lambda, data, labels)

% numClasses - the number of classes 
% inputSize - the size N of the input vector
% lambda - weight decay parameter
% data - the N x M input matrix, where each column data(:, i) corresponds to
%        a single test set
% labels - an M x 1 matrix containing the labels corresponding for the input data
%

% Unroll the parameters from theta
theta = reshape(theta, numClasses, inputSize);

numCases = size(data, 2);
groundTruth = zeros(numClasses,numCases);
for iter = 1:numCases
    if labels(iter)~=0
        groundTruth(labels(iter),iter)=1;
    end
end
%groundTruth = full(sparse(labels, 1:numCases, 1));
cost = 0;

thetagrad = zeros(numClasses, inputSize);

%% ---------- YOUR CODE HERE --------------------------------------
%  Instructions: Compute the cost and gradient for softmax regression.
%                You need to compute thetagrad and cost.
%                The groundTruth matrix might come in handy.

m = numCases;

phidata = theta * data;
phidata = bsxfun(@minus, phidata, max(phidata));

sum_exp_phidata = sum(exp(phidata));
p = bsxfun(@rdivide, exp(phidata), sum_exp_phidata);
cost = (-1/m) * sum(sum(groundTruth .* log(p))) + (lambda / 2) * sum(sum(theta .^2));

thetagrad = (-1/m) * (groundTruth - p) * data' + lambda * theta;



% ------------------------------------------------------------------
% Unroll the gradient matrices into a vector for minFunc
grad = [thetagrad(:)];
end

