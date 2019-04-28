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
    % clear the workspace, close all figures and clear the output window 
    % of Matlab.
    close all;
    clear all;
    clc;

    % create a figure with axis, label x and y
    f1 = figure(1);
    set(f1, 'Units', 'pixels', 'Position', [0 0 700 500]);
    axis([0 5 0 5]);
    xlabel('x');
    ylabel('y');
    hold on;

    % these variables hold the three impoint handles
    global a1 a2 v

    % create first points
    a1 = impoint(gca,0.52,0);
    setString(a1,'a_1');
    a2 = impoint(gca,0.45,1.1);
    setString(a2,'a_2');
    v = impoint(gca,1.3,1.95);
    setString(v, 'v');
        
    % Call subfunction
    drawInfo(a1,a2,v)

    % Add callback to each point
    addNewPositionCallback(a1,@eigenInteractive);
    addNewPositionCallback(a2,@eigenInteractive);
    addNewPositionCallback(v,@eigenInteractive);
    
    disp('setup done')
    
else

    % If we get an input argument, it's the position from the callback, 
    % so we know that the user dragged a point
    
    % access the plot and impoint handles
    global H1 H2 H3 H4 H5 H6 H7 H8 H9 H10 H11 H12 H13 H14 a1 a2 v %Av

    
    % remove old arrows
    delete(H1)
    delete(H2)
    delete(H3)
    delete(H4)
    delete(H5)
    delete(H6)
    delete(H7)
    delete(H8)
    delete(H9)
    delete(H10)
    delete(H11)
    delete(H12)
    delete(H13)
    delete(H14)
    
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

% array to hold A * v
R = transpose(P) * transpose(Q);

% get eigenvector and eigenvaluees
[evecs, evals] = eig(transpose(P));

% plot arrows
global H1 H2 H3 H4 H5 H6 H7 H8 H9 H10 H11 H12 H13 H14

% handles for lines a1, a2 and line connecting v & Av
H1 = plot([0 P(1,1)], [0 P(1,2)]);
H2 = plot([0 P(2,1)], [0 P(2,2)]);
H3 = plot([Q(1) R(1)], [Q(2) R(2)], 'LineStyle', ':');

% handles for text: arrays for A, v and Av
H4 = text(3,4,sprintf('$A = \\left [\\begin{array}{cc} a_1,x & a_2,x\\\\a_1,y & a_2,y\\end{array}\\right] = \\left [\\begin{array}{cc} %.02f & %.02f\\\\%.02f & %.02f\\end{array}\\right ]$',P(1,1),P(2,1),P(1,2),P(2,2)),'Interpreter','Latex'); 
H5 = text(3,3.5,sprintf('$v = \\left [\\begin{array}{cc} %.02f\\\\%.02f\\end{array}\\right ]$', Q(1), Q(2)), 'Interpreter', 'Latex');
H6 = text(3,3,sprintf('$Av = \\left [\\begin{array}{cc} %.02f\\\\%.02f\\end{array}\\right ]$', R(1), R(2)), 'Interpreter', 'Latex');

% handles to mark up position and text of Av
H7 = plot(R(1), R(2), 'b.','markersize',15);
H8 = text(R(1), R(2), 'Av');

% handles for eigenvectors e_1 and e_2
H9 = text(4,3.5,sprintf('$e_1 = \\left [\\begin{array}{cc} %.02f\\\\%.02f\\end{array}\\right ]$', evecs(1,1), evecs(2,1)), 'Interpreter', 'Latex');
H10 = text(4,3,sprintf('$e_2 = \\left [\\begin{array}{cc} %.02f\\\\%.02f\\end{array}\\right ]$', evecs(1,2), evecs(2,2)), 'Interpreter', 'Latex');
H11 = plot([0 evecs(1,1)], [0 evecs(2,1)]);
H12 = plot([0 evecs(1,2)], [0 evecs(2,2)]);
H13 = text(evecs(1,1), evecs(2,1), 'e_1');
H14 = text(evecs(1,2), evecs(2,2), 'e_2');

% reverse the order of the elements to keep
% the impoints on top
t=get(gca,'Children');
set(gca,'Children',[t(17) t(16) t(15) t(14) t(13) t(12) t(11) t(10) t(9) t(8) t(7) t(6) t(5) t(4) t(3) t(2) t(1)]);
