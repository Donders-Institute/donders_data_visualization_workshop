function anscombe = make_anscombes_quartet_data()

    % Anscombe's quartet - data 
    anscombe.x1 = [10 8 13 9 11 14 6 4 12 7 5];
    anscombe.x2 = anscombe.x1;
    anscombe.x3 = anscombe.x1;
    anscombe.x4 = [8 8 8 8 8 8 8 19 8 8 8];

    anscombe.y1 = [8.04 6.95 7.58 8.81 8.33 9.96 7.24 4.26 10.84 4.82 5.68];
    anscombe.y2 = [9.14 8.14 8.74 8.77 9.26 8.1 6.13 3.1 9.13 7.26 4.74];
    anscombe.y3 = [7.46 6.77 12.74 7.11 7.81 8.84 6.08 5.39 8.15 6.42 5.73];
    anscombe.y4 = [6.58 5.76 7.71 8.84 8.47 7.04 5.25 12.5 5.56 7.91 6.89];

    % Compute means
    anscombe.mean_x(1) = mean(anscombe.x1); anscombe.mean_y(1) = mean(anscombe.y1);
    anscombe.mean_x(2) = mean(anscombe.x2); anscombe.mean_y(2) = mean(anscombe.y2);
    anscombe.mean_x(3) = mean(anscombe.x3); anscombe.mean_y(3) = mean(anscombe.y3);
    anscombe.mean_x(4) = mean(anscombe.x4); anscombe.mean_y(4) = mean(anscombe.y4);

    % Compute variances
    anscombe.var_x(1) = var(anscombe.x1); anscombe.var_y(1) = var(anscombe.y1);
    anscombe.var_x(2) = var(anscombe.x2); anscombe.var_y(2) = var(anscombe.y2);
    anscombe.var_x(3) = var(anscombe.x3); anscombe.var_y(3) = var(anscombe.y3);
    anscombe.var_x(4) = var(anscombe.x4); anscombe.var_y(4) = var(anscombe.y4);

    anscombe.label_x = {'x1','x2','x3','x4'};
    anscombe.label_y = {'y1','y2','y3','y4'};
    
end