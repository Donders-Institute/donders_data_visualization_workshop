function anscombes_plot(anscombe,do_this)

switch lower(do_this)
    case 'plot_statistics'
        %%
        % Anscombe's quartet - plot summary stats - means
        clear g 
        figure;
        g(1,1)=gramm('x',{anscombe.label_x{1},anscombe.label_y{1}},'y',[anscombe.mean_x(1),anscombe.mean_y(1)]);
        g(1,1).stat_summary('geom',{'bar'});
        %g(2,2).set_names('x',' ','y',' ');

        g(1,2)=gramm('x',{anscombe.label_x{2},anscombe.label_y{2}},'y',[anscombe.mean_x(2),anscombe.mean_y(2)]);
        g(1,2).stat_summary('geom',{'bar'});
        %g(2,2).set_names('x',' ','y',' ');

        g(2,1)=gramm('x',{anscombe.label_x{3},anscombe.label_y{3}},'y',[anscombe.mean_x(3),anscombe.mean_y(3)]);
        g(2,1).stat_summary('geom',{'bar'});
        %g(2,2).set_names('x',' ','y',' ');

        g(2,2)=gramm('x',{anscombe.label_x{4},anscombe.label_y{4}},'y',[anscombe.mean_x(4),anscombe.mean_y(4)]);
        g(2,2).stat_summary('geom',{'bar'});

        g.set_names('x',' ','y',' ');
        g.set_title('Means of x and y');
        g.draw();
        %%
        % Anscombe's quartet - plot summary stats - variances
        clear g 
        figure;
        g(1,1)=gramm('x',{anscombe.label_x{1},anscombe.label_y{1}},'y',[anscombe.var_x(1),anscombe.var_y(1)]);
        g(1,1).stat_summary('geom',{'bar'});        

        g(1,2)=gramm('x',{anscombe.label_x{2},anscombe.label_y{2}},'y',[anscombe.var_x(2),anscombe.var_y(2)]);
        g(1,2).stat_summary('geom',{'bar'});        

        g(2,1)=gramm('x',{anscombe.label_x{3},anscombe.label_y{3}},'y',[anscombe.var_x(3),anscombe.var_y(3)]);
        g(2,1).stat_summary('geom',{'bar'});        

        g(2,2)=gramm('x',{anscombe.label_x{4},anscombe.label_y{4}},'y',[anscombe.var_x(4),anscombe.var_y(4)]);
        g(2,2).stat_summary('geom',{'bar'});

        g.set_names('x',' ','y',' ');
        g.set_title('Sample variances of x and y');
        g.set_color_options('map','brewer2');
        g.draw();
        %%
        %  Anscombe's quartet - plot linear regression line and equation of the line
        clear g 
        figure;
        g(1,1)=gramm('x',anscombe.x1,'y',anscombe.y1);
        g(1,1).set_names('x','x1','y','y1');
        g(1,1).stat_glm('disp_fit',true);

        g(1,2)=gramm('x',anscombe.x2,'y',anscombe.y2);
        g(1,2).set_names('x','x2','y','y2');
        g(1,2).stat_glm('disp_fit',true);

        g(2,1)=gramm('x',anscombe.x3,'y',anscombe.y3);
        g(2,1).set_names('x','x3','y','y3');
        g(2,1).stat_glm('disp_fit',true);

        g(2,2)=gramm('x',anscombe.x4,'y',anscombe.y4);
        g(2,2).set_names('x','x4','y','y4');
        g(2,2).stat_glm('disp_fit',true);
        
        g.set_title('Linear regression line for the four datasets');
        g.axe_property('YLim',[0 12]);
        g.set_color_options('map','matlab');
        g.draw();
        
        %%
        % Print the values on command line for convenience
        % 1. Number of observations (x,y-pairs)
        fprintf(1, '01. Number of observations (x,y-pairs) \n Set 1: %.0f \n Set 2: %.0f \n Set 3: %.0f \n Set 4: %.0f \n', ... 
                numel(anscombe.x1), ...
                numel(anscombe.x2), ...
                numel(anscombe.x3), ...
                numel(anscombe.x4));

        % 2. Mean of X's in each set
        fprintf(1, '02. Mean of X''s in each set \n Set 1: %.2f \n Set 2: %.2f \n Set 3: %.2f \n Set 4: %.2f \n', ... 
                mean([anscombe.x1;anscombe.x2;anscombe.x3;anscombe.x4],2));

        % 3. Mean of Y's in each set
        fprintf(1, '03. Mean of Y''s in each set \n Set 1: %.2f \n Set 2: %.2f \n Set 3: %.2f \n Set 4: %.2f \n', ... 
                mean([anscombe.y1;anscombe.y2;anscombe.y3;anscombe.y4],2));

        % 4. Linear regression coefficients
        fprintf(1, '04. Linear regression coefficients (intercept, slope) in each set \n Set 1: %.2f, %.2f \n Set 2: %.2f, %.2f \n Set 3: %.2f, %.2f \n Set 4: %.2f, %.2f \n', ... 
                regress(anscombe.y1',[ones(11,1) anscombe.x1']), ...
                regress(anscombe.y2',[ones(11,1) anscombe.x2']), ...
                regress(anscombe.y3',[ones(11,1) anscombe.x3']), ...
                regress(anscombe.y4',[ones(11,1) anscombe.x4']));

        % 5. Sum of squares
        fprintf(1, '05. Sum of squares of X''s in each set \n Set 1: %.2f \n Set 2: %.2f \n Set 3: %.2f \n Set 4: %.2f \n', ... 
                sum((anscombe.x1 - mean(anscombe.x1)).^2), ...
                sum((anscombe.x2 - mean(anscombe.x2)).^2), ...
                sum((anscombe.x3 - mean(anscombe.x3)).^2), ...
                sum((anscombe.x4 - mean(anscombe.x4)).^2));

        % 6. Correlation coefficients
        fprintf(1, '06. Correlation coefficients in each set \n Set 1: %.2f \n Set 2: %.2f \n Set 3: %.2f \n Set 4: %.2f \n', ... 
                corr(anscombe.x1',anscombe.y1','type','pearson'), ...
                corr(anscombe.x2',anscombe.y2','type','pearson'), ...
                corr(anscombe.x3',anscombe.y3','type','pearson'), ...
                corr(anscombe.x4',anscombe.y4','type','pearson'));
    
    case 'plot_raw_data'
        
        % Anscombe's quartet - plot raw data plots
        clear g 
        figure;

        g=gramm('x',anscombe.x1,'y',anscombe.y1);
        g.set_names('x','x1','y','y1');
        g.geom_point();

        g(1,1)=gramm('x',anscombe.x1,'y',anscombe.y1);
        g(1,1).set_names('x','x1','y','y1');
        g(1,1).geom_point();

        g(1,2)=gramm('x',anscombe.x2,'y',anscombe.y2);
        g(1,2).set_names('x','x2','y','y2');
        g(1,2).geom_point();

        g(2,1)=gramm('x',anscombe.x3,'y',anscombe.y3);
        g(2,1).set_names('x','x3','y','y3');
        g(2,1).geom_point();

        g(2,2)=gramm('x',anscombe.x4,'y',anscombe.y4);
        g(2,2).set_names('x','x4','y','y4');
        g(2,2).geom_point();

        g.draw();        

end