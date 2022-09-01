close all;
%%%%%%%%%%%%normalized%%%%%%%%%%%%%%%%%
experiment_conditions=cellstr([char(ones(MT_num_of_subjects*window_length*3,1)*'AS'); ...
    char(ones(MT_num_of_subjects*window_length*3,1)*'AL');char(ones(MT_num_of_subjects*window_length*3,1)*'GR')]);
trial_conditions=cellstr(repmat([char(ones(MT_num_of_subjects*window_length,1)*'erl');char(ones(MT_num_of_subjects*window_length,1)*'mid');...
    char(ones(MT_num_of_subjects*window_length,1)*'lat')],3,1));
Observations=[[abrupt_short_wash_data_all_norm{:,1}],[abrupt_long_wash_data_all_norm{:,1}],[gradual_wash_data_all_norm{:,1}]]';
[p,a,stats1]=anovan(Observations,{experiment_conditions,trial_conditions},'model','full','varnames',{'traing type';'decay epoch'});
[c,m,h,nms] = multcompare(stats1,'alpha',0.05,'ctype','hsd');



%%%%%%%%%%unnormalized%%%%%%%%%%%
Observations=[[abrupt_short_wash_data_all{:,1}],[abrupt_long_wash_data_all{:,1}],[gradual_wash_data_all{:,1}]]';
[p1,a1,stats2]=anovan(Observations,{experiment_conditions,trial_conditions},'model','full','varnames',{'traing type';'decay epoch'});
[c1,m1,h1,nms1] = multcompare(stats2,'alpha',0.05,'ctype','hsd');














