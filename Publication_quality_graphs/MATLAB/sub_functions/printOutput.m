function printOutput(fig, FileName, frmt, i)
    % Function for printing or saving the figure in specified formats
    % fig: Handle to the figure
    % FileName: Name of the file to save
    % frmt: Format(s) in which to save the figure
    % i: Index of the current file being processed

    % Get the filename for the current figure
    if iscell(FileName)
        currentFileName = FileName{i};
    else
        currentFileName = FileName;
    end

    % Iterate through each specified format
    for j = 1:length(frmt)
        % Determine the format extension and format specifier
        [formatExt, formatSpecifier] = getFormatInfo(frmt(j));

        % Construct the full file path with extension
        filePath = fullfile(currentFileName, formatExt);

        % Save or print the figure based on the format
        switch formatSpecifier
            case 'fig'
                % Save as MATLAB figure
                savefig(fig, filePath);
            case '-dpdf'
                % Save as PDF
                export_fig(currentFileName+".pdf", '-q101','-transparent','-painters');
            otherwise
                % Print using the specified format
                print(fig, ['-d', formatSpecifier], filePath);
        end
    end
end