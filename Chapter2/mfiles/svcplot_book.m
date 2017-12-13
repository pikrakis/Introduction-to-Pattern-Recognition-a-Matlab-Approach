function svcplot_book(X,Y,ker,kpar1,kpar2,alpha,bias,aspect,mag,xaxis,yaxis,input)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%  svcplot_book(X,Y,ker,kpar1,kpar2,alpha,bias,aspect,mag,xaxis,yaxis,input)
% Support Vector Machine Plotting routine. It plots the decision regions, the decision
% surfaces and the margin obtained by a SVM classifier.
%
% INPUT ARGUMENTS:
%  X:       training inputs
%  Y:       training targets
%  ker:     kernel function
%  kpar1:   1st parameter of kernel
%  kpar2:   2nd parameter of kernel
%  alpha:   Lagrange Multipliers
%  bias:    bias term
%  aspect:  aspect Ratio (default: 0 (fixed), 1 (variable))
%  mag:     display magnification
%  xaxis:   xaxis input (default: 1)
%  yaxis:   yaxis input (default: 2)
%  input:   vector of input values (default: zeros(no_of_inputs))
%
%  Original Author: Steve Gunn (srg@ecs.soton.ac.uk)
%  Modified by Michael Mavroforakis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global figt4

color_shade = 1; %1:color in figure and shade degradation, else 0:Black and White
gridcellsX = 50; %num of grid cells in X-dimension (test:20, presentation:60-80)
gridcellsY = 50; %num of grid cells in Y-dimension (test:20, presentation:60-80)
marg = 0.1; %percent of margin around the border points

if (nargin < 7 | nargin > 12) % check correct number of arguments
    help svcplot
else
    epsilon = 1e-5;
    if (nargin < 12) input = zeros(1,size(X,2));, end
    if (nargin < 11) yaxis = 2;, end
    if (nargin < 10) xaxis = 1;, end
    if (nargin < 9) mag = 0.1;, end
    if (nargin < 8) aspect = 0;, end
    
    % Calculate values to Scale the axes
    xmin = min(X(:,xaxis));, xmax = max(X(:,xaxis));
    ymin = min(X(:,yaxis));, ymax = max(X(:,yaxis));
    xa = (xmax - xmin);, ya = (ymax - ymin);
    if (~aspect)
        if (0.75*abs(xa) < abs(ya))
            offadd = marg*(ya*4/3 - xa);,
            xmin = xmin - offadd - mag*marg*ya;, xmax = xmax + offadd + mag*marg*ya;
            ymin = ymin - mag*marg*ya;, ymax = ymax + mag*marg*ya;
        else
            offadd = marg*(xa*3/4 - ya);,
            xmin = xmin - mag*marg*xa;, xmax = xmax + mag*marg*xa;
            ymin = ymin - offadd - mag*marg*xa;, ymax = ymax + offadd + mag*marg*xa;
        end
    else
        xmin = xmin - mag*marg*xa;, xmax = xmax + mag*marg*xa;
        ymin = ymin - mag*marg*ya;, ymax = ymax + mag*marg*ya;
    end
    
    alpha_min=min(alpha);
    alpha_max=max(alpha);
    alpha_threshold = (alpha_max - alpha_min) * 0.01;
    alpha_threshold = alpha_threshold + alpha_min;
    
    
    % Plot function value
    [x,y] = meshgrid(xmin:(xmax-xmin)/gridcellsX:xmax,ymin:(ymax-ymin)/gridcellsY:ymax);
    z = bias*ones(size(x));
    wh = waitbar(0,'Plotting...');
    for x1 = 1 : size(x,1)
        for y1 = 1 : size(x,2)
            input(xaxis) = x(x1,y1);, input(yaxis) = y(x1,y1);
            for i = 1 : length(Y)
                if (abs(alpha(i)) >= 0)
                    z(x1,y1) = z(x1,y1) + Y(i)*alpha(i)*CalcKernel(input,X(i,:),ker,kpar1,kpar2);
                end
            end
        end
        
        waitbar((x1)/size(x,1)) ;
        drawnow
    end
    
    close(wh)
    
    figure(figt4);
    fh = gcf; %get the handle of current figure
    
    
    set(gca,'XLim',[xmin xmax],'YLim',[ymin ymax]);
    set(gca,'TickDir', 'in');
    set(gca, 'XTick', [floor(xmin):ceil(xmax)]);
    %         set(gca, 'XTickLabel', []); %Null list => Does not print Tick labels
    set(gca, 'YTick', [floor(ymin):ceil(ymax)]);
    %         set(gca, 'YTickLabel', []); %Null list => Does not print Tick labels
    set(gca,'Box', 'on');
    set(gca,'DataAspectRatio',[1 1 1 ]);
    %eliminate borders of figure
    old_gca_units = get(gca,'Units');
    set(gca,'Units','Normalized');
    set(gca,'Position',...
        [0.0 0.0 1.0 1.0]);
    set(gca,'Units',old_gca_units);
    
    l = (-min(min(z)) + max(max(z)))/2.0;
    if (color_shade == 1)
        sp = pcolor(x,y,z);
        shading interp %has bug and does not interpolate correctly last column
        %shading flat
        set(sp,'LineStyle','none');
        set(gca,'Clim',[-1, 1])
        set(gca,'Position',[0 0 1 1])
        %         axis off
        load cmap
        colormap(colmap)
        %colormap(gray)
    else
        whitebg('w')
    end
    % %
    % Plot Training points
    hold on
    for i = 1:size(Y)
        if (Y(i) == 1)
            if (color_shade == 1)
                plot(X(i,xaxis),X(i,yaxis),'rx','LineWidth',2) % Class A
            else
                plot(X(i,xaxis),X(i,yaxis),'x','LineWidth',1, 'MarkerSize', 4, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'none') % Class A
            end
        else
            if (color_shade == 1)
                plot(X(i,xaxis),X(i,yaxis),'bx','LineWidth',2) % Class B
            else
                %plot(X(i,xaxis),X(i,yaxis),'*','LineWidth',1, 'MarkerSize', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k') % Class B
                plot(X(i,xaxis),X(i,yaxis),'x','LineWidth',1, 'MarkerSize', 3, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'none') % Class B
            end
        end
        if (abs(alpha(i)) > alpha_threshold)
            if (color_shade == 1)
                plot(X(i,xaxis),X(i,yaxis),'ko','LineWidth',1, 'MarkerSize', 6) % Support Vector
            else
                plot(X(i,xaxis),X(i,yaxis),'x','LineWidth',1, 'MarkerSize', 5, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'none') % Support Vector
            end
        end
    end
    % Plot Boundary contour
    
    hold on
    if (color_shade == 1)
        contour(x,y,z,[0 0],'k')
        %     contour(x,y,z,[-0.5 -0.5],'b')
        contour(x,y,z,[-1 -1],'b-.')
        contour(x,y,z,[1 1],'r-.')
        %     contour(x,y,z,[0.5 0.5],'b')
    else
        zones = 1; %how many zones to be present in [0,1]
        steps = [0 : 1/zones : 1];
        for j = 1 : zones + 1
            if ((mod(j,2))==1),
                clsp = 'k-';
            elseif ((mod(j,2))==0),
                clsp = 'k:';
            end
            if (steps(j) == 0)
                contour(x,y,z,[steps(j) steps(j)],clsp, 'LineWidth', 2)
            else
                contour(x,y,z,[steps(j) steps(j)],clsp, 'LineWidth', 1)
                contour(x,y,z,[-steps(j) -steps(j)],clsp, 'LineWidth', 1)
            end
        end
    end
    hold off
end
