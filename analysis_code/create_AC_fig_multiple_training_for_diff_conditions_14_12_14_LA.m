function [v_AL,V_GL]=create_AC_fig_multiple_training_for_diff_conditions_14_12_14_LA_V1(fig_num,AS_subs,AL_subs,Grad_subs)

% fig_num=2;
% Grad_subs=sub_w_grad;
% AL_subs=sub_w_abrupt_short;
% AS_subs=sub_w_abrupt_long;
% color specifications
% position
abrupt_short_adapt_color=[0,0,256]/256;
abrupt_long_adapt_color=[256,0,0]/256;
gradual_adapt_color=[0,256,0]/256;

abrupt_short_adapt_shade=[120,120,256]/256;
abrupt_long_adapt_shade=[256,120,120]/256;
gradual_adapt_shade=[120,256,120]/256;

early_wash_shade=[230,230,230]/256;
mid_wash_shade=[210,210,210]/256;
late_wash_shade=[190,190,190]/256;

washout_color_abrupt_short=[0,0,256]/256;
washout_color_abrupt_long=[256,0,0]/256;
washout_color_gradual=[0,256,0]/256;
adaptation_color=[256,256,256]/256;
Field_ref_shade=[175,175,175]/256;
%
y=-0.2:.2:1.01;
early_wash_st=5;
mid_wash_st=15;
window_length=5;
curve_width=1.5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% locate data
cdr=cd;
if ispc
    MT_filename=ls('multiple_training_*');
    MT_data=load(strcat(cdr,'\',MT_filename));
    MT_dat_all=MT_data.dat_all;
    MT_info_all=MT_data.info_all;

elseif ~ispc
    %create posexp data
    MT_filename=ls('multiple_training_*');
    MT_data=load(strcat(cdr,'/',MT_filename));
    MT_dat_all=MT_data.dat_all;
    MT_info_all=MT_data.info_all;

end
%
FF_K=MT_info_all.FF_K;
FF_B=MT_info_all.FF_B;
MT_num_of_subjects=length(AS_subs);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculate single fit for each experiment 
%% abrupt short
%subject
[velocity_fit_abrupt_short_sub_base,ave_velocity_fit_abrupt_short_sub_base,sd_velocity_fit_abrupt_short_sub_base]=calculate_single_fit_for_subjects_14_12_14(...
            MT_dat_all.force_abrupt_short_base_sub,MT_dat_all.velocity_abrupt_short_base_sub,FF_B,MT_info_all,'offset_off','dont_add_initial_zero',AS_subs);
[velocity_fit_abrupt_short_sub_test,ave_velocity_fit_abrupt_short_sub_test,sd_velocity_fit_abrupt_short_sub_test]=calculate_single_fit_for_subjects_14_12_14(...
            MT_dat_all.force_abrupt_short_test_sub,MT_dat_all.velocity_abrupt_short_test_sub,FF_B,MT_info_all,'offset_off','dont_add_initial_zero',AS_subs);
[velocity_fit_abrupt_short_sub_wash,ave_velocity_fit_abrupt_short_sub_wash,sd_velocity_fit_abrupt_short_sub_wash]=calculate_single_fit_for_subjects_14_12_14(...
            MT_dat_all.force_abrupt_short_wash_sub,MT_dat_all.velocity_abrupt_short_wash_sub,FF_B,MT_info_all,'offset_off','dont_add_initial_zero',AS_subs);
 
%normalized subject        
velocity_fit_abrupt_short_sub_wash_norm=calculate_normalized_decay_for_subjects_23_07_14(velocity_fit_abrupt_short_sub_wash,ave_velocity_fit_abrupt_short_sub_wash(1,:));
[ave_velocity_fit_abrupt_short_sub_wash_norm,sd_velocity_fit_abrupt_short_sub_wash_norm,~,~]=extract_relevant_and_irrelevant_components_subjects_12_07_14(velocity_fit_abrupt_short_sub_wash_norm,[1,1]);
%index for each case 
abrupt_short_EC_base_NDX=[MT_info_all.abrupt_short_base_EC_NDX]-(MT_info_all.abrupt_short_base_EC_NDX(end));
abrupt_short_EC_test_NDX=[MT_info_all.abrupt_short_test_EC_NDX];
abrupt_short_EC_wash_NDX=(MT_info_all.abrupt_short_wash_EC_NDX+1)+MT_info_all.abrupt_short_test_EC_NDX(end);
dummy=[0];
%
[ave_velocity_fit_abrupt_short_sub_test,abrupt_short_EC_test_NDX]=attach_end_of_adaptation_coeffients(ave_velocity_fit_abrupt_short_sub_base,abrupt_short_EC_base_NDX,ave_velocity_fit_abrupt_short_sub_test,abrupt_short_EC_test_NDX);
[ave_velocity_fit_abrupt_short_sub_wash,abrupt_short_EC_wash_NDX]=attach_end_of_adaptation_coeffients(ave_velocity_fit_abrupt_short_sub_test,abrupt_short_EC_test_NDX,ave_velocity_fit_abrupt_short_sub_wash,abrupt_short_EC_wash_NDX);
[~,sd_velocity_fit_abrupt_short_sub_test]=attach_end_of_adaptation_coeffients(dummy,sd_velocity_fit_abrupt_short_sub_base,dummy,sd_velocity_fit_abrupt_short_sub_test);
[~,sd_velocity_fit_abrupt_short_sub_wash]=attach_end_of_adaptation_coeffients(dummy,sd_velocity_fit_abrupt_short_sub_test,dummy,sd_velocity_fit_abrupt_short_sub_wash);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% abrupt long 
%subject
[velocity_fit_abrupt_long_sub_base,ave_velocity_fit_abrupt_long_sub_base,sd_velocity_fit_abrupt_long_sub_base]=calculate_single_fit_for_subjects_14_12_14(...
            MT_dat_all.force_abrupt_long_base_sub,MT_dat_all.velocity_abrupt_long_base_sub,FF_B,MT_info_all,'offset_off','dont_add_initial_zero',AL_subs);
[velocity_fit_abrupt_long_sub_test,ave_velocity_fit_abrupt_long_sub_test,sd_velocity_fit_abrupt_long_sub_test]=calculate_single_fit_for_subjects_14_12_14(...
            MT_dat_all.force_abrupt_long_test_sub,MT_dat_all.velocity_abrupt_long_test_sub,FF_B,MT_info_all,'offset_off','dont_add_initial_zero',AL_subs);
[velocity_fit_abrupt_long_sub_wash,ave_velocity_fit_abrupt_long_sub_wash,sd_velocity_fit_abrupt_long_sub_wash]=calculate_single_fit_for_subjects_14_12_14(...
            MT_dat_all.force_abrupt_long_wash_sub,MT_dat_all.velocity_abrupt_long_wash_sub,FF_B,MT_info_all,'offset_off','dont_add_initial_zero',AL_subs);
 
%normalized subject        
velocity_fit_abrupt_long_sub_wash_norm=calculate_normalized_decay_for_subjects_23_07_14(velocity_fit_abrupt_long_sub_wash,ave_velocity_fit_abrupt_long_sub_wash(1,:));
[ave_velocity_fit_abrupt_long_sub_wash_norm,sd_velocity_fit_abrupt_long_sub_wash_norm,~,~]=extract_relevant_and_irrelevant_components_subjects_12_07_14(velocity_fit_abrupt_long_sub_wash_norm,[1,1]);
%index for each case 
abrupt_long_EC_base_NDX=[MT_info_all.abrupt_long_base_EC_NDX]-(MT_info_all.abrupt_long_base_EC_NDX(end));
abrupt_long_EC_test_NDX=[MT_info_all.abrupt_long_test_EC_NDX];
abrupt_long_EC_wash_NDX=(MT_info_all.abrupt_long_wash_EC_NDX+1)+MT_info_all.abrupt_long_test_EC_NDX(end);
dummy=[0];
%
[ave_velocity_fit_abrupt_long_sub_test,abrupt_long_EC_test_NDX]=attach_end_of_adaptation_coeffients(ave_velocity_fit_abrupt_long_sub_base,abrupt_long_EC_base_NDX,ave_velocity_fit_abrupt_long_sub_test,abrupt_long_EC_test_NDX);
[ave_velocity_fit_abrupt_long_sub_wash,abrupt_long_EC_wash_NDX]=attach_end_of_adaptation_coeffients(ave_velocity_fit_abrupt_long_sub_test,abrupt_long_EC_test_NDX,ave_velocity_fit_abrupt_long_sub_wash,abrupt_long_EC_wash_NDX);
[~,sd_velocity_fit_abrupt_long_sub_test]=attach_end_of_adaptation_coeffients(dummy,sd_velocity_fit_abrupt_long_sub_base,dummy,sd_velocity_fit_abrupt_long_sub_test);
[~,sd_velocity_fit_abrupt_long_sub_wash]=attach_end_of_adaptation_coeffients(dummy,sd_velocity_fit_abrupt_long_sub_test,dummy,sd_velocity_fit_abrupt_long_sub_wash);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% gradual
%subject
[velocity_fit_gradual_sub_base,ave_velocity_fit_gradual_sub_base,sd_velocity_fit_gradual_sub_base]=calculate_single_fit_for_subjects_14_12_14(...
            MT_dat_all.force_gradual_base_sub,MT_dat_all.velocity_gradual_base_sub,FF_B,MT_info_all,'offset_off','dont_add_initial_zero',Grad_subs);
[velocity_fit_gradual_sub_test,ave_velocity_fit_gradual_sub_test,sd_velocity_fit_gradual_sub_test]=calculate_single_fit_for_subjects_14_12_14(...
            MT_dat_all.force_gradual_test_sub,MT_dat_all.velocity_gradual_test_sub,FF_B,MT_info_all,'offset_off','dont_add_initial_zero',Grad_subs);
[velocity_fit_gradual_sub_wash,ave_velocity_fit_gradual_sub_wash,sd_velocity_fit_gradual_sub_wash]=calculate_single_fit_for_subjects_14_12_14(...
            MT_dat_all.force_gradual_wash_sub,MT_dat_all.velocity_gradual_wash_sub,FF_B,MT_info_all,'offset_off','dont_add_initial_zero',Grad_subs);
 
%normalized subject        
velocity_fit_gradual_sub_wash_norm=calculate_normalized_decay_for_subjects_23_07_14(velocity_fit_gradual_sub_wash,ave_velocity_fit_gradual_sub_wash(1,:));
[ave_velocity_fit_gradual_sub_wash_norm,sd_velocity_fit_gradual_sub_wash_norm,~,~]=extract_relevant_and_irrelevant_components_subjects_12_07_14(velocity_fit_gradual_sub_wash_norm,[1,1]);
%index for each case 
gradual_EC_base_NDX=[MT_info_all.gradual_base_EC_NDX]-(MT_info_all.gradual_base_EC_NDX(end));
gradual_EC_test_NDX=[MT_info_all.gradual_test_EC_NDX];
gradual_EC_wash_NDX=(MT_info_all.gradual_wash_EC_NDX+1)+MT_info_all.gradual_test_EC_NDX(end);
dummy=[0];
%
[ave_velocity_fit_gradual_sub_test,gradual_EC_test_NDX]=attach_end_of_adaptation_coeffients(ave_velocity_fit_gradual_sub_base,gradual_EC_base_NDX,ave_velocity_fit_gradual_sub_test,gradual_EC_test_NDX);
[ave_velocity_fit_gradual_sub_wash,gradual_EC_wash_NDX]=attach_end_of_adaptation_coeffients(ave_velocity_fit_gradual_sub_test,gradual_EC_test_NDX,ave_velocity_fit_gradual_sub_wash,gradual_EC_wash_NDX);
[~,sd_velocity_fit_gradual_sub_test]=attach_end_of_adaptation_coeffients(dummy,sd_velocity_fit_gradual_sub_base,dummy,sd_velocity_fit_gradual_sub_test);
[~,sd_velocity_fit_gradual_sub_wash]=attach_end_of_adaptation_coeffients(dummy,sd_velocity_fit_gradual_sub_test,dummy,sd_velocity_fit_gradual_sub_wash);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% find stat 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% find stat for all people 
 % find position/velocity rise in early adaptation 
 
 %issue here
[~,~,~,~,abrupt_short_adapt_data]=create_subject_matrix_for_single_fit_subject_30_7_14(velocity_fit_abrupt_short_sub_test,1,1,1,length(AS_subs));
[~,~,~,~,abrupt_long_adapt_data]=create_subject_matrix_for_single_fit_subject_30_7_14(velocity_fit_abrupt_long_sub_test,1,1,1,length(AL_subs));
[~,~,~,~,gradual_adapt_data]=create_subject_matrix_for_single_fit_subject_30_7_14(velocity_fit_gradual_sub_test,1,1,1,length(Grad_subs));

[abrupt_short_wash_data_all]=create_subject_matrix_for_bar_plot_31_7_14(velocity_fit_abrupt_short_sub_wash,window_length,window_length,early_wash_st,mid_wash_st,length(AS_subs),[1,1]);
[abrupt_long_wash_data_all]=create_subject_matrix_for_bar_plot_31_7_14(velocity_fit_abrupt_long_sub_wash,window_length,window_length,early_wash_st,mid_wash_st,length(AL_subs),[1,1]);
[gradual_wash_data_all]=create_subject_matrix_for_bar_plot_31_7_14(velocity_fit_gradual_sub_wash,window_length,window_length,early_wash_st,mid_wash_st,length(Grad_subs),[1,1]);
%
fit_data_early_wash_all={abrupt_short_wash_data_all{1,1},abrupt_long_wash_data_all{1,1},gradual_wash_data_all{1,1}};
fit_data_mid_wash_all={abrupt_short_wash_data_all{2,1},abrupt_long_wash_data_all{2,1},gradual_wash_data_all{2,1}};
fit_data_late_wash_all={abrupt_short_wash_data_all{3,1},abrupt_long_wash_data_all{3,1},gradual_wash_data_all{3,1}};
%
fit_data_early_wash_ave_all=cellfun(@nanmean,fit_data_early_wash_all);
fit_data_mid_wash_ave_all=cellfun(@nanmean,fit_data_mid_wash_all);
fit_data_late_wash_ave_all=cellfun(@nanmean,fit_data_late_wash_all);
%
fit_data_early_wash_se_all=cellfun(@nanstd,fit_data_early_wash_all).*[length(AS_subs)*ones(1,3)].^-.5;
fit_data_mid_wash_se_all=cellfun(@nanstd,fit_data_mid_wash_all).*[length(AL_subs)*ones(1,3)].^-.5;
fit_data_late_wash_se_all=cellfun(@nanstd,fit_data_late_wash_all).*[length(Grad_subs)*ones(1,3)].^-.5;
%
[h_matrix_fit_early_wash_all,p_matrix_fit_early_wash_all]=calculate_t_test_for_subject_data_13_07_14(fit_data_early_wash_all);
[h_matrix_fit_mid_wash_all,p_matrix_fit_mid_wash_all]=calculate_t_test_for_subject_data_13_07_14(fit_data_mid_wash_all);
[h_matrix_fit_late_wash_all,p_matrix_fit_late_wash_all]=calculate_t_test_for_subject_data_13_07_14(fit_data_late_wash_all);

%% calculate the state for normalized data 

% 
[abrupt_short_wash_data_all_norm]=create_subject_matrix_for_bar_plot_31_7_14(velocity_fit_abrupt_short_sub_wash_norm,window_length,window_length,early_wash_st,mid_wash_st,MT_num_of_subjects,[1,1]);
[abrupt_long_wash_data_all_norm]=create_subject_matrix_for_bar_plot_31_7_14(velocity_fit_abrupt_long_sub_wash_norm,window_length,window_length,early_wash_st,mid_wash_st,MT_num_of_subjects,[1,1]);
[gradual_wash_data_all_norm]=create_subject_matrix_for_bar_plot_31_7_14(velocity_fit_gradual_sub_wash_norm,window_length,window_length,early_wash_st,mid_wash_st,MT_num_of_subjects,[1,1]);
%
fit_data_early_wash_all_norm={abrupt_short_wash_data_all_norm{1,1},abrupt_long_wash_data_all_norm{1,1},gradual_wash_data_all_norm{1,1}};
fit_data_mid_wash_all_norm={abrupt_short_wash_data_all_norm{2,1},abrupt_long_wash_data_all_norm{2,1},gradual_wash_data_all_norm{2,1}};
fit_data_late_wash_all_norm={abrupt_short_wash_data_all_norm{3,1},abrupt_long_wash_data_all_norm{3,1},gradual_wash_data_all_norm{3,1}};
%
fit_data_early_wash_ave_all_norm=cellfun(@nanmean,fit_data_early_wash_all_norm);
fit_data_mid_wash_ave_all_norm=cellfun(@nanmean,fit_data_mid_wash_all_norm);
fit_data_late_wash_ave_all_norm=cellfun(@nanmean,fit_data_late_wash_all_norm);
%
fit_data_early_wash_se_all_norm=cellfun(@nanstd,fit_data_early_wash_all_norm).*[MT_num_of_subjects*ones(1,3)].^-.5;
fit_data_mid_wash_se_all_norm=cellfun(@nanstd,fit_data_mid_wash_all_norm).*[MT_num_of_subjects*ones(1,3)].^-.5;
fit_data_late_wash_se_all_norm=cellfun(@nanstd,fit_data_late_wash_all_norm).*[MT_num_of_subjects*ones(1,3)].^-.5;
%
[h_matrix_fit_early_wash_all_norm,p_matrix_fit_early_wash_all_norm]=calculate_t_test_for_subject_data_13_07_14(fit_data_early_wash_all_norm);
[h_matrix_fit_mid_wash_all_norm,p_matrix_fit_mid_wash_all_norm]=calculate_t_test_for_subject_data_13_07_14(fit_data_mid_wash_all_norm);
[h_matrix_fit_late_wash_all_norm,p_matrix_fit_late_wash_all_norm]=calculate_t_test_for_subject_data_13_07_14(fit_data_late_wash_all_norm);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Perform n-way ANOVA on data from gradual and abrupt long 
experiment_conditions=cellstr([char(ones(MT_num_of_subjects*window_length*3,1)*'AL');char(ones(MT_num_of_subjects*window_length*3,1)*'GR')]);
trial_conditions=cellstr(repmat([char(ones(MT_num_of_subjects*window_length,1)*'erl');char(ones(MT_num_of_subjects*window_length,1)*'mid');char(ones(MT_num_of_subjects*window_length,1)*'lat')],2,1));
Observations=[[abrupt_long_wash_data_all_norm{:,1}],[gradual_wash_data_all_norm{:,1}]]';
p=anovan(Observations,{experiment_conditions,trial_conditions},'model','full','varnames',{'traing type';'decay epoch'});
v_AL=abrupt_long_wash_data_all_norm;
V_GL=gradual_wash_data_all_norm;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot adaptation and decay for different cases 
h1=figure(fig_num);
set(0,'ShowhiddenHandles','on')
set(h1, 'PaperOrientation', 'portrait');
%
subplot('position',[.1,.65,.25,.2])
x_ref=[abrupt_long_EC_base_NDX(end-3),abrupt_long_EC_base_NDX(end),abrupt_long_EC_test_NDX(1),abrupt_long_EC_test_NDX(end)]';
y_ref=[0,0,1,1]';
Display_single_adaptation_11_07_14(y_ref,x_ref,Field_ref_shade,'force field',2,'-');
% baseline
Display_single_adaptation_11_07_14(ave_velocity_fit_abrupt_short_sub_base(end-3:end,1),abrupt_short_EC_base_NDX(end-3:end),abrupt_short_adapt_color,'off',curve_width,'-');
Display_single_adaptation_11_07_14(ave_velocity_fit_abrupt_long_sub_base(end-3:end,1),abrupt_long_EC_base_NDX(end-3:end),abrupt_long_adapt_color,'off',curve_width,'-');
Display_single_adaptation_11_07_14(ave_velocity_fit_gradual_sub_base(end-3:end,1),gradual_EC_base_NDX(end-3:end),gradual_adapt_color,'off',curve_width,'-');
% test
Display_single_adaptation_11_07_14(ave_velocity_fit_abrupt_short_sub_test,abrupt_short_EC_test_NDX,abrupt_short_adapt_color,'abrupt short',curve_width,'-');
Display_single_adaptation_11_07_14(ave_velocity_fit_abrupt_long_sub_test,abrupt_long_EC_test_NDX,abrupt_long_adapt_color,'abrupt long',curve_width,'-');
Display_single_adaptation_11_07_14(ave_velocity_fit_gradual_sub_test,gradual_EC_test_NDX,gradual_adapt_color,'gradual',curve_width,'-');
% wash
Display_single_adaptation_11_07_14(ave_velocity_fit_abrupt_short_sub_wash,abrupt_long_EC_wash_NDX,abrupt_short_adapt_color,'off',curve_width,'-');
Display_single_adaptation_11_07_14(ave_velocity_fit_abrupt_long_sub_wash,abrupt_long_EC_wash_NDX,abrupt_long_adapt_color,'off',curve_width,'-');
Display_single_adaptation_11_07_14(ave_velocity_fit_gradual_sub_wash,gradual_EC_wash_NDX,gradual_adapt_color,'off',curve_width,'-');
% add SE shades 
% baseline
standard_error_shading_11_07_14(-ave_velocity_fit_abrupt_short_sub_base(end-3:end,1),sd_velocity_fit_abrupt_short_sub_base(end-3:end,1),abrupt_short_EC_base_NDX(end-3:end),MT_num_of_subjects,abrupt_short_adapt_shade);
standard_error_shading_11_07_14(-ave_velocity_fit_abrupt_long_sub_base(end-3:end,1),sd_velocity_fit_abrupt_long_sub_base(end-3:end,1),abrupt_long_EC_base_NDX(end-3:end),MT_num_of_subjects,abrupt_long_adapt_shade);
standard_error_shading_11_07_14(-ave_velocity_fit_gradual_sub_base(end-3:end,1),sd_velocity_fit_gradual_sub_base(end-3:end,1),gradual_EC_base_NDX(end-3:end),MT_num_of_subjects,gradual_adapt_shade);

% test
standard_error_shading_11_07_14(-ave_velocity_fit_abrupt_short_sub_test,sd_velocity_fit_abrupt_short_sub_test,abrupt_short_EC_test_NDX,MT_num_of_subjects,abrupt_short_adapt_shade);
standard_error_shading_11_07_14(-ave_velocity_fit_abrupt_long_sub_test,sd_velocity_fit_abrupt_long_sub_test,abrupt_long_EC_test_NDX,MT_num_of_subjects,abrupt_long_adapt_shade);
standard_error_shading_11_07_14(-ave_velocity_fit_gradual_sub_test,sd_velocity_fit_gradual_sub_test,gradual_EC_test_NDX,MT_num_of_subjects,gradual_adapt_shade);
% wash
standard_error_shading_11_07_14(-ave_velocity_fit_abrupt_short_sub_wash,sd_velocity_fit_abrupt_short_sub_wash,abrupt_long_EC_wash_NDX,MT_num_of_subjects,abrupt_short_adapt_shade);
standard_error_shading_11_07_14(-ave_velocity_fit_abrupt_long_sub_wash,sd_velocity_fit_abrupt_long_sub_wash,abrupt_long_EC_wash_NDX,MT_num_of_subjects,abrupt_long_adapt_shade);
standard_error_shading_11_07_14(-ave_velocity_fit_gradual_sub_wash,sd_velocity_fit_gradual_sub_wash,gradual_EC_wash_NDX,MT_num_of_subjects,gradual_adapt_shade);
% 
o1=plot([-50,220],[0,0],'k--','lineWidth',.5);
hg=get(o1,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(o1,'bottom');
%
o1=plot([abrupt_short_EC_test_NDX(end),abrupt_long_EC_wash_NDX(1)],[ave_velocity_fit_abrupt_short_sub_test(end),ave_velocity_fit_abrupt_short_sub_wash(1)],'b--','lineWidth',1);
hg=get(o1,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(o1,'bottom');
%
o1=plot([abrupt_long_EC_wash_NDX(1),abrupt_long_EC_wash_NDX(1)],[-0.2,1.01],'k--','lineWidth',.5);
hg=get(o1,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(o1,'bottom');
%
set(gca,'fontsize',8,'ytick',y,'yticklabel',sprintf('%1.1f|',y),'xtick',-50:50:220,'xlim',[-50,220],'ylim',[-0.2,1.01],'layer','top');
ylabel('Adaptation Coefficient','FontSize',8,'FontWeight','normal','Color','k');
xlabel('Trial Number','FontSize',8,'FontWeight','normal','Color','k');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% display unlearing amplitude for early late
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
subplot('position',[.6,.65,.25,.2])
abrupt_short_wash_EC_NDX_corrected=MT_info_all.abrupt_short_wash_EC_NDX+1;
abrupt_long_wash_EC_NDX_corrected=MT_info_all.abrupt_long_wash_EC_NDX+1;
gradual_wash_EC_NDX_corrected=MT_info_all.gradual_wash_EC_NDX+1;
%
Display_single_adaptation_normalize_11_7_14(ave_velocity_fit_abrupt_short_sub_wash_norm,1,abrupt_short_wash_EC_NDX_corrected,abrupt_short_adapt_color,'off',curve_width,'-');
Display_single_adaptation_normalize_11_7_14(ave_velocity_fit_abrupt_long_sub_wash_norm,1,abrupt_long_wash_EC_NDX_corrected,abrupt_long_adapt_color,'off',curve_width,'-');
Display_single_adaptation_normalize_11_7_14(ave_velocity_fit_gradual_sub_wash_norm,1,gradual_wash_EC_NDX_corrected,gradual_adapt_color,'off',curve_width,'-');
% display_fit_data 

standard_error_shading_11_07_14(-ave_velocity_fit_abrupt_short_sub_wash_norm,sd_velocity_fit_abrupt_short_sub_wash_norm,abrupt_short_wash_EC_NDX_corrected,MT_num_of_subjects,abrupt_short_adapt_shade);
standard_error_shading_11_07_14(-ave_velocity_fit_abrupt_long_sub_wash_norm,sd_velocity_fit_abrupt_long_sub_wash_norm,abrupt_long_wash_EC_NDX_corrected,MT_num_of_subjects,abrupt_long_adapt_shade);
standard_error_shading_11_07_14(-ave_velocity_fit_gradual_sub_wash_norm,sd_velocity_fit_gradual_sub_wash_norm,gradual_wash_EC_NDX_corrected,MT_num_of_subjects,gradual_adapt_shade);
%
o1=plot([0,61],[0,0],'k--','lineWidth',.5);
hg=get(o1,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');
%
h4=area([abrupt_long_wash_EC_NDX_corrected(early_wash_st),abrupt_long_wash_EC_NDX_corrected(early_wash_st+window_length)],[1.2,1.2],'linestyle','none','facecolor',early_wash_shade,'basevalue',-.2);
hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');
%
h4=area([abrupt_long_wash_EC_NDX_corrected(mid_wash_st),abrupt_long_wash_EC_NDX_corrected(mid_wash_st+window_length)],[1.2,1.2],'linestyle','none','facecolor',mid_wash_shade,'basevalue',-.2);
hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');

%
h4=area([abrupt_long_wash_EC_NDX_corrected(end-window_length),abrupt_long_wash_EC_NDX_corrected(end)],[1.2,1.2],'linestyle','none','facecolor',late_wash_shade,'basevalue',-.2);
hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');
%
text(gradual_wash_EC_NDX_corrected(early_wash_st+floor(window_length/2)),-0.05,'E','VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
text(gradual_wash_EC_NDX_corrected(mid_wash_st+floor(window_length/2)),-0.05,'M','VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
text(gradual_wash_EC_NDX_corrected(end-floor(window_length/2)),-0.05,'L','VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
%
set(gca,'FontSize',8,'xtick',[0,10:10:60],'ytick',y,'yticklabel',sprintf('%1.1f|',y),'xlim',[0,61],'ylim',[-0.2,1.01],'layer','top');
xlabel('Trial Number (Unlearing Period)','FontSize',8,'FontWeight','normal','Color','k');
ylabel('Normalized Adaptation Coefficient','FontSize',8,'FontWeight','normal','Color','k');
leg=legend('show','location','northeast');set(leg,'FontSize',8)
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot('position',[.86,.65,.12,.2])
fit_early_adapt_mid_wash_norm_ave=[fit_data_early_wash_ave_all_norm',fit_data_mid_wash_ave_all_norm'];
fit_early_adapt_mid_wash_norm_se=[fit_data_early_wash_se_all_norm',fit_data_mid_wash_se_all_norm'];
x=[.25 .75;.25 .75;.25 .75];
Training_sequence={'abrupt short','abrupt long','gradual'};
Training_color_seq=[abrupt_short_adapt_color;abrupt_long_adapt_color;gradual_adapt_color];
plot_bar_with_error_27_01_15(x',fit_early_adapt_mid_wash_norm_ave',fit_early_adapt_mid_wash_norm_se',Training_sequence,Training_color_seq,h_matrix_fit_early_wash_all_norm,h_matrix_fit_mid_wash_all_norm);
%
fit_late_wash_norm_ave=[[nan,nan,nan]',fit_data_late_wash_ave_all_norm'];
fit_late_wash_norm_se=[[nan,nan,nan]',fit_data_late_wash_se_all_norm'];
x=[.75 1.25;.75 1.25;.75 1.25];
Training_sequence={'abrupt short','abrupt long','gradual'};
Training_color_seq=[abrupt_short_adapt_color;abrupt_long_adapt_color;gradual_adapt_color];
plot_bar_with_error_27_01_15(x',fit_late_wash_norm_ave',fit_late_wash_norm_se',Training_sequence,Training_color_seq,zeros(3),h_matrix_fit_late_wash_all_norm);

%
h4=area([0,.5],[1.01,1.01],'linestyle','none','facecolor',early_wash_shade,'basevalue',-.2);
hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');
%
h4=area([.5,1],[1.01,1.01],'linestyle','none','facecolor',mid_wash_shade,'basevalue',-.2);
hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');
%
h4=area([1,1.5],[1.01,1.01],'linestyle','none','facecolor',late_wash_shade,'basevalue',-.2);
hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');

text(0.25,-0.05,'E','VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
text(0.75,-0.05,'M','VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
text(1.25,-0.05,'L','VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
%
set(gca,'FontSize',8,'ytick',y,'yticklabel','','xtick',[0.25,0.75,1.25],'xticklabel','','xlim',[0,1.5],'ylim',[-0.2,1.01],'layer','top','box','off');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
annotation('textbox',[.1,.9,.38,.05],'string','A.','parent',h1,'edgecolor','none','color','k'...
    ,'horizontalalignment','left','verticalalignment','middle','fontsize',10,'fontweight','demi');
annotation('textbox',[.6,.9,.34,.05],'string','B.','parent',h1,'edgecolor','none','color','k'...
    ,'horizontalalignment','left','verticalalignment','middle','fontsize',10,'fontweight','demi');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperSize', [6.25 7.5]);
set(gcf, 'PaperPositionMode', 'manual');
% epsc printing 
set(gcf, 'PaperPosition', [.5 .5 6 7]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


end

