function rousselet_plot(data,do_this)

    switch(do_this)        
        
        % Plot bar graph    
            case 'barplot'
            clear g
            figure;
            g = gramm('x',data.group,'y',data.value,'color',data.condition);
            g.stat_summary('geom',{'bar','black_errorbar'});
            g.set_title('Summary stats in bar plot');
            g.set_names('x',' ','y','Scores (a.u)');
            g.axe_property('YLim',[0,17]);
            g.draw();
        
        % Plot same data in boxplot
        case 'boxplot'
            figure;
            clear g
            g = gramm('x',data.group,'y',data.value,'color',data.condition);
            g.stat_boxplot();
            g.set_title('Summary stats in box plot');
            g.set_names('x',' ','y','Scores (a.u)');
            g.axe_property('YLim',[0,17]);
            g.draw();
        
        % Plot same in differences: condition2-condition1
        case 'differences_condition'
        
            % Make pairwise comparisons
            condition_1_value = data.value(strcmp(data.condition,'condition1'));
            condition_2_value = data.value(strcmp(data.condition,'condition2'));
            cond_group_1 = data.group(strcmp(data.condition,'condition1'));                
            plot_this.groups = cond_group_1;
            plot_this.values = condition_2_value-condition_1_value;
            plot_this.conditions = data.condition(1:22);

            figure;
            clear g
            g = gramm('x',plot_this.groups,'y',plot_this.values,'color',plot_this.conditions);
            g.geom_jitter();
            g.set_title('Differences: condition2 - condition1');
            g.set_names('x',' ','y','Scores differences(a.u)');            
            g.draw();
        
        otherwise
            disp('Something went wrong!')
    end
end