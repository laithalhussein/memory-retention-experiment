close all;
clear all;

%in this code we normalize the data to the last 2 or 3 final adaptation states
%run this in the MT_last - Data folder

%first get the new value to normalize for each condition

trials = [1:2:60]';
early=1:10;
late = 21:30;

pGL = load('pff_gl_all.mat'); pGL = pGL.pff_gl_all;
pGL(end+1,:) = NaN;
pAS = load('pff_as_all.mat'); pAS = pAS.pff_as_all;
pAL = load('pff_al_all.mat'); pAL = pAL.pff_al_all;

vGL = load('GL_all.mat'); vGL = vGL.GL_all;
vAS = load('AS_all.mat'); vAS = vAS.AS_all;
vAL = load('AL_all.mat'); vAL = vAL.AL_all;

vAL = window_as(vAL);
vAS = window_as(vAS);
vGL = window_as(vGL);

pGL_avg = nanmean(pGL,1);
pAL_avg = nanmean(pAL,1);
pAS_avg = nanmean(pAS,1);

vGL_avg = nanmean(vGL,1);
vAL_avg = nanmean(vAL,1);
vAS_avg = nanmean(vAS,1);

num_norm_EC_trials = 2; %how many error clamp trials to normalize by

pGL_norm_val = nanmean(pGL_avg(end-30+1-num_norm_EC_trials+1:end-30+1));
pAL_norm_val = nanmean(pAL_avg(end-30+1-num_norm_EC_trials+1:end-30+1));
pAS_norm_val = nanmean(pAS_avg(end-30+1-num_norm_EC_trials+1:end-30+1));

vGL_norm_val = nanmean(vGL_avg(end-30+1-num_norm_EC_trials+1:end-30+1));
vAL_norm_val = nanmean(vAL_avg(end-30+1-num_norm_EC_trials+1:end-30+1));
vAS_norm_val = nanmean(vAS_avg(end-30+1-num_norm_EC_trials+1:end-30+1));

%% get the new normalized retention and plot them

pGL_ret_norm = pGL(:,end-29:end)/pGL_norm_val;
pGL_ret_norm_avg = nanmean(pGL_ret_norm,1);
pGL_ret_norm_std = nanstd(pGL_ret_norm,0,1);

pAL_ret_norm = pAL(:,end-29:end)/pAL_norm_val;
pAL_ret_norm_avg = nanmean(pAL_ret_norm,1);
pAL_ret_norm_std = nanstd(pAL_ret_norm,0,1);

pAS_ret_norm = pAS(:,end-29:end)/pAS_norm_val;
pAS_ret_norm_avg = nanmean(pAS_ret_norm,1);
pAS_ret_norm_std = nanstd(pAS_ret_norm,0,1);


vGL_ret_norm = vGL(:,end-29:end)/vGL_norm_val;
vGL_ret_norm_avg = nanmean(vGL_ret_norm,1);
vGL_ret_norm_std = nanstd(vGL_ret_norm,0,1);

vAL_ret_norm = vAL(:,end-29:end)/vAL_norm_val;
vAL_ret_norm_avg = nanmean(vAL_ret_norm,1);
vAL_ret_norm_std = nanstd(vAL_ret_norm,0,1);

vAS_ret_norm = vAS(:,end-29:end)/vAS_norm_val;
vAS_ret_norm_avg = nanmean(vAS_ret_norm,1);
vAS_ret_norm_std = nanstd(vAS_ret_norm,0,1);

%% position

figure; 
plot(trials,pGL_ret_norm_avg,'g', 'linewidth', 2); hold on;
plot(trials,pAL_ret_norm_avg,'r', 'linewidth', 2);
plot(trials,pAS_ret_norm_avg,'b', 'linewidth', 2);

standard_error_shading_11_07_14(pGL_ret_norm_avg,pGL_ret_norm_std,trials,13,'g');
standard_error_shading_11_07_14(pAL_ret_norm_avg,pAL_ret_norm_std,trials,14,'r');
standard_error_shading_11_07_14(pAS_ret_norm_avg,pAS_ret_norm_std,trials,14,'b');
xlabel('Trials');
ylabel('Adaptation coefficient');

ylim([-0.2,1.2]);

title('Position data');

%% make the bar graph for position

p_early_avg = [mean(pAL_ret_norm_avg(early)), mean(pGL_ret_norm_avg(early)), mean(pAS_ret_norm_avg(early))];
p_early_std = [std(pAL_ret_norm_avg(early)), std(pGL_ret_norm_avg(early)), std(pAS_ret_norm_avg(early))];

p_late_avg = [mean(pAL_ret_norm_avg(late)), mean(pGL_ret_norm_avg(late)), mean(pAS_ret_norm_avg(late))];
p_late_std = [std(pAL_ret_norm_avg(late)), std(pGL_ret_norm_avg(late)), std(pAS_ret_norm_avg(late))];

