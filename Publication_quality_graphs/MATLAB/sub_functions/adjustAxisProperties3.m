function adjustAxisProperties3(fig, a, b)
    % Load the style settings from myPlotStyle
    styleSettings = mPlotStyle();
    bg = styleSettings.AxesBackgroundColor;
    
    % Set figure and axis units and background color
    set(fig, 'Units', 'inches', 'Color', styleSettings.FigBackgroundColor);
    ax = gca(fig); % Get current axes
    set(ax, 'Units', 'inches', 'Color', bg);
    
    % Apply general axis properties from styleSettings
    set(ax, 'LineWidth', styleSettings.Axis.LineWidth, ...
            'TickDir', styleSettings.Axis.TickDir, ...
            'TickLength', styleSettings.Axis.TickLength, ...
            'XGrid', styleSettings.Axis.XGrid, ...
            'YGrid', styleSettings.Axis.YGrid, ...
            'GridColor', styleSettings.Axis.GridColor, ...
            'GridLineStyle', styleSettings.Axis.GridLineStyle, ...
            'Box', styleSettings.Axis.Box, ...
            'XColor', styleSettings.Axis.XColor, ...
            'YColor', styleSettings.Axis.YColor, ...
            'XMinorTick', styleSettings.Axis.XMinorTick,...
            'YMinorTick', styleSettings.Axis.YMinorTick);

    % Adjust the position and size of the axes
    if ~isempty(a) && ~isempty(b)
        BoxPos = [1, 1, a, b];
    else
        BoxPos = [1, 1, 5, 4]; % Default size
    end
    
    adjustAnnotation(ax,a,b)
    set(ax, 'Position', BoxPos);
    
    % Check the type of the primary plot in the figure
    primaryPlot = get(ax, 'Children');
    
    if ~isempty(primaryPlot)
        plotType = class(primaryPlot(end));

        if strcmp(plotType, 'matlab.graphics.primitive.Patch')
            % Adjust properties specific to histograms
            adjustHistogramProperties(fig, styleSettings);
        elseif strcmp(plotType, 'matlab.graphics.chart.primitive.Bar')
            % Adjust properties specific to bar charts
            adjustBarChartProperties(fig)
        end
    else
        warning('No plot found in the figure.');
    end

    adjustFigurePosition(fig, BoxPos);

end


function adjustHistogramProperties(fig, styleSettings)
    % Adjust properties for a histogram
    hHist = findobj(fig, 'Type', 'Patch');
    if isempty(hHist)
        warning('No histogram found in the figure.');
        return;
    end
    h = hHist(1);
    % Apply style settings to histogram
%     h.FaceColor = clr;
%     h.EdgeColor = styleSettings.Histogram.EdgeColor;
    h.FaceAlpha = styleSettings.Histogram.FaceAlpha;
    % h.BinWidth = styleSettings.Histogram.BinWidth; % Uncomment if needed
    % h.Normalization = styleSettings.Histogram.Normalization; % Uncomment if needed

    % Additional histogram-specific adjustments can be added here
end



function adjustBarChartProperties(fig)
    % Adjust properties for a bar chart
    styleSettings = mPlotStyle();

        
    hBar = findobj(fig, 'Type', 'Bar');
    if isempty(hBar)
        disp('No bar chart found in the figure.');
        return;
    end
    
    % Determine if it's a single bar chart or grouped bar chart
    if size(hBar(1).YData, 1) == 1
        % Single bar chart
        numBars = numel(hBar.YData); % Number of bars
        cmap = styleSettings.BarChart.Colormap(numBars); % Replace 'jet' with your desired colormap
        hBar.CData = cmap;
    else
        % Grouped bar chart
        numGroups = size(hBar(1).YData, 2); % Number of groups
        numBars = numel(hBar); % Number of bars in each group

        for i = 1:numBars
            cmap = styleSettings.BarChart.Colormap(numGroups); % Replace 'jet' with your desired colormap
            hBar(i).CData = cmap;
        end
    end

    % Additional bar chart-specific adjustments can be added here
end

function adjustFigurePosition(fig, BoxPos)
    % Adjust the position of the figure on the screen
    set(0, 'Units', 'inch');
    monitorPos = get(0, 'MonitorPositions');
    pos = [monitorPos(1, 3)/2 - BoxPos(3)/2, monitorPos(1, 4)/2 - BoxPos(4)/2];
    outerpos = get(gca, 'OuterPosition');
    
    if ~isempty(outerpos)
        set(gca(fig), 'OuterPosition',[0, 0, outerpos(3), outerpos(4)]);
        set(fig, 'Position', [pos(1), pos(2), outerpos(3), outerpos(4)]);
    end

    set(fig,'PaperPositionMode', 'auto');
end

function adjustAnnotation(ax,a,b)
    
    set(0,'defaulttextinterpreter','latex')
    set(0,'DefaultTextFontname', 'CMU Serif')
    set(0,'DefaultAxesFontName', 'CMU Serif')
   
    % Get current axes size
    currentAxesSize = get(ax, 'Position');
    currentWidth = currentAxesSize(3);
    currentHeight = currentAxesSize(4);

    allTextObjects = findall(ax, 'Type', 'text'); % Find all text objects

    % Get handles for xlabel, ylabel, and title
    xlabelHandle = get(ax, 'XLabel');
    ylabelHandle = get(ax, 'YLabel');
    titleHandle = get(ax, 'Title');

    % Exclude axis labels and title from the list
    textAnnotations = allTextObjects(~ismember(allTextObjects, [xlabelHandle, ylabelHandle, titleHandle]));

    for i = 1:length(textAnnotations)
        set(textAnnotations(i), 'FontSize', 15); % Set font size
    end

    for i = 1:length(textAnnotations)
        pos = get(textAnnotations(i), 'Position');
        
        % Calculate relative position
        relativeX = pos(1) / currentWidth;
        relativeY = pos(2) / currentHeight;
    
        % Scale position according to new dimensions a and b
        newPos = [relativeX * a, 0.85*relativeY * b, pos(3:end)]; % Keep the Z position and other dimensions (if any) unchanged
        set(textAnnotations(i), 'Position', newPos);
        
    end

    for i = 1:length(textAnnotations)
        pos = get(textAnnotations(i), 'Position');

        % Check if near the boundary and adjust font size
        if pos(1) > a * 0.8 || pos(2) > b * 0.8 % Example condition
            currentSize = get(textAnnotations(i), 'FontSize');
            newSize = max(currentSize * 0.95, 8); % Reduce font size but not below 8
            set(textAnnotations(i), 'FontSize', newSize);
        end
    end


end

