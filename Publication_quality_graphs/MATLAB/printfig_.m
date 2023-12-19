function printfig_(varargin)
    %% PRINTFIG_ generates and customizes figures based on specified properties. WORKS FOR LINE PLOTS, HISTOGRAMS, AREA, AND SCATTER PLOTS.
    %
    % This function creates a figure using name-value pair arguments. It allows
    % extensive customization of the figure's appearance, including dimensions,
    % font, legend orientation, and color settings. It also provides options for
    % saving the figure in various formats.
    %
    % Syntax:
    %   printfig_('Name', Value, ...)
    %
    % Inputs:
    %   Select (numeric): Selection flag for manual or automatic selection
    %                     (default: 1 for manual selection).
    %   Figname (string): Name of the figure. Defaults to 'figure1' if select is 0.
    %   FormatNumber (numeric): Format number for saving the figure (default: 1).
    %   AdjustLegend (numeric): Flag for legend adjustment (1: down, 2: up; default: 2).
    %   Font (numeric): Font size for figure text (default: 20).
    %   L (numeric): Length of the figure (default: 5).
    %   W (numeric): Width of the figure (default: 4).
    %   LegendOrientation (numeric): Orientation of the legend (0 for vertical, 1 for horizontal; default: 0).
    %   ChangeColor (numeric): Flag to change color (default: 1).
    %   Pad (numeric): Padding around the figure (default: 0).
    %   BackgroundColor (vector): Background color of the figure (default: light grey).
    %
    % Example:
    %   printfig_('Font', 14, 'L',5, 'W', 4)
    
    %%
    close all
    p = inputParser;

    % Define default values
    defaultSelect = 1;
    defaultFigname = [];
%     defaultFormatNumber = [];
    defaultAdjustLegend = 2; %1:down, 2:up.
    defaultFont = 20;
    defaultL = 5;
    defaultW = 4;
    defaultLegendOrientation = 0; % For horizontal: 1
    defaultChangeColor = 1;
    defaultPad = 0;
    defaultBackgroundColor = 0.95*[1,1,1];

    %% Define parameters
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
    addParameter(p, 'BackgroundColor', defaultBackgroundColor)

    %% Parse input arguments
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
    bg = p.Results.BackgroundColor;

%%  
    Path = fileparts(mfilename('fullpath'));
    addpath(Path+"/sub_functions/")
    addpath(Path+"/utils/")
    addpath(Path+"/utils/export_fig")
    addpath(Path+"/utils/matplotlib")
    
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
        adjustAxisProperties2(fig, L, W, bg);    % Adjust axis properties
        adjustLegend(fig, AdjustLegend, LegendOrientation, Pad);       % Adjust legend properties
        printOutput(fig, FileName, PathName, frmt, i);    % Print or save the figure
    end
    
end