figure;
x1=[.25 .75;.25 .75;.25 .75]-0.25;
x2=[.75 1.25;.75 1.25;.75 1.25];
Training_sequence={'abrupt long','gradual','abrupt short'};
abrupt_short_adapt_color=[0,0,256]/256;
abrupt_long_adapt_color=[256,0,0]/256;
gradual_adapt_color=[0,256,0]/256;
Training_color_seq=[abrupt_long_adapt_color;gradual_adapt_color;abrupt_short_adapt_color];

h_dummy=zeros(3,3);
y=0:0.2:1;

p_early_avg=[[nan,nan,nan]',p_early_avg'];
p_early_se=[[nan,nan,nan]',p_early_std'*14.^-.5];

p_late_avg=[[nan,nan,nan]',p_late_avg'];
p_late_se=[[nan,nan,nan]',p_late_std'*14.^-.5];

h_dummy(3,1)=1; h_dummy(3,2) = 1;

plot_bar_with_error_27_01_15(x1',p_early_avg',p_early_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
title('Position data: early');
ylim([0,1]);
xlim([0,1]);

figure;
plot_bar_with_error_27_01_15(x1',p_late_avg',p_late_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
title('Position data: late');
ylim([0,1]);
xlim([0,1]);

%% velocity

figure; 
plot(trials,vGL_ret_norm_avg,'g', 'linewidth', 2); hold on;
plot(trials,vAL_ret_norm_avg,'r', 'linewidth', 2);
plot(trials,vAS_ret_norm_avg,'b', 'linewidth', 2);

standard_error_shading_11_07_14(vGL_ret_norm_avg,vGL_ret_norm_std,trials,24,'g');
standard_error_shading_11_07_14(vAL_ret_norm_avg,vAL_ret_norm_std,trials,24,'r');
standard_error_shading_11_07_14(vAS_ret_norm_avg,vAS_ret_norm_std,trials,24,'b');
xlabel('Trials');
ylabel('Adaptation coefficient');

title('Velocity data');

ylim([-0.2,1.2]);

%% bar graphs for velocity

v_early_avg = [mean(vAL_ret_norm_avg(early)), mean(vGL_ret_norm_avg(early)), mean(vAS_ret_norm_avg(early))];
v_early_std = [std(vAL_ret_norm_avg(early)), std(vGL_ret_norm_avg(early)), std(vAS_ret_norm_avg(early))];

v_late_avg = [mean(vAL_ret_norm_avg(late)), mean(vGL_ret_norm_avg(late)), mean(vAS_ret_norm_avg(late))];
v_late_std = [std(vAL_ret_norm_avg(late)), std(vGL_ret_norm_avg(late)), std(vAS_ret_norm_avg(late))];

figure;
x1=[.25 .75;.25 .75;.25 .75]-0.25;
x2=[.75 1.25;.75 1.25;.75 1.25];
Training_sequence={'abrupt long','gradual','abrupt short'};
abrupt_short_adapt_color=[0,0,256]/256;
abrupt_long_adapt_color=[256,0,0]/256;
gradual_adapt_color=[0,256,0]/256;
Training_color_seq=[abrupt_long_adapt_color;gradual_adapt_color;abrupt_short_adapt_color];

h_dummy=zeros(3,3);
y=0:0.2:1;

v_early_avg=[[nan,nan,nan]',v_early_avg'];
v_early_se=[[nan,nan,nan]',v_early_std'*24.^-.5];

v_late_avg=[[nan,nan,nan]',v_late_avg'];
v_late_se=[[nan,nan,nan]',v_late_std'*24.^-.5];

h_dummy(3,1)=1; h_dummy(3,2) = 1;

plot_bar_with_error_27_01_15(x1',v_early_avg',v_early_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
title('Velocity data: early');
ylim([0,1]);
xlim([0,1]);

figure;
plot_bar_with_error_27_01_15(x1',v_late_avg',v_late_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
title('Velocity data: late');
ylim([0,1]);
xlim([0,1]);


%% %%some stats
%position
% [p,h,~,stats] = ttest2(alp,glp)
% 
% [p,h,~,stats] = ttest2(alp,asp)
% 
% [p,h,~,stats] = ttest2(glp,asp)

%velocity
% [p,h,~,stats] = ttest2(alv,glv)
% 
% [p,h,~,stats] = ttest2(alv,asv)
% 
% [p,h,~,stats] = ttest2(glv,asv)



%%%%%


%% final adaptation ANOVAS (1-way, the TS being the unique factor)

%pFF
pfa = [pAS(:,end-30), pAL(:,end-30), pGL(:,end-30)];
p_pfa=anova1(pfa);

%vFF
vfa = [vAS(:,end-30), vAL(:,end-30), vGL(:,end-30)];
p_vfa=anova1(vfa);

%% retention ANOVAS (normalized and unnormalized, early and late)

%first get the data for each subject

%%%%%%%%%%%% position %%%%%%%%%%%%%
pGL_ret = pGL(:,end-29:end);
pAL_ret = pAL(:,end-29:end);
pAS_ret = pAS(:,end-29:end);

%get the average of early and late periods for each subject
pGL_ret_early = nanmean(pGL_ret(:,early),2);   pGL_ret_late = nanmean(pGL_ret(:,late),2);
pAL_ret_early = nanmean(pAL_ret(:,early),2);   pAL_ret_late = nanmean(pAL_ret(:,late),2);
pAS_ret_early = nanmean(pAS_ret(:,early),2);   pAS_ret_late = nanmean(pAS_ret(:,late),2);

pGL_ret_norm_early = nanmean(pGL_ret_norm(:,early),2);     pGL_ret_norm_late = nanmean(pGL_ret_norm(:,late),2);
pAL_ret_norm_early = nanmean(pAL_ret_norm(:,early),2);     pAL_ret_norm_late = nanmean(pAL_ret_norm(:,late),2);
pAS_ret_norm_early = nanmean(pAS_ret_norm(:,early),2);     pAS_ret_norm_late = nanmean(pAS_ret_norm(:,late),2);

%put the data in matrices
pos_early_ret_mat = [pGL_ret_early,pAL_ret_early,pAS_ret_early];
pos_late_ret_mat = [pGL_ret_late,pAL_ret_late,pAS_ret_late];

pos_early_ret_norm_mat = [pGL_ret_norm_early,pAL_ret_norm_early,pAS_ret_norm_early];
pos_late_ret_norm_mat = [pGL_ret_norm_late,pAL_ret_norm_late,pAS_ret_norm_late];

%%%%%%%%%% velocity %%%%%%%%%%%
vGL_ret = vGL(:,end-29:end);
vAL_ret = vAL(:,end-29:end);
vAS_ret = vAS(:,end-29:end);

%get the average of early and late periods for each subject
vGL_ret_early = nanmean(vGL_ret(:,early),2);   vGL_ret_late = nanmean(vGL_ret(:,late),2);
vAL_ret_early = nanmean(vAL_ret(:,early),2);   vAL_ret_late = nanmean(vAL_ret(:,late),2);
vAS_ret_early = nanmean(vAS_ret(:,early),2);   vAS_ret_late = nanmean(vAS_ret(:,late),2);

vGL_ret_norm_early = nanmean(vGL_ret_norm(:,early),2);     vGL_ret_norm_late = nanmean(vGL_ret_norm(:,late),2);
vAL_ret_norm_early = nanmean(vAL_ret_norm(:,early),2);     vAL_ret_norm_late = nanmean(vAL_ret_norm(:,late),2);
vAS_ret_norm_early = nanmean(vAS_ret_norm(:,early),2);     vAS_ret_norm_late = nanmean(vAS_ret_norm(:,late),2);

%put the data in matrices
vel_early_ret_mat = [vGL_ret_early, vAL_ret_early, vAS_ret_early];
vel_late_ret_mat = [vGL_ret_late, vAL_ret_late, vAS_ret_late];

vel_early_ret_norm_mat = [vGL_ret_norm_early,vAL_ret_norm_early,vAS_ret_norm_early];
vel_late_ret_norm_mat = [vGL_ret_norm_late,vAL_ret_norm_late,vAS_ret_norm_late];

%%% do the comparisons

%position, unnormalized
p_pos_early_ret = anova1(pos_early_ret_mat);
p_pos_late_ret = anova1(pos_late_ret_mat);

%position, normalized
p_pos_early_ret_norm = anova1(pos_early_ret_norm_mat);
p_pos_late_ret_norm = anova1(pos_late_ret_norm_mat);

%velocity, unnormalized
v_pos_early_ret = anova1(vel_early_ret_mat);
v_pos_late_ret = anova1(vel_late_ret_mat);

%velocity, normalized
v_pos_early_ret_norm = anova1(vel_early_ret_norm_mat);
v_pos_late_ret_norm = anova1(vel_late_ret_norm_mat);

%% ANOVAS for time constants

% experiment_conditions=cellstr([char(ones(length(alv),1)*'A');char(ones(length(glv),1)*'G');char(ones(length(asv),1)*'A')]);
% trial_conditions=cellstr(repmat([char(ones(length(alv),1)*'L'); char(ones(length(glv),1)*'L'); char(ones(length(asv),1)*'S')],1,1));
% Observations=[alv,glv,asv]';
% p=anovan(Observations,{experiment_conditions; trial_conditions },'model','full')

% experiment_conditions=cellstr([char(ones(length(alv),1)*'AL');char(ones(length(glv),1)*'GL');char(ones(length(asv),1)*'AS')]);
% Observations=[alv,glv,asv]';
% [p1,~,stats1]=anovan(Observations,{experiment_conditions},'model','full');
% 
% [c,~,~,gnames] = multcompare(stats1);
% [gnames(c(:,1)), gnames(c(:,2)), num2cell(c(:,3:6))]


















