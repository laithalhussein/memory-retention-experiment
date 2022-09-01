%%% plot force profiles for training schedules

clear all;
close all;
home; 

%for each training schedule, plot the ideal, with early and late forces
%during training as well as decay

%we have the means, but need std to show the se


%% 
data = 'multiple_training_exp_dat_all_24_subjects_testwin_15_washwin_2';
load(data);

nn = 14;

%% AL

%%%%NOTE: zoom in on all the data by cutting off 300 ms on both ends

cut_idx = [301:1201];

ft_al_sub = mat_data(dat_all.force_abrupt_long_test_sub);
fd_al_sub = mat_data(dat_all.force_abrupt_long_wash_sub);

ft_al_avg = dat_all.force_abrupt_long_test_all(cut_idx,:);
fd_al_avg = dat_all.force_abrupt_long_wash_all(cut_idx,:);

vt_al_avg = dat_all.velocity_abrupt_long_test_all(cut_idx,:);
vd_al_avg = dat_all.velocity_abrupt_long_test_all(cut_idx,:);

tt = [0:size(vt_al_avg,1)-1]*(1/1000);

%%%% GL
ft_gl_sub = mat_data(dat_all.force_gradual_test_sub);
fd_gl_sub = mat_data(dat_all.force_gradual_wash_sub);

ft_gl_avg = dat_all.force_gradual_test_all(cut_idx,:);
fd_gl_avg = dat_all.force_gradual_wash_all(cut_idx,:);

vt_gl_avg = dat_all.velocity_gradual_test_all(cut_idx,:);
vd_gl_avg = dat_all.velocity_gradual_test_all(cut_idx,:);

%%%% AS
ft_as_sub = mat_data(dat_all.force_abrupt_short_test_sub);
fd_as_sub = mat_data(dat_all.force_abrupt_short_wash_sub);

ft_as_avg = dat_all.force_abrupt_short_test_all(cut_idx,:);
fd_as_avg = dat_all.force_abrupt_short_wash_all(cut_idx,:);

vt_as_avg = dat_all.velocity_abrupt_short_test_all(cut_idx,:);
vd_as_avg = dat_all.velocity_abrupt_short_test_all(cut_idx,:);


% standard_error_shading_11_07_14(-ave_position_fit_posexp_AS_sub_base(end-3:end,1),sd_position_fit_posexp_AS_sub_base,...
%     posexp_AS_EC_base_NDX(end-3:end),posexp_AS_num_of_subjects,posexp_AS_adaptation_shade);

%%
early_test_idx = [1:2]; 
%late_test_idx = [size(ft_al_sub,2)-1:size(ft_al_sub,2)];
late_test_idx = [10:12];

%AS
early_test_idx_as = [1];
late_test_idx_as = [size(ft_as_sub,1)];

early_decay_idx = [1:10];
late_decay_idx = [20:30];

%% get std

%AS
ft_as_se_early = squeeze(nanstd(ft_as_sub(early_test_idx_as,:,:),0,2));
ft_as_se_late = squeeze(nanstd(ft_as_sub(late_test_idx_as,:,:),0,2));

fd_as_se_early = nanmean(squeeze(nanstd(fd_as_sub(early_decay_idx,:,:),0,2)),1);
fd_as_se_late = nanmean(squeeze(nanstd(fd_as_sub(late_decay_idx,:,:),0,2)),1);

%AL
ft_al_se_early = nanmean(squeeze(nanstd(ft_al_sub(early_test_idx,:,:),0,2)),1);
ft_al_se_late = squeeze(nanstd(ft_al_sub([11],:,:),0,2));

fd_al_se_early = nanmean(squeeze(nanstd(fd_al_sub(early_decay_idx,:,:),0,2)),1);
fd_al_se_late = nanmean(squeeze(nanstd(fd_al_sub(late_decay_idx,:,:),0,2)),1);

%GL
ft_gl_se_early = nanmean(squeeze(nanstd(ft_gl_sub(early_test_idx,:,:),0,2)),1);
ft_gl_se_late = squeeze(nanstd(ft_gl_sub([11],:,:),0,2));

fd_gl_se_early = nanmean(squeeze(nanstd(fd_gl_sub(early_decay_idx,:,:),0,2)),1);
fd_gl_se_late = nanmean(squeeze(nanstd(fd_gl_sub(late_decay_idx,:,:),0,2)),1);


%% AL
%%%%%% plot all test data on the same figure %%%%%%

clr = 'r';

figure; hold on;
plot(tt, nanmean(vt_al_avg,2)*15, 'color', clr, 'linewidth', 1, 'displayname', 'Ideal'); %ideal
plot(tt, nanmean(ft_al_avg(:,early_test_idx),2), 'color', clr, 'Linestyle', '--', 'linewidth', 1.5, 'displayname', 'Early');
plot(tt, nanmean(ft_al_avg(:,late_test_idx),2), 'color', clr, 'linewidth', 1.5, 'displayname', 'Late');

