function [ accuracy,precision,recall,measureF ] = KNN_crossvalidation( dataset  )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

len = size(dataset(:,1));
SIZE_ONE_BY_THREE  = floor(len(1)/3);
SIZE_TWO_BY_THREE  = SIZE_ONE_BY_THREE+SIZE_ONE_BY_THREE;

TrainingSet = dataset(randperm(SIZE_TWO_BY_THREE),:);
TestSet = dataset(randperm(SIZE_ONE_BY_THREE),:);

% perform operations with 5,10,15 neighbours respectively.
K = [ 5;10;15 ];

% 1 = manhattan
% 2 = euclidean
% 3 = chebychev
P = [ 1;2;3 ];

% Accuracy
%
%    1,1 ===>  K=5 with Manhattan  
%    1,2 ===>  K=5 with Euclidean  
%    1,3 ===>  K=5 with Chebychev 
%    2,1 ===>  K=10 with Manhattan  
%    2,2 ===>  K=10 with Euclidean  
%    2,3 ===>  K=10 with Chebychev  
%    3,1 ===>  K=15 with Manhattan  
%    3,2 ===>  K=15 with Euclidean  
%    3,3 ===>  K=15 with Chebychev  
%

Accuracy = zeros(3,3);



    %this loop will run 3 iterations since K has 3 values.
    for i=1:size(K(:,1),1)

        disp(['Partitioning into ',num2str(K(i,1)), ' Validation Sets ']);
        partitions = partition(TrainingSet,K(i,1));
        
        
        
        % we will get 3 accuracies. 5 Validations will be done
        % on euclidean,chebychev and manhattan.
        for o=1:3

            if o==1
                disp(['Manhattan Distance and K == ',num2str(K(i,1))]);
            elseif o==2
                disp(['Euclidean Distance and K == ',num2str(K(i,1))]);
            else
                disp(['Chebychev Distance and K == ',num2str(K(i,1))]);
            end
            % we will get 5 accuracies for K=5 and similarly for K=10 and
            % 15, so 5 rows will be initialized for K=5 and we will
            % caluclate and average of those 5 values to find out the final
            % accuracy and save it in Accuracy matrix.
            ValidationsAccuracy = zeros(K(i,1),1); 

            % since K=5 in first iteration it will loop out and get accuracy
            % for 5 validation sets.
            % for K = 10 it will loop out and get accuracy for 10 validation
            % sets and same goes for 15.
      
            for j=1:K(i,1)
            % this loop is for the distances. Euc, Cheb, Man or P=1,P=2,P=3
               ValidationsAccuracy(j,1) = KNN( TestSet, partitions{j,1} , P(o,1) , K(i,1) );
            end
            
            %K in rows, P in columns
            Accuracy(i,o) = mean(ValidationsAccuracy(:,1));
        end
    end
Accuracy

end

