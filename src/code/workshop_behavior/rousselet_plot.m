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
            
        case 'paired_groups'
            
            % Make pairwise comparisons
            figure;
            clear g
            g(1,1) = gramm('x',data.condition(strcmp(data.group,'group1')),'y',data.value(strcmp(data.group,'group1')),...
                'color',data.participant(strcmp(data.group,'group1')));
            g(1,1).geom_line();
            g(1,1).geom_point();
            g(1,1).set_title('group 1');
            g(1,1).set_names('x',' ','y','Scores (a.u)');                        
            g(1,1).no_legend();
            
            g(1,2) = gramm('x',data.condition(strcmp(data.group,'group2')),'y',data.value(strcmp(data.group,'group2')),...
                'color',data.participant(strcmp(data.group,'group2')));
            g(1,2).geom_line();
            g(1,2).geom_point();
            g(1,2).set_title('group 2');
            g(1,2).set_names('x',' ','y','Scores (a.u)');                        
            g(1,2).no_legend();
            
            g.axe_property('YLim',[0,20]);
            g.set_title('Paired observations')
            g.draw();
            
            case 'paired_conditions'
            
            % Make pairwise comparisons
            figure;
            clear g
            g = gramm('x',data.value(strcmp(data.condition,'condition1')),...
                'y',data.value(strcmp(data.condition,'condition2')),...
                'color',data.group(strcmp(data.condition,'condition1')));            
            g.geom_point();
            g.set_title('group 1');
            g.set_names('x','Condition 1','y','Condition 2');                                    
            
            %g.axe_property('YLim',[0,20]);
            g.set_title('Paired observations')
            g.geom_abline();
            g.draw();
            
        
        otherwise
            disp('Something went wrong!')
    end
end