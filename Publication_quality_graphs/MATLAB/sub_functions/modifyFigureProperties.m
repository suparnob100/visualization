function modifyFigureProperties(fig, fnt, chngc)
    % Function to modify properties of a figure
    % fig: handle to the figure
    % fnt: font size for axis labels
    % chngc: flag to change color

    % Define a color palette (example colors, can be modified)
    C = [ 0.90196  0.38039  0.00392;... % RED
          0.36863  0.23529  0.60000;... % VIOLET
          0.99216  0.72157  0.38824;... % YELLOW
        ];

    % Set font size of axes
    if exist('fnt', 'var') && ~isempty(fnt)
        set(gca(fig), 'FontSize', fnt)%, 'FontWeight', 'bold', 'FontAngle', 'italic');
    else
        set(gca(fig),'FontSize',14); % Default font size
    end

    % Modify line colors if chngc flag is set
    if exist('chngc', 'var') && chngc == 1
        hline = findobj(fig, 'type', 'line');
        nol = length(hline);
        for clp = 1:nol
            set(hline(clp),'Color',C(mod(clp-1, size(C, 1)) + 1,:));
        end
    end

    % Other figure property modifications can be added here as needed
end
