function data_simple = make_simple_plot_data()
    
    % Allen et al., 2012 - figure 2     
    resp_nor        = normrnd(5,1,[1,50])'; % normal distribution
    resp_nor(find(min(resp_nor)==resp_nor)) = -min(resp_nor);
    resp_chi        = chi2rnd(5,[1,50])'; % a generalized ?2 distribution with 2 degrees of freedom
    resp_chi(find(min(resp_chi)==resp_chi)) = -min(resp_chi);
    resp_two_nor    = [normrnd(3.5,0.5,[1,25]), normrnd(6.5,0.5,[1,25])]'; % equal mixture of two normal distributions with different means
    data_simple.response   = [resp_nor; resp_chi; resp_two_nor];

    for i=1:50
        condition_1{i} = '1'; 
        condition_2{i} = '2';
        condition_3{i} = '3';
    end
    data_simple.condition = [condition_1'; condition_2'; condition_3'];
    
    cd(fileparts(which('data_anscombe.mat')))
    save data_simple data_simple 
    
end