standard_error_shading_11_07_14(-nanmean(ft_al_avg(:,early_test_idx),2),ft_al_se_early,tt,8,clr);
standard_error_shading_11_07_14(-nanmean(ft_al_avg(:,late_test_idx),2),ft_al_se_late,tt,8,clr);

%GL
clr = 'g';

plot(tt, nanmean(vt_gl_avg,2)*15, 'color', clr, 'linewidth', 1, 'displayname', 'Ideal'); %ideal
plot(tt, nanmean(ft_gl_avg(:,early_test_idx),2), 'color', clr, 'Linestyle', '--', 'linewidth', 1.5, 'displayname', 'Early');
plot(tt, nanmean(ft_gl_avg(:,late_test_idx),2), 'color', clr, 'linewidth', 1.5, 'displayname', 'Late');

%show standard error
standard_error_shading_11_07_14(-nanmean(ft_gl_avg(:,early_test_idx),2),ft_gl_se_early,tt,8,clr);
standard_error_shading_11_07_14(-nanmean(ft_gl_avg(:,late_test_idx),2),ft_gl_se_late,tt,8,clr);

clr = 'b';

plot(tt, nanmean(vt_as_avg,2)*15, 'color', clr, 'linewidth', 1, 'displayname', 'Ideal'); %ideal
plot(tt, nanmean(ft_as_avg(:,early_test_idx_as),2), 'color', clr, 'Linestyle', '--', 'linewidth', 1.5, 'displayname', 'Early');
plot(tt, nanmean(ft_as_avg(:,late_test_idx_as),2), 'color', clr, 'linewidth', 1.5, 'displayname', 'Late');

standard_error_shading_11_07_14(-nanmean(ft_as_avg(:,early_test_idx_as),2),ft_as_se_early,tt,8,clr);
standard_error_shading_11_07_14(-nanmean(ft_as_avg(:,late_test_idx_as),2),ft_as_se_late,tt,8,clr);

xlabel('Time (sec)');
ylabel('Force (N)');

leg = legend('Show');
set(leg, 'Location', 'Northwest');

title('Test period');
ylim([-1,5]);

set(gcf,'Renderer', 'Painters');

savefig('force_vFF_test_comb_correct.fig');

keyboard;

%% decay 
figure; hold on;

%GL
clr = 'g';

plot(tt, nanmean(vd_gl_avg,2)*15, 'color', clr, 'linewidth', 1, 'displayname', 'Ideal'); %ideal
plot(tt, nanmean(fd_gl_avg(:,early_decay_idx),2), 'color', clr, 'Linestyle', '--', 'linewidth', 1.5, 'displayname', 'Early');
plot(tt, nanmean(fd_gl_avg(:,late_decay_idx),2), 'color', clr, 'linewidth', 1.5, 'displayname', 'Late');

standard_error_shading_11_07_14(-nanmean(fd_gl_avg(:,early_decay_idx),2),fd_gl_se_early,tt,8,clr);
standard_error_shading_11_07_14(-nanmean(fd_gl_avg(:,late_decay_idx),2),fd_gl_se_late,tt,8,clr);

%AL
clr = 'r';
plot(tt, nanmean(vd_al_avg,2)*15, 'color', clr, 'linewidth', 1, 'displayname', 'Ideal'); %ideal
plot(tt, nanmean(fd_al_avg(:,early_decay_idx),2), 'color', clr, 'Linestyle', '--', 'linewidth', 1.5, 'displayname', 'Early');
plot(tt, nanmean(fd_al_avg(:,late_decay_idx),2), 'color', clr, 'linewidth', 1.5, 'displayname', 'Late');

standard_error_shading_11_07_14(-nanmean(fd_al_avg(:,early_decay_idx),2),fd_al_se_early,tt,8,clr);
standard_error_shading_11_07_14(-nanmean(fd_al_avg(:,late_decay_idx),2),fd_al_se_late,tt,8,clr);

%%%%%% AS %%%%%%
clr = 'b';
plot(tt, nanmean(vd_as_avg,2)*15, 'color', clr, 'linewidth', 1, 'displayname', 'Ideal'); %ideal
plot(tt, nanmean(fd_as_avg(:,early_decay_idx),2), 'color', clr, 'Linestyle', '--', 'linewidth', 1.5, 'displayname', 'Early');
plot(tt, nanmean(fd_as_avg(:,late_decay_idx),2), 'color', clr, 'linewidth', 1.5, 'displayname', 'Late');

standard_error_shading_11_07_14(-nanmean(fd_as_avg(:,early_decay_idx),2),fd_as_se_early,tt,8,clr);
standard_error_shading_11_07_14(-nanmean(fd_as_avg(:,late_decay_idx),2),fd_as_se_late,tt,8,clr);

xlabel('Time (sec)');
ylabel('Force (N)');

leg = legend('Show');
set(leg, 'Location', 'Northwest');

title('Decay period');
ylim([-1,5]);

set(gcf,'Renderer', 'Painters');



