function adjustLineAndMarkerProperties(fig)
    % Adjust line and marker properties in a figure

    % Find all line objects in the figure
    lines = get(gca(fig), 'Children');
    
    % Loop through each line object
    for i = 1:length(lines)
        line = lines(i);
       
        if (isa(line, 'matlab.graphics.chart.primitive.Line'))
            set(line, 'LineWidth', 3);
            
            if ~strcmp(get(line, 'Marker'), 'none')
                set(line, 'MarkerSize', 8);
            end
        
        elseif (isa(line, 'matlab.graphics.chart.primitive.Scatter'))
            set(line, 'SizeData', 52);
            set(line, 'MarkerEdgeColor', magma(i))
            set(line, 'MarkerFaceColor', magma(i))
            set(line, 'LineWidth', 3)
            
        else
            set(line, 'LineWidth', 3);
            set(line, 'FaceColor', magma(i))
            set(line, 'EdgeColor', magma(i)*0.98)
        end

        % Check if the line has a marker, and adjust marker properties if it does

    end
end