function writeToExcel(excelFileName,varNames,resultData)

% After processing all images and storing the results in allResults,
% iterate over each sheet to write the data

    % Write headers
    writecell(varNames, excelFileName, 'Range', 'A1');
    
    % Write the collected data for each sheet
    if ~isempty(resultData)
        writematrix(resultData, excelFileName,'WriteMode', 'append');%, 'Range', 'A2'
    end

end