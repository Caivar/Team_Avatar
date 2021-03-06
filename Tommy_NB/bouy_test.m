spmatrix2 = train_x(perm(1:100),:);
category = train_t(perm(1:100));

testMatrix = full(spmatrix2);
numTestDocs = size(testMatrix, 1);
numTokens = size(testMatrix, 2);

output = zeros(numTestDocs, 1);

%---------------
% YOUR CODE HERE
[n,m] = size(spmatrix2);
for row = 1:n
    p = zeros(6,1);
    for color =1:6
        for col = 1:m
            p(color) = p(color) + log(colorratio(color,col));
        end;
        p(color)= p(color)+log(ratiocolor(color));
    end;
    [k, l] = max(p);
    output(row,1) = l;
end;
%---------------


% Compute the error on the test set
error=0;
for i=1:numTestDocs
  if (category(i) ~= output(i))
    error=error+1;
  end
end

%Print out the classification error on the test set
error/numTestDocs



