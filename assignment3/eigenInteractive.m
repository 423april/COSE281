% function that creates two draggable points in an interactive plot
% inspired by
% https://stackoverflow.com/questions/9646146/how-to-make-a-matlab-plot-interactive/9650495
function eigenInteractive(Pos)

% call the function WITHOUT any input argument
% to setup the figure and the environment
if nargin == 0
    % clean up (note that this is bad style
    % for functions in general, but here it's ok
    close all;
    clear all;
    clc;

    % create a figure
    figure(1);
    axis([-10 10 -10 10]);
    hold on;

    % these variables hold the two impoint handles
    global a1 a2
    
    % create first point
    a1 = impoint(gca,1,1);
    setString(a1,'a_1');
    a2 = impoint(gca,2,4);
    setString(a2,'a_2');

    % Call subfunction
    drawInfo(a1,a2)

    % Add callback to each point
    addNewPositionCallback(a1,@eigenInteractive);
    addNewPositionCallback(a2,@eigenInteractive);
    
    disp('setup done')
else

    % If we get an input argument, its the position
    % from the callback, so we know that the user
    % dragged a point
    
    % access the plot and impoint handles
    global H1 H2 H3 a1 a2

    
    % remove old arrows
    delete(H1)
    delete(H2)
    delete(H3)
    % draw new arrows
    drawInfo(a1,a2)
    
end

function drawInfo(a1,a2)

P = zeros(2,2);
% Get X and Y coordinates for the 2 points.
P(1,:) = getPosition(a1);
P(2,:) = getPosition(a2)

% plot arrows
global H1 H2 H3
H1 = plot([0 P(1,1)], [0 P(1,2)]);
H2 = plot([0 P(2,1)], [0 P(2,2)]);
H3 = text(5,5,sprintf('$\\left [\\begin{array}{cc} %.02f & %.02f\\\\%.02f & %.02f\\end{array}\\right ]$',P(1,1),P(1,2),P(2,1),P(2,2)),'Interpreter','Latex'); 
% reverse the order of the elements to keep
% the impoints on top
t=get(gca,'Children');
set(gca,'Children',[t(5) t(4) t(3) t(2) t(1)]);