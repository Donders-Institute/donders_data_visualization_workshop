function simple_plot(do_this, data_dir)

full_filename = fullfile(data_dir,'data_simple.mat');
if exist(full_filename, 'file')
  load(full_filename)
else
  % File does not exist.
  error_message = sprintf('File does not exist: %s\n Please run the following command:\n data_allen = make_simple_plot_data;\n', full_filename);
  error(error_message); 
end

switch lower(do_this)
    case 'barplot'
        
        %          
        clear g        
        
        g = gramm('x',data_simple.condition,'y',data_simple.response,'color',data_simple.condition);
        g.no_legend();
        g.set_names('x','conditions','y','some measurement (units)');

        % Compute averages with confidence interval and plot barplot
        g.stat_summary('geom',{'bar','black_errorbar'},'dodge',1,'width',1.2);
        g.set_title('barplot');
        
        g.axe_property('YLim',[0,8]);
        figure('Position',[100 100 400 500]);
        g.draw();
        
    case 'boxplot'        
        clear g        
        
        g = gramm('x',data_simple.condition,'y',data_simple.response,'color',data_simple.condition);
        g.no_legend();
        g.set_names('x','conditions','y','some measurement (units)');

        % Compute averages with confidence interval and plot boxplot
        g.stat_boxplot('dodge',1,'width',1.2);
        g.set_title('boxplot');
                
        figure('Position',[100 100 400 500]);
        g.draw();
        
    case 'violinplot'        
        clear g        
        
        g = gramm('x',data_simple.condition,'y',data_simple.response,'color',data_simple.condition);
        g.no_legend();
        g.set_names('x','conditions','y','some measurement (units)');

        % Compute averages with confidence interval and plot violinplot
        g.stat_violin('normalization','count','fill','transparent');       
        g.geom_jitter();
        g.set_title('violinplot');
        
        figure('Position',[100 100 400 500]);
        g.draw();
        
    case 'violinboxplot'
        clear g        
        
        g = gramm('x',data_simple.condition,'y',data_simple.response,'color',data_simple.condition);
        g.no_legend();
        g.set_names('x','conditions','y','some measurement (units)');

        % Compute averages with confidence interval and plot violinplot
        g.stat_violin('normalization','count','fill','transparent');
        g.stat_boxplot('width',0.15);        
        g.set_title('violinplot');
        
        figure('Position',[100 100 400 500]);
        g.draw();
        
    otherwise
        warning('Unknown method. Please check your inputs.')
        
end