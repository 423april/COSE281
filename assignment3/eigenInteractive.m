% COSE281 ENGINEERING MATHEMATICS 2019 ASSIGNMENT 3 PROBLEM #2
% STUDENT IDs: 2015320143, 2016320128, 2018320250
%
% eigenInteractive(Pos) is a function that creates three draggable points 
% in an interactive plot inspired by
% https://stackoverflow.com/questions/9646146/how-to-make-a-matlab-plot-interactive/9650495

function eigenInteractive(Pos)

% call the function WITHOUT any input argument
% to setup the figure and the environment
if nargin == 0
    % clean up (note that this is bad style
    % for functions in general, but here it's ok)
    close all;
    clear all;
    clc;

    % create a figure with axis
    f1 = figure(1);
    set(f1, 'Units', 'pixels', 'Position', [0 0 700 500]);
    axis([0 5 0 5]);
    hold on;

    % these variables hold the three impoint handles
    global a1 a2 v

    
    % create first points
    a1 = impoint(gca,1,1);
    setString(a1,'a_1');
    a2 = impoint(gca,2,4);
    setString(a2,'a_2');
    v = impoint(gca,2,2);
    setString(v, 'v');
    
    % Call subfunction
    drawInfo(a1,a2,v)

    % Add callback to each point
    addNewPositionCallback(a1,@eigenInteractive);
    addNewPositionCallback(a2,@eigenInteractive);
    addNewPositionCallback(v,@eigenInteractive);
    
    disp('setup done')
else

    % If we get an input argument, its the position
    % from the callback, so we know that the user
    % dragged a point
    
    % access the plot and impoint handles
    global H1 H2 H3 H4 H5 H6 H7 H8 a1 a2 v %Av

    
    % remove old arrows
    delete(H1)
    delete(H2)
    delete(H3)
    delete(H4)
    delete(H5)
    delete(H6)
    delete(H7)
    delete(H8)
    % draw new arrows
    drawInfo(a1,a2,v)
    
end

function drawInfo(a1,a2,v)

P = zeros(2,2);
% Get X and Y coordinates for the 2 points.
P(1,:) = getPosition(a1);
P(2,:) = getPosition(a2);

% Q to get X and Y coordinates for v
Q = zeros(1,2);
Q(1,:) = getPosition(v);

transposeP = transpose(P); 

% array to hold A * v
R = transpose(P) * transpose(Q);

% plot arrows
global H1 H2 H3 H4 H5 H6 H7 H8
H1 = plot([0 P(1,1)], [0 P(1,2)]);
H2 = plot([0 P(2,1)], [0 P(2,2)]);
H3 = text(3,4,sprintf('$A = \\left [\\begin{array}{cc} a_1,x & a_2,x\\\\a_1,y & a_2,y\\end{array}\\right] = \\left [\\begin{array}{cc} %.02f & %.02f\\\\%.02f & %.02f\\end{array}\\right ]$',P(1,1),P(2,1),P(1,2),P(2,2)),'Interpreter','Latex'); 
H4 = plot([Q(1) R(1)], [Q(2) R(2)], 'LineStyle', ':');
H5 = text(3,3.5,sprintf('$v = \\left [\\begin{array}{cc} %.02f\\\\%.02f\\end{array}\\right ]$', Q(1), Q(2)), 'Interpreter', 'Latex');
H6 = text(3,3,sprintf('$Av = \\left [\\begin{array}{cc} %.02f\\\\%.02f\\end{array}\\right ]$', R(1), R(2)), 'Interpreter', 'Latex');
H7 = plot(R(1), R(2), 'b.','markersize',15);
H8 = text(R(1), R(2), 'A_v');
% H3 = text(5,5,sprintf('$\\left [\\begin{array}{cc} %.02f & %.02f\\\\%.02f & %.02f\\end{array}\\right ]$',P(1,1),P(1,2),P(2,1),P(2,2)),'Interpreter','Latex'); 
% reverse the order of the elements to keep
% the impoints on top
t=get(gca,'Children');
set(gca,'Children',[t(11) t(10) t(9) t(8) t(7) t(6) t(5) t(4) t(3) t(2) t(1)]);
