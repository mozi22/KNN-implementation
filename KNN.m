function [ accuracy,precision,recall,measureF ] = KNN( TestSet, TrainingSet , distance_metric_power_value , K )
%UNTITLED Summary of this function goes here
% Detailed explanation goes here
% source about the different distances 
% http://lyfat.wordpress.com/2012/05/22/euclidean-vs-chebyshev-vs-manhattan-distance/

%   distance_metric_power_value = this parameter can be used to specify
%   the type of distance_metric we want to use for our algorithm.
%   if distance_metric_power_value = 2 ( Euclidean distance )
%   if distance_metric_power_value = 1 ( Manhattan distance )
%   if distance_metric_power_value = inf ( chebyshev distance )

% Exercise 6.1


TrainingSetRows = size(TrainingSet,1);


TestSetRows     = size(TestSet,1);
TestSetColumns  = size(TestSet,2);


% considering chebychev initially, we're creating a matrix for K and
% chebychev selects the max value.
distance = 1:(TestSetColumns-1);
distance = transpose(distance);

    for i = 1:TestSetRows
            
        for j = 1:TrainingSetRows
            
           if distance_metric_power_value == 1 || distance_metric_power_value == 2 
               %override if we're talking about euclidean or manhattan
               distance = 0;
           end
           
            % TestSetColumns-1 because we're not considering the third column
            % which contains classes
            for k=1:(TestSetColumns-1) 
                if distance_metric_power_value == 1 || distance_metric_power_value == 2 
                    % manhattan or euclidean distance. ( suming up )
                    distance = distance + ((TestSet(i,k) - TrainingSet(j,k)).^distance_metric_power_value);
                else
                    %in chebychev distance ( selecting the max )
                    distance(k,1) = ((TestSet(i,k) - TrainingSet(j,k)).^distance_metric_power_value);
                end
            end;

            % 4th column is for the distances for trainingInstances
            if distance_metric_power_value == 1
                %manhattan - adds distances only.
                TrainingSet(j,4) = distance;
            elseif distance_metric_power_value == 2
                %euclidean - adds distances and takes sqrt.
                TrainingSet(j,4) = sqrt(distance);
            else
                %chebychev - selects max value from all distances.
                TrainingSet(j,4) = max(distance);
            end
            
            
        end; % trainingSet
        
        % Now we got all the trainingSet distances for a single instance 
        % of testSet we've to select the 'k' least distances, where k=5.
        % sorting rows by 4th col, since that col contains the distance
        % values.
        TrSSorted = sortrows(TrainingSet,4);
        
        
        % K closest neighbours.
        % picking up the top K values from the sorted vector above.
        TopK = TrSSorted(1:K,:);
        
        
        % +1 votes
        class1votes = sum(TopK(:,3)== 1 );
        
        % -1 votes
        class2votes = sum(TopK(:,3)== -1 );
        
        result = 0;
        % majority votes getter is the winner
        if class1votes > class2votes
            result = 1;
        else
            result = -1;
        end
        
        %prediction
        prediction = result;
        actual     = TestSet(i,3);
        
%        disp(['Actual : ',num2str(actual),' Prediction : ',num2str(result)])
        
        TestSet(i,4) = prediction;
        
    end;

    % now when we got all the predictions for all testSet instances.
    % we can find out the performance measures.
    
    TP = 0;
    FP = 0;
    FN = 0;
    TN = 0;
    
    for i = 1:TestSetRows

        actual      = TestSet(i,3);
        prediction  = TestSet(i,4);

        if actual == prediction && actual==1
            TP = TP + 1;
        elseif actual == -1 && prediction == 1
            FP = FP + 1;
        elseif actual == 1 && prediction == -1
            FN = FN + 1;
        else
            TN = TN + 1;
        end
    end;

    
    accuracy = (TP+TN)/(FP+TP+FN+TN);
    precision = TP/(TP+FP);
    recall   = TP/(TP+FN);
    measureF = 2.*((precision.*recall)/(precision+recall));
    
end

