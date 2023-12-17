function printfig_(varargin)
    %PRINTFIG_ Create and modify a figure with specified properties.
    %
    % Syntax:
    %   printfig_('Name', Value, ...)
    %
    % Description:
    %   printfig_ creates a figure based on name-value pairs that define the 
    %   figure's properties and behavior. It allows customization of the figure's
    %   appearance and format.
    %
    % Inputs:
    %   Select - Selection flag (default: 1)
    %   Figname - Name of the figure (default: 'figure1')
    %   FormatNumber - Format number for saving the figure (default: 1)
    %   AdjustLegend - Flag to adjust the legend (default: false)
    %   Font - Font size for the figure text (default: 12)
    %   L - Length of the figure (default: 10)
    %   W - Width of the figure (default: 10)
    %   LegendOrientation - Orientation of the legend ('vertical' or 'horizontal')
    %                         (default: 'vertical')
    %   ChangeColor - Flag to change color (default: true)
    %   Pad - Padding around the figure (default: 0)
    %
    % Example:
    %   printfig_('Font', 14, 'Figname', 'MyCustomFigure')
    %
    % See also: inputParser

    % Create an input parser instance
    p = inputParser;

    % Define default values
    defaultSelect = 1;
    defaultFigname = [];
%     defaultFormatNumber = [];
    defaultAdjustLegend = 2; %1:down, 2:up.
    defaultFont = 25;
    defaultL = 5;
    defaultW = 4;
    defaultLegendOrientation = 0; % For horizontal: 1
    defaultChangeColor = 1;
    defaultPad = 0.01;

    % Define parameters
    addParameter(p, 'Select', defaultSelect);
    addParameter(p, 'Figname', defaultFigname);
%     addParameter(p, 'FormatNumber', defaultFormatNumber);
    addParameter(p, 'AdjustLegend', defaultAdjustLegend);
    addParameter(p, 'Font', defaultFont);
    addParameter(p, 'L', defaultL);
    addParameter(p, 'W', defaultW);
    addParameter(p, 'LegendOrientation', defaultLegendOrientation);
    addParameter(p, 'ChangeColor', defaultChangeColor);
    addParameter(p, 'Pad', defaultPad);

    % Parse input arguments
    parse(p, varargin{:});

    % Extract variables after parsing
    Select = p.Results.Select;
    Figname = p.Results.Figname;
%     FormatNumber = p.Results.FormatNumber;
    AdjustLegend = p.Results.AdjustLegend;
    Font = p.Results.Font;
    L = p.Results.L;
    W = p.Results.W;
    LegendOrientation = p.Results.LegendOrientation;
    ChangeColor = p.Results.ChangeColor;
    Pad = p.Results.Pad;

%  End of parsing inputs

    Path = fileparts(mfilename('fullpath'));
    addpath(Path+"/sub_functions/")
    addpath(Path+"/utils/")
    addpath(Path+"/utils/export_fig")
    
    if ~exist('FormatNumber','var')
        formats1 = getFormatInfo(); % Assume getFormats() returns formats1, formats2, and formats3
    else
        formats1 = FormatNumber;
    end
        
    [FileName, PathName, Filepath, frmt] = handleUserInput(Select, Figname, formats1);

    % Iterate through each file
    N = determineNumberOfFiles(FileName);
    for i = 1:N
        fig = openFigure(Filepath, i);
        modifyFigureProperties(fig, Font, ChangeColor); % Adjust basic figure properties like color
        adjustLineAndMarkerProperties(fig);     % Adjust line and marker properties
        adjustAxisProperties(fig, L, W);    % Adjust axis properties
        adjustLegend(fig, AdjustLegend, LegendOrientation, Pad);       % Adjust legend properties
        printOutput(fig, FileName, frmt, i);    % Print or save the figure
    end
end
