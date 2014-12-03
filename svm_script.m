%addpath('liblinear-1.94/matlab');  % add LIBLINEAR to the path
addpath('libsvm-3.20/matlab');  % add LIBSVM to the path
addpath('libsvm-3.20/libsvm-weights-3.18/matlab');  % add LIBSVM to the path

load('svmweights.mat');
load('datasvm.mat');
N = length(train_t);
perm = randperm(N);
split = 1400;
train_x = train_x(perm,:);
train_t = train_t(perm);
weight_vec = weight_vec(perm);
weight_vec = weight_vec(1:split);
weight_vec = ones(split, 1);
red_train_t = train_t(1:split);
red_test_t = train_t(split+1:end);
train_x_split = train_x(1:split, :);
test_x = train_x(split+1:end, :);

isBinaryClassification = false; %edit here for portability


%% Binary

if isBinaryClassification
    
    color = 3;
    disp(['Testing color: ', colorToText(color)]);
    
    num_in_test = 0;
    num_in_train = 0;
    for i=1:split
        if (red_train_t(i) ~= color)
            red_train_t(i) = -1;
        else
            red_train_t(i) = 1;
            num_in_train = num_in_train + 1;
        end
    end
    
    for i=1:N-split
        if (red_test_t(i) ~= color)
            red_test_t(i) = -1;
        else
            red_test_t(i) = 1;
            num_in_test = num_in_test + 1;
        end
    end

end

%% Multiclass

if ~isBinaryClassification

    disp('Multiclass');
    
    
    %red_train_t = train_t(perm(1:split));
    %red_test_t = train_t(perm(split+1:end));
    
    red_train_t = train_t(1:split);
    red_test_t = train_t(split+1:end);

end
%% GOGOGOGO

classifier = svmtrain(weight_vec, red_train_t, sparse(train_x_split), '-t 0');
% debug
svmpredict(red_train_t, sparse(train_x_split), classifier);
[predicted_label, accuracy, ~] = ...
    svmpredict(red_test_t, sparse(test_x), classifier);

%{
% output indices with errors - only makes sense for binary
disp('Misclassified examples: ');
indices = find(abs(predicted_label - red_test_t) ~= 0); % for actual indices, + split

if isBinaryClassification
    
    errorType = zeros(numel(indices),1);
    for i=1:numel(indices)
        if predicted_label(indices(i)) == 1
            errorType(i) = 1; % false positive
        else
            errorType(i) = 0; % false negative
        end
    end
    
    [indices+split, errorType];
    
else
    indices+split;

end




%}
