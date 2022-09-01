close all;
home;

%%%in this script we calculate the noise of normalized late period data
%%%from the model obtained via boostrap

%first load the bootstrap estimates
load('params_vff.mat');
load('params_pff.mat');

num_boot = size(params_vff,1);

late_ret_vff = nan(num_boot,3); %3 for AL, GL, and AS
late_ret_pff = nan(num_boot,3);

early_ret_vff = nan(num_boot,3);
early_ret_pff = nan(num_boot,3);

% ret_idx = 175;
% Abrupt_short_late_wash=Abrupt_short_output(:,31:31 + 20);
% Abrupt_long_late_wash=Abrupt_long_output(:,ret_idx:ret_idx + 20);
% Gradual_late_wash=Gradual_output(:,ret_idx:ret_idx + 20);

for k=1:num_boot
    [~, ~, vo_tmp] = run_two_state_model_noise_est(squeeze(params_vff(k,:,1)), 1);
    [~, ~, po_tmp] = run_two_state_model_noise_est(squeeze(params_pff(k,:,1)), 0);
    
    late_ret_vff(k,1) = nanmean(vo_tmp.al(end-19:end));
    late_ret_vff(k,2) = nanmean(vo_tmp.gl(end-19:end));
    late_ret_vff(k,3) = nanmean(vo_tmp.as(end-19:end));
    
    late_ret_pff(k,1) = nanmean(po_tmp.al(end-19:end));
    late_ret_pff(k,2) = nanmean(po_tmp.gl(end-19:end));
    late_ret_pff(k,3) = nanmean(po_tmp.as(end-19:end));
    
    early_ret_vff(k,1) = nanmean(vo_tmp.al(175:195));
    early_ret_vff(k,2) = nanmean(vo_tmp.gl(175:195));
    early_ret_vff(k,3) = nanmean(vo_tmp.as(31:51));
    
    early_ret_pff(k,1) = nanmean(po_tmp.al(175:195));
    early_ret_pff(k,2) = nanmean(po_tmp.gl(175:195));
    early_ret_pff(k,3) = nanmean(po_tmp.as(31:51));
    
   %keyboard;
    
    %frac_all(k) = v_slow.al(160) / v_overall.al(160);
end


%% Results
%%%late results
%%%pFF
%AL -> 0.2116
%GL -> 0.1547
%AS -> 0.0545

%%%vFF
%AL -> 0.1942
%GL -> 0.1506
%AS -> 0.0576

%%%early results
%%%vFF
%AL -> .1017
%GL -> .0821
%AS -> .0762

%%%pFF
%AL -> 0.1371
%GL -> 0.1063
%AS -> .0849


%% now make the model bar plots

ret_late_pFF_avg = [0.27, 0.24, 0.09]*100;
ret_late_pFF_std = [0.2116, 0.1547, 0.0545]*100;

ret_late_vFF_avg = [0.4, 0.35, 0.13]*100;
ret_late_vFF_std = [0.1942, 0.1506, 0.0576]*100;

figure;
x1=[.25 .75;.25 .75;.25 .75]-0.25;
x2=[.75 1.25;.75 1.25;.75 1.25];
Training_sequence={'abrupt long','gradual','abrupt short'};
abrupt_short_adapt_color=[0,0,256]/256;
abrupt_long_adapt_color=[256,0,0]/256;
gradual_adapt_color=[0,256,0]/256;
Training_color_seq=[abrupt_long_adapt_color;gradual_adapt_color;abrupt_short_adapt_color];

h_dummy=zeros(3,3);
y=0:20:100;

ret_late_pFF_avg=[[nan,nan,nan]',ret_late_pFF_avg'];
p_late_pFF_se=[[nan,nan,nan]',ret_late_pFF_std'*14.^-.5];

ret_late_vFF_avg=[[nan,nan,nan]',ret_late_vFF_avg'];
p_late_vFF_se=[[nan,nan,nan]',ret_late_vFF_std'*8.^-.5];
%p_late_vFF_se=[[nan,nan,nan]',ret_late_vFF_std'];

h_dummy(3,1)=1; h_dummy(3,2) = 1;

plot_bar_with_error_27_01_15(x1',ret_late_pFF_avg',p_late_pFF_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
title('normalized late period retention, pFF');
ylim([-20,100]);
xlim([0,1]);
ylabel('% Retention');
set(gca,'xTick',[]);

figure;
plot_bar_with_error_27_01_15(x1',ret_late_vFF_avg',p_late_vFF_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
title('normalized late period retention, vFF');
ylim([-20,100]);
xlim([0,1]);
ylabel('% Retention');
set(gca,'xTick',[]);

%% repeat for the early data

ret_early_pFF_avg = [0.57, 0.55, 0.38]*100;
ret_early_pFF_std = [0.1371, 0.1063, 0.0849]*100;

ret_early_vFF_avg = [0.61, 0.56, 0.27]*100;
ret_early_vFF_std = [0.1017, 0.0821, 0.0762]*100;

figure;

ret_early_pFF_avg=[[nan,nan,nan]',ret_early_pFF_avg'];
p_early_pFF_se=[[nan,nan,nan]',ret_early_pFF_std'*14.^-.5];

ret_early_vFF_avg=[[nan,nan,nan]',ret_early_vFF_avg'];
p_late_vFF_se=[[nan,nan,nan]',ret_early_vFF_std'*8.^-.5];
%p_late_vFF_se=[[nan,nan,nan]',ret_late_vFF_std'];

h_dummy(3,1)=1; h_dummy(3,2) = 1;

plot_bar_with_error_27_01_15(x1',ret_early_pFF_avg',p_early_pFF_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
title('normalized early period retention, pFF');
ylim([-20,100]);
xlim([0,1]);
ylabel('% Retention');
set(gca,'xTick',[]);

figure;
plot_bar_with_error_27_01_15(x1',ret_early_vFF_avg',p_late_vFF_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
title('normalized early period retention, vFF');
ylim([-20,100]);
xlim([0,1]);
ylabel('% Retention');
set(gca,'xTick',[]);










