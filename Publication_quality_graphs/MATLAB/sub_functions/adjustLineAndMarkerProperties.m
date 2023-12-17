function adjustLineAndMarkerProperties(fig)
    % Adjust line and marker properties in a figure

    % Adjust line width
    set(findall(gca(fig), 'Type', 'Line'), 'LineWidth', 3);

    % Adjust marker properties
    axesChildren = get(gca(fig), 'Children');
    for i = 1:length(axesChildren)
        child = axesChildren(i);
        if strcmp(get(child, 'Type'), 'Line')
            set(child, 'MarkerSize', 8);
        end
    end
end
