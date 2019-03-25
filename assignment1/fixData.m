% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 1 PROBLEM #3
% STUDENT IDs: 2015320143, 2016320128, 2018320250
% 
% fixData Check and fix data input with some error handling.
%   fixData(DATA) checks if the data input conforms to the expected
%   dimensions of 206-by-14 and fixes the input such that all values in the
%   data are positive or 0 by deleting rows with negative or NaN values.
%   
%   INPUT:
%       DATA: 206-by-14 data input. Minimum error handling is performed.
%
%   OUTPUT:
%       DATA: The result after the data input is fixed. Rows with NaN and
%             negative values are removed. 
%
%   EXAMPLE: Fix the data in variable DATA and save the output back into
%            DATA.
%
%       DATA = fixData(DATA);

function [data] = fixData(data)

    % check the size of data
    % check if input data is a 206-by-14 matrix
    % if it is not, return error message
    if isequal([206,14], size(data)) == false
        error('Input size does not conform to expectations.');
    end
    
    % check for negative values
    % In our code, we delete rows with negative values. It is said in the
    % assignment that all values should be positive or 0. We think that a
    % row with data that should not be there is not credible, so we deleted
    % the row that contains negative values completely. Moreover, in the
    % given data, all negative values were found to be in a single row and
    % to be of the same value, which indicates that the row probably did
    % not contain useful information.
    [row, ~] = find(data < 0);
    data(unique(row), :) = [];
    
    % check for Nan values
    % In our code, we delete rows with NaN values. We considered changing
    % the NaN value to the median or the mean of the column, but we
    % concluded that we did not want to take the chance of corrupting the
    % data. In the given data set, there are over 200 rows and 1 NaN
    % element, so even if we delete 1 row we will have enough data for
    % analysis. Therefore, we deleted the row that contains the NaN value
    % completely.
    [row, ~] = find(isnan(data));
    data(unique(row), :) = [];
end
