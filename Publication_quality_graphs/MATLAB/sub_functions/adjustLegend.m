function adjustLegend(fig, oll, ori, pad)
    % Function to adjust legend properties in a figure
    % fig: handle to the figure
    % oll: flag to adjust the legend box (1 for down, 2 for up)
    % ori: flag for horizontal orientation (1 for horizontal)
    % pad: axis padding

    % Access the legend and axes of the figure
    legendHandle = findobj(fig, 'Type', 'Legend');
    axesHandle = gca;

    if isempty(legendHandle)*isempty(axesHandle)
        warning('No legend or axes found in the figure.');
        return;
    end

    % Adjust legend orientation
    if exist('ori', 'var') && ori == 1
        set(legendHandle, 'Orientation', 'horizontal');
    end

    % Adjust legend position based on oll value
    if exist('oll', 'var') && oll == 1
        % Get current legend and axes positions
        legendPos = get(legendHandle, 'Position');
        axesPos = get(axesHandle, 'Position');

        if oll == 1 % Position legend down
            % Move the legend below the axes
            set(legendHandle, 'Position', [axesPos(1), axesPos(2) - legendPos(4), legendPos(3), legendPos(4)]);
        elseif oll == 2 % Position legend up
            % Move the legend above the axes
            set(legendHandle, 'Position', [axesPos(1), axesPos(2) + axesPos(4), legendPos(3), legendPos(4)]);
        end
    end

    % Apply axis padding if pad is specified
    if exist('pad', 'var')
        % Adjust axes limits based on padding
        xLimits = get(axesHandle, 'XLim');
        yLimits = get(axesHandle, 'YLim');
        xPad = pad * (xLimits(2) - xLimits(1));
        yPad = pad * (yLimits(2) - yLimits(1));
        set(axesHandle, 'XLim', [xLimits(1) - xPad, xLimits(2) + xPad]);
        set(axesHandle, 'YLim', [yLimits(1) - yPad, yLimits(2) + yPad]);
    end
end
