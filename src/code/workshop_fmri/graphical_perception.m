function graphical_perception(todo)

switch lower(todo)
    case 'decoding_visual_attributes'
        data = [15, 30, 50, 10, 32, 24, 40];
        
        n_data = length(data);
        data_lim = [min(data) - 0.1 * range(data), ...
                    max(data) + 0.1 * range(data)];

        figure;
        p = panel();
        p.margintop = 30;
        
        title('Can you sort the rows by magnitude?')
        axis off
        
        p.pack('h',7);
        
        p.de.margin = [3, 3, 1, 1];
        p(1).pack('v',7);
        p(2).pack('v',7);
        p(3).pack('v',7);
        p(4).pack('v',7);
        p(5).pack('v',7);
        p(6).pack('v',7);

        text_kv_pairs = {'HorizontalAlignment','center', ...
                     'VerticalAlignment','middle', ...
                     'FontUnits','normalized', ...
                     'FontSize',0.5, ...
                     'Units','normalized'};

        panel_labels = {'A','B','C','D','E','F','G'};

        for i = 1:n_data
            p(1,i).select(); 
            text(0.5,0.5,panel_labels{i}, text_kv_pairs{:}); 
            axis off
        end

        % Saturation
        % -----------------------------------------------------------------
        p(2).title('Saturation')
        for i = 1:n_data
            p(2,i).select(); 
            imagesc(data_lim(2) - data(i),data_lim); 
            colormap(gray); 
            axis off
        end

        % Volume
        % -----------------------------------------------------------------
        p(3).title('Volume');
        max_r = ceil((data_lim(2)/(4/3*pi))^(1/3));
        [X,Y,Z] = meshgrid(-max_r:0.2:max_r, -max_r:0.2:max_r, -max_r:0.2:max_r);
        R = sqrt(X.^2 + Y.^2 + Z.^2);
        for i = 1:n_data
            p(3,i).select();
            r = (data(i)/(4/3*pi))^(1/3);
            isosurface(X, Y, Z, R, r);
            set(gca,'DataAspectRatio',[1 1 1], ...
                    'XLim',[-(data_lim(2)/(4/3*pi))^(1/3),(data_lim(2)/(4/3*pi))^(1/3)], ...
                    'YLim',[-(data_lim(2)/(4/3*pi))^(1/3),(data_lim(2)/(4/3*pi))^(1/3)], ...
                    'ZLim',[-(data_lim(2)/(4/3*pi))^(1/3),(data_lim(2)/(4/3*pi))^(1/3)])
%             view(0,90);
            camlight
            axis off
        end

        % Area
        % -----------------------------------------------------------------
        p(4).title('Area');
        for i = 1:n_data
            p(4,i).select();


            draw_circle(0,0,sqrt(data(i)/pi));
            set(gca,'XLim',[-sqrt(data_lim(2)/pi),sqrt(data_lim(2)/pi)], ...
                    'YLim',[-sqrt(data_lim(2)/pi),sqrt(data_lim(2)/pi)])
            axis square;
            axis off
        end

        % Angle
        % -----------------------------------------------------------------
        p(5).title('Angle');
        for i = 1:n_data
            p(5,i).select();
            h_line_01 = line([0,1],[0,0]);
            set(h_line_01,'Color','k');
            h_line_02 = line([0,cos(data(i) * pi/180)],[0,sin(data(i) * pi/180)]);
            set(h_line_02,'Color','k');
            set(gca,'XLim',[0 1],'YLim',[0 1]);
            axis square;axis off
        end

        % Length
        % -----------------------------------------------------------------
        p(6).title('Length');
        for i = 1:n_data
            p(6,i).select();
            h_line = line([-data(i)/2,data(i)/2],[0,0]);
            set(h_line,'Color','k');
            set(gca,'XLim',[-data_lim(2)/2,data_lim(2)/2])
            axis off
        end

        % Position
        % -----------------------------------------------------------------
        p(7).select();
        p(7).title('Position')
        scatter(data,n_data:-1:1,'ko')
        set(gca,'XLim',data_lim, 'XTick',[],'YLim',[0.5,n_data+0.5],'YTick',[]);
            
    
    case 'decoding_differences'

        x = -5:0.05:3;
        y_a = 2.^x + 2;
        y_b1 = 2.^x + 3; % Difference is constant
        y_b2 = 2.^x + 0.05 * (x + 5) + 3; % Difference increases linearly
        y_b3 = 2.^x + 1.25.^x + 2.6723; % Difference increases exponentially
        h_fig = figure;
        pos_fig = get(h_fig,'Position');
        pos_fig(4) = pos_fig(3)*.4;
        set(h_fig,'Position',pos_fig);
        p = panel();
        p.margintop = 20;
        
        title('How does the difference between curves change with x?')
        axis off
        p.pack('h',3);
        

        p(1).select();
        p(1).hold('on');
        plot(x,y_a,'k-','LineWidth',2);
        plot(x,y_b1,'r-','LineWidth',2);
        set(gca,'XLim',[min(x),max(x)], ...
                'XTick',[], ...
                'YLim',[0,13], ...
                'YTick',[])
        xlabel('x')
        ylabel('y')
        axis square

        p(2).select();
        p(2).hold('on');
        plot(x,y_a,'k-','LineWidth',2);
        plot(x,y_b2,'r-','LineWidth',2);
        set(gca,'XLim',[min(x),max(x)], ...
                'XTick',[], ...
                'YLim',[0,13], ...
                'YTick',[])
        xlabel('x')
        ylabel('y')
        axis square    

        p(3).select();
        p(3).hold('on');
        plot(x,y_a,'k-','LineWidth',2);
        plot(x,y_b3,'r-','LineWidth',2);
        set(gca,'XLim',[min(x),max(x)], ...
                'XTick',[], ...
                'YLim',[0,13], ...
                'YTick',[])
        xlabel('x')
        ylabel('y')    
        axis square    
end

function h = draw_circle(x,y,r)
hold on
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit, yunit,'k-');
hold off

