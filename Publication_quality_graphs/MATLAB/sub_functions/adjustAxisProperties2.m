function adjustAxisProperties2(fig, a, b)
    % Adjust axis properties based on the type of plot in the figure
    % fig: Handle to the figure
    % a, b: Dimensions for box position

    % Set figure and axis units and background color
    bg = 0.98 * [1, 1, 1]; % Background color
    set(fig, 'Units', 'inches', 'Color', bg);
    ax = gca(fig); % Get current axes
    set(ax, 'Units', 'inches', 'Color', bg);

    % Check the type of the primary plot in the figure
    primaryPlot = get(ax, 'Children');
    
    if ~isempty(primaryPlot)
        plotType = class(primaryPlot(end));

        if strcmp(plotType, 'matlab.graphics.chart.primitive.Histogram')
            % Adjust properties specific to histograms
            adjustHistogramProperties(ax, bg, fig);
        elseif strcmp(plotType, 'matlab.graphics.chart.primitive.Bar')
            adjustBarChartProperties(ax, bg, fig)
        else
            % Adjust properties for other plot types
            adjustGeneralPlotProperties(ax, bg);
        end
    else
        warning('No plot found in the figure.');
    end

    % Adjust the position and size of the axes
    if ~isempty(a) && ~isempty(b)
        BoxPos = [1, 1, a, b];
    else
        BoxPos = [1, 1, 5, 4]; % Default size
    end
    set(ax, 'Position', BoxPos);
    adjustFigurePosition(fig, BoxPos);
end

function adjustHistogramProperties(ax, bg, fig)
    % Adjust properties for a histogram
    hHist = findobj(fig, 'Type', 'histogram');
    h = hHist(1);
    h.BinWidth = 2;
%     h.Normalization = 'probability';
    h.FaceColor = magma(1);
    h.EdgeColor = 'k';
    h.FaceAlpha = 1.0;
    set(ax, 'XGrid', 'on', 'YGrid', 'on', 'GridColor', 'w', 'GridLineStyle', '-', 'LineWidth', 1);
    set(ax, 'Box', 'off', 'XColor', 'k', 'YColor', 'k');
    set(ax, 'LineWidth', 1.5, 'TickDir', 'out', 'TickLength', [0.02, 0.02]);
    
    % Additional histogram-specific adjustments can be added here
end

function adjustBarChartProperties(ax, bg, fig)
    % Adjust properties for a bar chart
    hBar = findobj(fig, 'Type', 'Bar');
    if isempty(hBar)
        disp('No bar chart found in the figure.');
        return;
    end

    % Determine if it's a single bar chart or grouped bar chart
    if size(hBar(1).YData, 1) == 1
        % Single bar chart
        numBars = numel(hBar.YData); % Number of bars
        cmap = jet(numBars); % Replace 'jet' with your desired colormap
        hBar.CData = cmap;
    else
        % Grouped bar chart
        numGroups = size(hBar(1).YData, 2); % Number of groups
        numBars = numel(hBar); % Number of bars in each group

        for i = 1:numBars
            cmap = jet(numGroups); % Replace 'jet' with your desired colormap
            hBar(i).CData = cmap;
        end
    end

    % Set axes properties
    set(ax, 'XGrid', 'on', 'YGrid', 'on', 'GridColor', 'w', 'GridLineStyle', '-', 'LineWidth', 1);
    set(ax, 'Box', 'off', 'XColor', 'k', 'YColor', 'k');
    set(ax, 'LineWidth', 1.5, 'TickDir', 'out', 'TickLength', [0.02, 0.02]);
    
    % Additional bar chart-specific adjustments can be added here
end


function adjustGeneralPlotProperties(ax, bg)
    % Set axis limits based on figure data
    [x, y] = fig2data(fig);
    xdata = cell2mat(x);
    ydata = cell2mat(y);
    set(gca(fig), 'XLim', [min(xdata) max(xdata)], 'YLim', [min(ydata) max(ydata)]);

    % Customizing major ticks
%     numTicksX = 5; % Number of ticks on X-axis
%     numTicksY = 4; % Number of ticks on Y-axis
%     set(ax, 'XTick', linspace(min(xdata), max(xdata), numTicksX), 'YTick', linspace(min(ydata), max(ydata), numTicksY));

    % Customizing tick labels
    set(ax, 'XTickLabel', arrayfun(@(x) sprintf('%.1f', x), get(ax, 'XTick'), 'UniformOutput', false));
    set(ax, 'YTickLabel', arrayfun(@(y) sprintf('%.1f', y), get(ax, 'YTick'), 'UniformOutput', false));

    % Enabling minor ticks
    set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');

    % Customizing axis properties
    set(ax, 'LineWidth', 1.5, 'TickDir', 'out', 'TickLength', [0.02, 0.02]);

    % Customizing grid lines
    set(ax, 'XGrid', 'on', 'YGrid', 'on', 'GridColor', 'w', 'GridLineStyle', '-','LineWidth',1);

    % Customizing axis colors
    set(ax, 'Box', 'off', 'XColor', 'k', 'YColor', 'k');

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
