function adjustAxisProperties(fig, a, b)
    % Adjust axis properties in a figure
%     % xp: flag for setting axis exponent
%     % a, b: dimensions for box position
% 
%     % Set axis properties
%     set(gca(fig), 'YMinorTick', 'on', 'LineWidth', 1.5, ...
%                  'XMinorTick', 'on', 'TickDir', 'out', ...
%                  'TickLength', [0.02, 0.02]);
    bg = 0.98*[1,1,1];
    set(fig, 'Units', 'inches', 'Color', bg);
    set(gca(fig), 'Units', 'inches');
    
    % Set axis limits based on figure data
    [x, y] = fig2data(fig);
    xdata = cell2mat(x);
    ydata = cell2mat(y);
    set(gca(fig), 'XLim', [min(xdata) max(xdata)], 'YLim', [min(ydata) max(ydata)]);

    % Customizing major ticks
%     numTicksX = 5; % Number of ticks on X-axis
%     numTicksY = 4; % Number of ticks on Y-axis

    ax = gca(fig); % Get current axes
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
    set(ax, 'Color', bg); 

    % Adjust the position and size of the figure and axes
    if ~isempty(a) && ~isempty(b)
        BoxPos = [1, 1, a, b];
    else
        BoxPos = [1, 1, 5, 4]; % Default size
    end
    set(gca(fig), 'Position', BoxPos);
    adjustFigurePosition(fig, BoxPos);
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