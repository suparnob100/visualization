function styleStruct = mPlotStyle()
    % Define a structure for plot style settings
    
    % Set figure and axis units and background color
    styleStruct= struct;
    
    styleStruct.FigBackgroundColor = 'w';
    styleStruct.AxesBackgroundColor = [0.95,0.95,0.95];

    % Axis properties
    styleStruct.Axis.LineWidth = 0.75;
    styleStruct.Axis.TickDir = 'out';
    styleStruct.Axis.TickLength = [0.02, 0.02];
    styleStruct.Axis.XGrid = 'on';
    styleStruct.Axis.YGrid = 'on';
    styleStruct.Axis.GridColor = 'w';
    styleStruct.Axis.GridLineStyle = '-';
    styleStruct.Axis.GridLineWidth = 1; % Added property for grid line width
    styleStruct.Axis.Box = 'off';
    styleStruct.Axis.XColor = 'k';
    styleStruct.Axis.YColor = 'k';
    styleStruct.Axis.XMinorTick = 'off'; % Added property for X minor tick
    styleStruct.Axis.YMinorTick = 'off'; % Added property for Y minor tick
    
    % Line/Scatter Properties
    styleStruct.LineProperties.LineWidth = 2;
    styleStruct.LineProperties.MarkerSize = 10;
    
    % Scatter Properties
    styleStruct.ScatterProperties.SizeData = 52;
    styleStruct.ScatterProperties.LineWidth = 2;
    
    % Histogram specific properties
    styleStruct.Histogram.BinWidth = 2;
    styleStruct.Histogram.Normalization = 'probability';
    styleStruct.Histogram.FaceColor = @viridis;
    styleStruct.Histogram.EdgeColor = 'none';
    styleStruct.Histogram.FaceAlpha = 0.85;

    % Bar chart specific properties
    styleStruct.BarChart.Colormap =  @magma; % Example, replace with actual colormap

    % General properties
    styleStruct.General.FontSize = 15;
    styleStruct.General.FontName = 'CMU Serif';
    styleStruct.General.TextInterpreter = 'latex';

    % Adding new style definitions for modifyFigureProperties
    styleStruct.FigureProperties.ChangeColor = 1; % Flag to change color, default is false
    styleStruct.FigureProperties.ColorMap = @magma; % Default colormap function
   
    % Adding new style definitions for adjustLegendTick
    styleStruct.LegendTick.LegendOrientation = 'vertical'; % Default orientation
    styleStruct.LegendTick.LegendPosition = 0; % 0 for no change, 1 for down, 2 for up
    styleStruct.LegendTick.AxisPadding = 0.1; % Default padding

    % Adding new style definitions for axis limits
    styleStruct.Axis.CustomXLim = []; % Empty means use default padding
    styleStruct.Axis.CustomYLim = []; % Empty means use default padding
    styleStruct.Axis.UseCustomLimits = 0; % Flag to indicate custom limit usage

    % Padding for axes
    styleStruct.Axis.xPad = 0.01; % Default X-axis padding
    styleStruct.Axis.yPad = 0.01; % Default Y-axis padding
    
    % Tick modifications
    styleStruct.Ticks.NumXTicks = 5; % Default number of X-axis ticks
    styleStruct.Ticks.XIntTicks = 0; % Use integer X-axis ticks
    styleStruct.Ticks.NumYTicks = 5; % Default number of Y-axis ticks
    styleStruct.Ticks.YIntTicks = 0; % Use integer Y-axis ticks

   
end
