% fixData.m: function to check data size and clean input data by deleting 
% rows with negative & NaN values.
% INPUT: 
%        data: input data file
% OUTPUT: 
%        data: cleaned data 
% EXAMPLE:
%        data = fixData(data);


function [data] = fixData(data)
    % sz: size of input data
    sz = size(data);
    
    % check data size
    % check if input data is 206*14 matrix
    % if not, return error message
    if isequal([206,14], sz) 
    else 
        msg = 'input size does not conform.';
        error(msg);
    end
    
    % check for negative values
    % In our code, we delete rows with negative values. It is said in the
    % assignment that all values should be positive or 0. We think that a 
    % row with data that should not be there is uncredible, so we deleted 
    % the whole row that contains negative value. 
    [row,~] = find(data<0);
    data(unique(row),:) = [];
    
    % check for Nan values
    % In our code, we delete rows with NaN values. We considered changing
    % the NaN value to median or mean of the column, but we concluded that
    % we did not want to take the chance of corrupting the data. In the
    % given data set, there are over 200 rows and 1 NaN element, so even if
    % we delete 1 row we will have enough data for analysis. Therefore, 
    % we deleted the whole row that contains NaN value
    [row,~] = find(isnan(data));
    data(unique(row),:) = [];
    
end
