function adjustLegendTick(fig, oll, ori, pad)
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
        
%     %% Set axis limits based on figure data
%     plot_data = fig2data_(fig);
%     xdata = cell2mat(plot_data.x);
%     ydata = cell2mat(plot_data.y);
%     set(gca(fig), 'XLim', [min(xdata(:)) max(xdata(:))], 'YLim', [min(ydata(:)) max(ydata(:))]);
%     
    axis tight

    %% Adjust axes limits based on padding
    xLimits = get(axesHandle, 'XLim');
    yLimits = get(axesHandle, 'YLim');
    xPad = pad * (xLimits(2) - xLimits(1));
    yPad = pad * (yLimits(2) - yLimits(1));
    set(axesHandle, 'XLim', [xLimits(1) - xPad, xLimits(2) + xPad]);
    set(axesHandle, 'YLim', [yLimits(1) - yPad, yLimits(2) + yPad]);


    %% Adjust legend orientation
    if ~isempty(legendHandle)
        
        if exist('ori', 'var') && ori == 1
            set(legendHandle, 'Orientation', 'horizontal');
        end

        % Adjust legend position based on oll value
        if ~isempty(oll)
            % Get current legend and axes positions
            legendHandle.Units='inches';
            legendPos = get(legendHandle, 'Position');
            axesPos = get(axesHandle, 'Position');

            legendBoxH = legendPos(4);

            Y = yLimits(2) - yLimits(1);
            H = axesPos(4);

            legendBoxH_yax = Y*legendBoxH/H;

            if oll == 1 % Position legend down
                % Move the legend below the axes
    %             set(legendHandle, 'Position', [axesPos(1), axesPos(2) - legendPos(4), legendPos(3), legendPos(4)]);
                set(axesHandle, 'YLim', [yLimits(1) - 2*legendBoxH_yax, yLimits(2)]);

            elseif oll == 2 % Position legend up
                % Move the legend above the axes
    %             set(legendHandle, 'Position', [axesPos(1)+axesPos(3)-legendPos(3), axesPos(2) + axesPos(4)-legendPos(4), legendPos(3), legendPos(4)]);
                set(axesHandle, 'YLim', [yLimits(1), yLimits(2)+ 2*legendBoxH_yax]);

            end
            
            legendHandle.Units='normalized';

        end
        
        set(legendHandle,'color','none');
        legend boxoff
        
    end

    %% xtick modification
    primaryPlot = get(axesHandle, 'Children');
    plotType = class(primaryPlot(end));

    
    if ~strcmp(plotType, 'matlab.graphics.chart.primitive.Bar')
        
        x_int_ticks = 0;
        xLimits = get(axesHandle, 'XLim');

        if length(xticks)>5
        numTicksX = 5; % Number of ticks on Y-axis
        xticks(linspace(min(xLimits), max(xLimits), numTicksX))
        end

        if x_int_ticks == 1
            xticks(floor(linspace(min(xLimits), max(xLimits), length(xticks)+1)))
        end
        if (~strcmp(axesHandle.XScale, 'log'))*(max(xLimits)<1000)
            set(axesHandle, 'XTickLabel', arrayfun(@(x) sprintf('%.1f', x), get(axesHandle, 'XTick'), 'UniformOutput', false));
        end
    end

    %% ytick modification
    
    y_int_ticks = 0;
    yLimits = get(axesHandle, 'YLim');

    if length(yticks)>5
    numTicksY = 5; % Number of ticks on Y-axis
    yticks(linspace(min(yLimits), max(yLimits), numTicksY)) 
    end

    if y_int_ticks == 1
        yticks(floor(linspace(min(yLimits), max(yLimits), length(yticks)+1)))
    end
    
    if (~strcmp(axesHandle.YScale, 'log'))*(max(yLimits)<1000)
        set(axesHandle, 'YTickLabel', arrayfun(@(y) sprintf('%.1f', y), get(axesHandle, 'YTick'), 'UniformOutput', false));
    end

    
end

function n = O( val, base)

%Order of magnitude of number for specified base. Default base is 10.
%order(0.002) will return -3., order(1.3e6) will return 6.
%Author Ivar Smith

if nargin < 2
    base = 10;
end
n = floor(log(abs(val))./log(base));

end
