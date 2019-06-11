% close all
% clear all
% clc

load('data.mat');


% output = student-teacher ratio
for i = 1:9
    output(i) =  Num_Elementary_Students_2009_2017(1,i);
end

for i = 1:11
    for j = 1:9
        output(i+1,j) =  Num_Elementary_Students_2009_2017(i+1,j) ./ Num_Teachers_2009_2017(i+1,j);
    end
end



for i = 2:12
    for j = 1 : 9
    Crime_Rate_2009_2017(i,:) = (Crime_Rate_2009_2017(i,j) - min(Crime_Rate_2009_2017(i,:))/max(Crime_Rate_2009_2017(i,:) - min(Crime_Rate_2009_2017(i,:));
    GRDP_2009_2017(i,:)' 
    Housing_Prices_Increase_Rate_2009_2017(i,1:8)' ...
     Num_Birth_2009_2017(i,1:8)' Num_Elementary_Entry_2009_2017(i,1:8)' Num_Elementary_Students_2009_2017(i,1:8)' Num_Marriages_2009_2017(i,1:8)'...
     Num_Schools_2009_2017(i,1:8)' Num_Teachers_2009_2017(i,1:8)' Population_Increase_Rate_2009_2017(i,1:8)' Tuition_Centre_Rate_2009_2017(i,1:8)'...
     Unemployment_Rate_2009_2017(i,1:8)'
    end
    
    P = [ones(8, 1) Crime_Rate_2009_2017(i,1:8)' GRDP_2009_2017(i,1:8)' Housing_Prices_Increase_Rate_2009_2017(i,1:8)' ...
     Num_Birth_2009_2017(i,1:8)' Num_Elementary_Entry_2009_2017(i,1:8)' Num_Elementary_Students_2009_2017(i,1:8)' Num_Marriages_2009_2017(i,1:8)'...
     Num_Schools_2009_2017(i,1:8)' Num_Teachers_2009_2017(i,1:8)' Population_Increase_Rate_2009_2017(i,1:8)' Tuition_Centre_Rate_2009_2017(i,1:8)'...
     Unemployment_Rate_2009_2017(i,1:8)'];
 
    a(:,i-1) = P \ output(i,1:8)';
   
    input = [ones(1, 1) Crime_Rate_2009_2017(i,9)' GRDP_2009_2017(i,9)' Housing_Prices_Increase_Rate_2009_2017(i,9)' ...
     Num_Birth_2009_2017(i,9)' Num_Elementary_Entry_2009_2017(i,9)' Num_Elementary_Students_2009_2017(i,9)' Num_Marriages_2009_2017(i,9)'...
     Num_Schools_2009_2017(i,9)' Num_Teachers_2009_2017(i,9)' Population_Increase_Rate_2009_2017(i,9)' Tuition_Centre_Rate_2009_2017(i,9)'...
     Unemployment_Rate_2009_2017(i,9)'];
 
    prediction = a(:,i-1)'*input'
 
    error = output(i,9) - prediction
end

