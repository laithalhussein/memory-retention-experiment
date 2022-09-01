function create_Gain_Space_fig_MT_for_diff_conditions_14_12_14_LA_V2(fig_num,AS_subs,AL_subs,Grad_subs)
%% color specifications
fig_num=3;
AS_subs=sub_w_abrupt_short;
AL_subs=sub_w_abrupt_long;
Grad_subs=sub_w_grad;

show_error_ellipse=true;
 
abrupt_short_adapt_color=[0,0,256]/256;
abrupt_short_misaligned_comp=[0,256,256]/256;
abrupt_long_adapt_color=[256,0,0]/256;
abrupt_long_misaligned_comp=[256,0,150]/256;
gradual_adapt_color=[0,256,0]/256;
gradual_misaligned_comp=[128,256,0]/256;

abrupt_short_wash_color=[0,0,0]/256;
abrupt_long_wash_color=[0,0,0]/256;
gradual_wash_color=[0,0,0]/256;

early_adapt_shade=[230,230,230]/255;
early_wash_shade=2.1*[100,100,100]/256;
mid_wash_shade=1.9*[100,100,100]/256;
late_wash_shade=1.7*[100,100,100]/256;


abrupt_short_wash_shade=150*[1,1,1]/256;
abrupt_long_wash_shade=150*[1,1,1]/256;
gradual_wash_shade=150*[1,1,1]/256;

abrupt_short_adapt_shade=[170,170,256]/256;
abrupt_long_adapt_shade=[256,170,170]/256;
gradual_adapt_shade=[170,256,170]/256;

early_wash_shade=[230,230,230]/256;
mid_wash_shade=[210,210,210]/256;
late_wash_shade=[190,190,190]/256;

washout_color_abrupt_short=[0,0,256]/256;
washout_color_abrupt_long=[256,0,0]/256;
washout_color_gradual=[0,256,0]/256;
adaptation_color=[256,256,256]/256;
Field_ref_shade=[175,175,175]/256;
%
%y=-0.1:.1:1.01;
y=[-0.1,0,0.2,0.4,0.6,0.8,1];
early_wash_st=5;
wash_win_len=10;
late_adapt_win_len=1;
curve_widith=1;

early_wash_st=5;
mid_wash_st=15;
window_length=5;
curve_width=1.5;

 goal_aligned_cut=.5134;
% goal_aligned_cut_first=.1898;
% goal_aligned_cut_second=.5134;
goal_aligned_cut_AS=.5057;
% goal_aligned_cut_AS_first=.2549;
% goal_aligned_cut_AS_second=.5057;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% locate data
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
% calculate PV fit for each experiment 
%% abrupt short
% subjects 
[PV_abrupt_short_base_subjects,~]=calculate_PV_fit_for_subjects_14_12_14_LA(MT_dat_all.force_abrupt_short_base_sub,MT_dat_all.velocity_abrupt_short_base_sub,MT_dat_all.position_abrupt_short_base_sub,MT_info_all,[FF_K,FF_B],'offset_off','dont_initial_zero',AS_subs);
[PV_abrupt_short_test_subjects,ave_r2_test_AS]=calculate_PV_fit_for_subjects_14_12_14_LA(MT_dat_all.force_abrupt_short_test_sub,MT_dat_all.velocity_abrupt_short_test_sub,MT_dat_all.position_abrupt_short_test_sub,MT_info_all,[FF_K,FF_B],'offset_off','dont_initial_zero',AS_subs);
[PV_abrupt_short_wash_subjects,ave_r2_wash_AS]=calculate_PV_fit_for_subjects_14_12_14_LA(MT_dat_all.force_abrupt_short_wash_sub,MT_dat_all.velocity_abrupt_short_wash_sub,MT_dat_all.position_abrupt_short_wash_sub,MT_info_all,[FF_K,FF_B],'offset_off','dont_initial_zero',AS_subs);

%
[abrupt_short_base_aligned_comp_ave,abrupt_short_base_aligned_comp_sd,abrupt_short_base_misaligned_comp_ave,abrupt_short_base_misaligned_comp_sd]=...
    extract_relevant_and_irrelevant_components_subjects_12_07_14(PV_abrupt_short_base_subjects,[2,1]);
[abrupt_short_test_aligned_comp_ave,abrupt_short_test_aligned_comp_sd,abrupt_short_test_misaligned_comp_ave,abrupt_short_test_misaligned_comp_sd]=...
    extract_relevant_and_irrelevant_components_subjects_12_07_14(PV_abrupt_short_test_subjects,[2,1]);
[abrupt_short_wash_aligned_comp_ave,abrupt_short_wash_aligned_comp_sd,abrupt_short_wash_misaligned_comp_ave,abrupt_short_wash_misaligned_comp_sd]=...
    extract_relevant_and_irrelevant_components_subjects_12_07_14(PV_abrupt_short_wash_subjects,[2,1]);


adaptation_abrupt_short_ndx=find((abrupt_short_test_aligned_comp_ave<goal_aligned_cut_AS),1,'last');
wash_abrupt_short_ndx=find(abrupt_short_wash_aligned_comp_ave<abrupt_short_test_aligned_comp_ave(adaptation_abrupt_short_ndx),1);
%%%%%%%%%%%%%%%%%%%
%% abrupt long  
% subjects 
PV_abrupt_long_base_subjects=calculate_PV_fit_for_subjects_14_12_14_LA(MT_dat_all.force_abrupt_long_base_sub,MT_dat_all.velocity_abrupt_long_base_sub,MT_dat_all.position_abrupt_long_base_sub,MT_info_all,[FF_K,FF_B],'offset_off','dont_initial_zero',AL_subs);
[PV_abrupt_long_test_subjects,ave_r2_test_AL]=calculate_PV_fit_for_subjects_14_12_14_LA(MT_dat_all.force_abrupt_long_test_sub,MT_dat_all.velocity_abrupt_long_test_sub,MT_dat_all.position_abrupt_long_test_sub,MT_info_all,[FF_K,FF_B],'offset_off','dont_initial_zero',AL_subs);
[PV_abrupt_long_wash_subjects,ave_r2_wash_AL]=calculate_PV_fit_for_subjects_14_12_14_LA(MT_dat_all.force_abrupt_long_wash_sub,MT_dat_all.velocity_abrupt_long_wash_sub,MT_dat_all.position_abrupt_long_wash_sub,MT_info_all,[FF_K,FF_B],'offset_off','dont_initial_zero',AL_subs);

%
[abrupt_long_base_aligned_comp_ave,abrupt_long_base_aligned_comp_sd,abrupt_long_base_misaligned_comp_ave,abrupt_long_base_misaligned_comp_sd]=...
    extract_relevant_and_irrelevant_components_subjects_12_07_14(PV_abrupt_long_base_subjects,[2,1]);
[abrupt_long_test_aligned_comp_ave,abrupt_long_test_aligned_comp_sd,abrupt_long_test_misaligned_comp_ave,abrupt_long_test_misaligned_comp_sd]=...
    extract_relevant_and_irrelevant_components_subjects_12_07_14(PV_abrupt_long_test_subjects,[2,1]);
[abrupt_long_wash_aligned_comp_ave,abrupt_long_wash_aligned_comp_sd,abrupt_long_wash_misaligned_comp_ave,abrupt_long_wash_misaligned_comp_sd]=...
    extract_relevant_and_irrelevant_components_subjects_12_07_14(PV_abrupt_long_wash_subjects,[2,1]);
%

if goal_aligned_cut>0.3
    adaptation_abrupt_long_ndx=find((abrupt_long_test_aligned_comp_ave<goal_aligned_cut),1,'last');
else
    adaptation_abrupt_long_ndx=find((abrupt_long_test_aligned_comp_ave>goal_aligned_cut),1,'first');
end
wash_abrupt_long_ndx=find(abrupt_long_wash_aligned_comp_ave<abrupt_long_test_aligned_comp_ave(adaptation_abrupt_long_ndx),1);

%% gradual
% subjects 
PV_gradual_base_subjects=calculate_PV_fit_for_subjects_14_12_14_LA(MT_dat_all.force_gradual_base_sub,MT_dat_all.velocity_gradual_base_sub,MT_dat_all.position_gradual_base_sub,MT_info_all,[FF_K,FF_B],'offset_off','dont_initial_zero',Grad_subs);
[PV_gradual_test_subjects,ave_r2_test_GL]=calculate_PV_fit_for_subjects_14_12_14_LA(MT_dat_all.force_gradual_test_sub,MT_dat_all.velocity_gradual_test_sub,MT_dat_all.position_gradual_test_sub,MT_info_all,[FF_K,FF_B],'offset_off','dont_initial_zero',Grad_subs);
[PV_gradual_wash_subjects,ave_r2_wash_GL]=calculate_PV_fit_for_subjects_14_12_14_LA(MT_dat_all.force_gradual_wash_sub,MT_dat_all.velocity_gradual_wash_sub,MT_dat_all.position_gradual_wash_sub,MT_info_all,[FF_K,FF_B],'offset_off','dont_initial_zero',Grad_subs);

%
[gradual_base_aligned_comp_ave,gradual_base_aligned_comp_sd,gradual_base_misaligned_comp_ave,gradual_base_misaligned_comp_sd]=...
    extract_relevant_and_irrelevant_components_subjects_12_07_14(PV_gradual_base_subjects,[2,1]);
[gradual_test_aligned_comp_ave,gradual_test_aligned_comp_sd,gradual_test_misaligned_comp_ave,gradual_test_misaligned_comp_sd]=...
    extract_relevant_and_irrelevant_components_subjects_12_07_14(PV_gradual_test_subjects,[2,1]);
[gradual_wash_aligned_comp_ave,gradual_wash_aligned_comp_sd,gradual_wash_misaligned_comp_ave,gradual_wash_misaligned_comp_sd]=...
    extract_relevant_and_irrelevant_components_subjects_12_07_14(PV_gradual_wash_subjects,[2,1]);
%

if goal_aligned_cut>0.3
    adaptation_gradual_ndx=find((gradual_test_aligned_comp_ave<goal_aligned_cut),1,'last');
    wash_gradual_ndx=find(gradual_wash_aligned_comp_ave<gradual_test_aligned_comp_ave(adaptation_gradual_ndx),1);
else 
    adaptation_gradual_ndx=find((gradual_test_aligned_comp_ave>goal_aligned_cut),1,'first');
    wash_gradual_ndx=find(gradual_wash_aligned_comp_ave>gradual_test_aligned_comp_ave(adaptation_gradual_ndx),1,'last');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
abrupt_short_EC_base_NDX=[MT_info_all.abrupt_short_base_EC_NDX]-(MT_info_all.abrupt_short_base_EC_NDX(end));
abrupt_short_EC_test_NDX=[MT_info_all.abrupt_short_test_EC_NDX];
abrupt_short_EC_wash_NDX=(MT_info_all.abrupt_short_wash_EC_NDX+1)+MT_info_all.abrupt_short_test_EC_NDX(end);
%
abrupt_long_EC_base_NDX=[MT_info_all.abrupt_long_base_EC_NDX]-(MT_info_all.abrupt_long_base_EC_NDX(end));
abrupt_long_EC_test_NDX=[MT_info_all.abrupt_long_test_EC_NDX];
abrupt_long_EC_wash_NDX=(MT_info_all.abrupt_long_wash_EC_NDX+1)+MT_info_all.abrupt_long_test_EC_NDX(end);
%
gradual_EC_base_NDX=[MT_info_all.gradual_base_EC_NDX]-(MT_info_all.gradual_base_EC_NDX(end));
gradual_EC_test_NDX=[MT_info_all.gradual_test_EC_NDX];
gradual_EC_wash_NDX=(MT_info_all.gradual_wash_EC_NDX+1)+MT_info_all.gradual_test_EC_NDX(end);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% create comparison between cases 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% comparing misaligned components 
[abrupt_long_wash_data]=create_subject_matrix_for_bar_plot_31_7_14(PV_abrupt_long_wash_subjects,window_length,window_length,early_wash_st,mid_wash_st,MT_num_of_subjects,[1,2]);
[gradual_wash_data]=create_subject_matrix_for_bar_plot_31_7_14(PV_gradual_wash_subjects,window_length,window_length,early_wash_st,mid_wash_st,MT_num_of_subjects,[1,2]);
%
misaligned_data_early_wash_abrupt_gradual_norm={abrupt_long_wash_data{1,1},gradual_wash_data{1,1}};
misaligned_data_mid_wash_abrupt_gradual_norm={abrupt_long_wash_data{2,1},gradual_wash_data{2,1}};
misaligned_data_late_wash_abrupt_gradual_norm={abrupt_long_wash_data{3,1},gradual_wash_data{3,1}};
%
misaligned_data_early_wash_abrupt_gradual_ave_norm=cellfun(@nanmean,misaligned_data_early_wash_abrupt_gradual_norm);
misaligned_data_mid_wash_abrupt_gradual_ave_norm=cellfun(@nanmean,misaligned_data_mid_wash_abrupt_gradual_norm);
misaligned_data_late_wash_abrupt_gradual_ave_norm=cellfun(@nanmean,misaligned_data_late_wash_abrupt_gradual_norm);
%
misaligned_data_early_wash_abrupt_gradual_se_norm=cellfun(@nanstd,misaligned_data_early_wash_abrupt_gradual_norm).*[MT_num_of_subjects,MT_num_of_subjects].^-.5;
misaligned_data_mid_wash_abrupt_gradual_se_norm=cellfun(@nanstd,misaligned_data_mid_wash_abrupt_gradual_norm).*[MT_num_of_subjects,MT_num_of_subjects].^-.5;
misaligned_data_late_wash_abrupt_gradual_se_norm=cellfun(@nanstd,misaligned_data_late_wash_abrupt_gradual_norm).*[MT_num_of_subjects,MT_num_of_subjects].^-.5;
%
[h_matrix_misaligned_early_wash_norm,p_matrix_misaligned_early_wash_norm]=calculate_t_test_for_subject_data_27_07_14(misaligned_data_early_wash_abrupt_gradual_norm,'both');
[h_matrix_misaligned_mid_wash_norm,p_matrix_misaligned_mid_wash_norm]=calculate_t_test_for_subject_data_27_07_14(misaligned_data_mid_wash_abrupt_gradual_norm,'both');
[h_matrix_misaligned_late_wash_norm,p_matrix_misaligned_late_wash_norm]=calculate_t_test_for_subject_data_27_07_14(misaligned_data_late_wash_abrupt_gradual_norm,'both');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% create comparison for goal misligned 
[abrupt_short_initial_adapt_data]=create_subject_matrix_for_bar_plot_31_7_14(PV_abrupt_short_test_subjects,1,1,adaptation_abrupt_short_ndx,1,MT_num_of_subjects,[1,2]);
[abrupt_short_equal_wash_data]=create_subject_matrix_for_bar_plot_31_7_14(PV_abrupt_short_wash_subjects,1,1,wash_abrupt_short_ndx,1,MT_num_of_subjects,[1,2]);
%
[abrupt_long_initial_adapt_data]=create_subject_matrix_for_bar_plot_31_7_14(PV_abrupt_long_test_subjects,1,1,adaptation_abrupt_long_ndx,1,MT_num_of_subjects,[1,2]);
[abrupt_long_equal_wash_data]=create_subject_matrix_for_bar_plot_31_7_14(PV_abrupt_long_wash_subjects,1,1,wash_abrupt_long_ndx,1,MT_num_of_subjects,[1,2]);
%
[gradual_initial_adapt_data]=create_subject_matrix_for_bar_plot_31_7_14(PV_gradual_test_subjects,1,1,adaptation_gradual_ndx,1,MT_num_of_subjects,[1,2]);
[gradual_equal_wash_data]=create_subject_matrix_for_bar_plot_31_7_14(PV_gradual_wash_subjects,1,1,wash_gradual_ndx,1,MT_num_of_subjects,[1,2]);
%
misaligned_data__abrupt_short_initial_adaptation_equal_wash={abrupt_short_initial_adapt_data{1,1},abrupt_short_equal_wash_data{1,1}};
misaligned_data__abrupt_short_initial_adaptation_equal_wash_ave=cellfun(@nanmean,misaligned_data__abrupt_short_initial_adaptation_equal_wash);
misaligned_data__abrupt_short_initial_adaptation_equal_wash_se=cellfun(@nanstd,misaligned_data__abrupt_short_initial_adaptation_equal_wash).*[MT_num_of_subjects,MT_num_of_subjects].^-.5;
[h_matrix_abrupt_short_initial_adaptation_equal_wash,p_matrix_abrupt_short_initial_adaptation_equal_wash]=calculate_t_test_for_subject_data_27_07_14(misaligned_data__abrupt_short_initial_adaptation_equal_wash,'both');
%
misaligned_data__abrupt_long_initial_adaptation_equal_wash={abrupt_long_initial_adapt_data{1,1},abrupt_long_equal_wash_data{1,1}};
misaligned_data__abrupt_long_initial_adaptation_equal_wash_ave=cellfun(@nanmean,misaligned_data__abrupt_long_initial_adaptation_equal_wash);
misaligned_data__abrupt_long_initial_adaptation_equal_wash_se=cellfun(@nanstd,misaligned_data__abrupt_long_initial_adaptation_equal_wash).*[MT_num_of_subjects,MT_num_of_subjects].^-.5;
[h_matrix_abrupt_long_initial_adaptation_equal_wash,p_matrix_abrupt_long_initial_adaptation_equal_wash]=calculate_t_test_for_subject_data_27_07_14(misaligned_data__abrupt_long_initial_adaptation_equal_wash,'both');
%
misaligned_data__gradual_initial_adaptation_equal_wash={gradual_initial_adapt_data{1,1},gradual_equal_wash_data{1,1}};
misaligned_data__gradual_initial_adaptation_equal_wash_ave=cellfun(@nanmean,misaligned_data__gradual_initial_adaptation_equal_wash);
misaligned_data__gradual_initial_adaptation_equal_wash_se=cellfun(@nanstd,misaligned_data__gradual_initial_adaptation_equal_wash).*[MT_num_of_subjects,MT_num_of_subjects].^-.5;
[h_matrix_gradual_initial_adaptation_equal_wash,p_matrix_gradual_initial_adaptation_equal_wash]=calculate_t_test_for_subject_data_27_07_14(misaligned_data__gradual_initial_adaptation_equal_wash,'both');
%
%% comparison of aligned component

aligned_data__abrupt_short_initial_adaptation_equal_wash={abrupt_short_initial_adapt_data{1,2},abrupt_short_equal_wash_data{1,2}};
aligned_data__abrupt_short_initial_adaptation_equal_wash_ave=cellfun(@nanmean,aligned_data__abrupt_short_initial_adaptation_equal_wash);
aligned_data__abrupt_short_initial_adaptation_equal_wash_se=cellfun(@nanstd,aligned_data__abrupt_short_initial_adaptation_equal_wash).*[MT_num_of_subjects,MT_num_of_subjects].^-.5;
[h_matrix_abrupt_short_initial_adaptation_equal_wash_aligned,p_matrix_abrupt_short_initial_adaptation_equal_wash_aligned]=calculate_t_test_for_subject_data_27_07_14(aligned_data__abrupt_short_initial_adaptation_equal_wash,'both');
%
aligned_data__abrupt_long_initial_adaptation_equal_wash={abrupt_long_initial_adapt_data{1,2},abrupt_long_equal_wash_data{1,2}};
aligned_data__abrupt_long_initial_adaptation_equal_wash_ave=cellfun(@nanmean,aligned_data__abrupt_long_initial_adaptation_equal_wash);
aligned_data__abrupt_long_initial_adaptation_equal_wash_se=cellfun(@nanstd,aligned_data__abrupt_long_initial_adaptation_equal_wash).*[MT_num_of_subjects,MT_num_of_subjects].^-.5;
[h_matrix_abrupt_long_initial_adaptation_equal_wash_aligned,p_matrix_abrupt_long_initial_adaptation_equal_wash_aligned]=calculate_t_test_for_subject_data_27_07_14(aligned_data__abrupt_long_initial_adaptation_equal_wash,'both');
%
aligned_data__gradual_initial_adaptation_equal_wash={gradual_initial_adapt_data{1,2},gradual_equal_wash_data{1,2}};
aligned_data__gradual_initial_adaptation_equal_wash_ave=cellfun(@nanmean,aligned_data__gradual_initial_adaptation_equal_wash);
aligned_data__gradual_initial_adaptation_equal_wash_se=cellfun(@nanstd,aligned_data__gradual_initial_adaptation_equal_wash).*[MT_num_of_subjects,MT_num_of_subjects].^-.5;
[h_matrix_gradual_initial_adaptation_equal_wash_aligned,p_matrix_gradual_initial_adaptation_equal_wash_aligned]=calculate_t_test_for_subject_data_27_07_14(aligned_data__gradual_initial_adaptation_equal_wash,'both');
%
%% attach start and end of different sections
% position 
% test
 [abrupt_short_test_aligned_comp_ave,abrupt_short_test_aligned_comp_sd]=attach_end_of_adaptation_coeffients(0,0,abrupt_short_test_aligned_comp_ave,abrupt_short_test_aligned_comp_sd);
 [abrupt_short_wash_aligned_comp_ave,abrupt_short_wash_aligned_comp_sd]=attach_end_of_adaptation_coeffients(abrupt_short_test_aligned_comp_ave,abrupt_short_test_aligned_comp_sd,abrupt_short_wash_aligned_comp_ave,abrupt_short_wash_aligned_comp_sd);
 [abrupt_short_test_misaligned_comp_ave,abrupt_short_test_misaligned_comp_sd]=attach_end_of_adaptation_coeffients(0,0,abrupt_short_test_misaligned_comp_ave,abrupt_short_test_misaligned_comp_sd);
 [abrupt_short_wash_misaligned_comp_ave,abrupt_short_wash_misaligned_comp_sd]=attach_end_of_adaptation_coeffients(abrupt_short_test_misaligned_comp_ave,abrupt_short_test_misaligned_comp_sd,abrupt_short_wash_misaligned_comp_ave,abrupt_short_wash_aligned_comp_sd);

%
 [abrupt_long_test_aligned_comp_ave,abrupt_long_test_aligned_comp_sd]=attach_end_of_adaptation_coeffients(0,0,abrupt_long_test_aligned_comp_ave,abrupt_long_test_aligned_comp_sd);
 [abrupt_long_wash_aligned_comp_ave,abrupt_long_wash_aligned_comp_sd]=attach_end_of_adaptation_coeffients(abrupt_long_test_aligned_comp_ave,abrupt_long_test_aligned_comp_sd,abrupt_long_wash_aligned_comp_ave,abrupt_long_wash_aligned_comp_sd);
 [abrupt_long_test_misaligned_comp_ave,abrupt_long_test_misaligned_comp_sd]=attach_end_of_adaptation_coeffients(0,0,abrupt_long_test_misaligned_comp_ave,abrupt_long_test_misaligned_comp_sd);
 [abrupt_long_wash_misaligned_comp_ave,abrupt_long_wash_misaligned_comp_sd]=attach_end_of_adaptation_coeffients(abrupt_long_test_misaligned_comp_ave,abrupt_long_test_misaligned_comp_sd,abrupt_long_wash_misaligned_comp_ave,abrupt_long_wash_aligned_comp_sd);
%
 [gradual_test_aligned_comp_ave,gradual_test_aligned_comp_sd]=attach_end_of_adaptation_coeffients(0,0,gradual_test_aligned_comp_ave,gradual_test_aligned_comp_sd);
 [gradual_wash_aligned_comp_ave,gradual_wash_aligned_comp_sd]=attach_end_of_adaptation_coeffients(gradual_test_aligned_comp_ave,gradual_test_aligned_comp_sd,gradual_wash_aligned_comp_ave,gradual_wash_aligned_comp_sd);
 [gradual_test_misaligned_comp_ave,gradual_test_misaligned_comp_sd]=attach_end_of_adaptation_coeffients(0,0,gradual_test_misaligned_comp_ave,gradual_test_misaligned_comp_sd);
 [gradual_wash_misaligned_comp_ave,gradual_wash_misaligned_comp_sd]=attach_end_of_adaptation_coeffients(gradual_test_misaligned_comp_ave,gradual_test_misaligned_comp_sd,gradual_wash_misaligned_comp_ave,gradual_wash_aligned_comp_sd);


%% plot adaptation and decay for different cases 
h=figure(fig_num);
set(0,'ShowhiddenHandles','on')
set(h, 'PaperOrientation', 'portrait');
%show position
subplot('position',[.1,.5,.25,.45]);
% position
Display_gain_plot_11_07_14([abrupt_short_test_misaligned_comp_ave,abrupt_short_test_aligned_comp_ave],abrupt_short_adapt_color,curve_widith,[-.1,.4,-.1,1.01],'Adaptation');
Display_gain_plot_11_07_14([abrupt_short_wash_misaligned_comp_ave,abrupt_short_wash_aligned_comp_ave],abrupt_short_wash_color,curve_widith,[-.1,.4,-.1,1.01],'Unlearning');
%
daspect([1,1,1])
o1=plot(0,1,'s','markeredgecolor','k','markerfacecolor',abrupt_short_adapt_color,'markersize',8,'linewidth',1);
hg=get(o1,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');
%
% o2=plot([.65,.9],[.65,.65],'color',abrupt_short_misaligned_comp,'lineWidth',curve_widith,'displayname','');
% o3=plot([.65,.65],[.65,.9],'color',abrupt_short_adapt_color,'lineWidth',curve_widith,'displayname','');
% hg=get(o2,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(o2,'bottom');
% hg=get(o3,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(o3,'bottom');

goal_aligned_point_AS_vFF_first=abrupt_short_test_aligned_comp_ave(2);
goal_aligned_point_AS_vFF_second=abrupt_short_test_aligned_comp_ave(3);

o1=plot([-.1,0.4],[.2549,.2549],'k.-','lineWidth',.5,'color',[.5,.5,.5]); hold on;
plot([-.1,0.4],[.5057,.5057],'k.-','lineWidth',.5,'color',[.5,.5,.5]);
hg=get(o1,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');
uistack(o1,'bottom')

%
text(.61,.65,'goal aligned','VerticalAlignment','bottom','HorizontalAlignment','left','FontSize',8,'rotation',90);
text(.65,.61,'goal mis-aligned','VerticalAlignment','top','HorizontalAlignment','left','FontSize',8,'rotation',0);
% mark comparison points on the graph 

set(gca,'ytick',y,'yticklabel',sprintf('%1.1f|',y),'xtick',y,'xticklabel',sprintf('%1.1f|',y),'fontsize',8)
xlabel('Position Gain','fontsize',8);ylabel('Velocity Gain','fontsize',8);    
leg=legend('show','location',[.175,.85,.05,.05]);
set(leg,'FontSize',8);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
subplot('position',[.4,.5,.25,.45]);
% position
Display_gain_plot_11_07_14([abrupt_long_test_misaligned_comp_ave,abrupt_long_test_aligned_comp_ave],abrupt_long_adapt_color,curve_widith,[-.1,.4,-.1,1.01],'Adaptation');
Display_gain_plot_11_07_14([abrupt_long_wash_misaligned_comp_ave,abrupt_long_wash_aligned_comp_ave],abrupt_long_wash_color,curve_widith,[-.1,.4,-.1,1.01],'Unlearning');
%
daspect([1,1,1])
o1=plot(0,1,'s','markeredgecolor','k','markerfacecolor',abrupt_long_adapt_color,'markersize',8,'linewidth',1);
hg=get(o1,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');


%%%Editing begins
%Using 2nd and 3rd point of learning
goal_aligned_point_AL_vFF_first=abrupt_long_test_aligned_comp_ave(2);
goal_aligned_point_AL_vFF_second=abrupt_long_test_aligned_comp_ave(3);
%for the corresponding misaligned component in the decay period, use cursor/graph (temporary solution)

o1=plot([-.1,0.4],[goal_aligned_point_AL_vFF_first,goal_aligned_point_AL_vFF_first],'k.-','lineWidth',.5,'color',[.5,.5,.5]); hold on;
plot([-.1,0.4],[goal_aligned_point_AL_vFF_second,goal_aligned_point_AL_vFF_second],'k.-','lineWidth',.5,'color',[.5,.5,.5]);
hg=get(o1,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');
uistack(o1,'bottom')






% o2=plot([.65,.9],[.65,.65],'color',abrupt_long_misaligned_comp,'lineWidth',curve_widith,'displayname','');
% o3=plot([.65,.65],[.65,.9],'color',abrupt_long_adapt_color,'lineWidth',curve_widith,'displayname','');
% hg=get(o2,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(o2,'bottom');
% hg=get(o3,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(o3,'bottom');
%
text(.61,.65,'goal aligned','VerticalAlignment','bottom','HorizontalAlignment','left','FontSize',8,'rotation',90);
text(.65,.61,'goal mis-aligned','VerticalAlignment','top','HorizontalAlignment','left','FontSize',8,'rotation',0);
% mark comparison points on the graph 

set(gca,'ytick',y,'yticklabel',sprintf('%1.1f|',y),'xtick',y,'xticklabel',sprintf('%1.1f|',y),'fontsize',8)
xlabel('Position Gain','fontsize',8);ylabel('Velocity Gain','fontsize',8);    
leg=legend('show','location',[.175,.85,.05,.05]);
set(leg,'FontSize',8);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot('position',[.7,.5,.25,.45]);
% position
Display_gain_plot_11_07_14([gradual_test_misaligned_comp_ave,gradual_test_aligned_comp_ave],gradual_adapt_color,curve_widith,[-.1,.4,-.1,1.01],'Adaptation');
Display_gain_plot_11_07_14([gradual_wash_misaligned_comp_ave,gradual_wash_aligned_comp_ave],gradual_wash_color,curve_widith,[-.1,.4,-.1,1.01],'Unlearning');
%
daspect([1,1,1])
o1=plot(0,1,'s','markeredgecolor','k','markerfacecolor',gradual_adapt_color,'markersize',8,'linewidth',1);
hg=get(o1,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');
%
% o2=plot([.65,.9],[.65,.65],'color',gradual_misaligned_comp,'lineWidth',curve_widith,'displayname','');
% o3=plot([.65,.65],[.65,.9],'color',gradual_adapt_color,'lineWidth',curve_widith,'displayname','');
% hg=get(o2,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(o2,'bottom');
% hg=get(o3,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(o3,'bottom');


o1=plot([-.1,0.4],[.1898,.1898],'k.-','lineWidth',.5,'color',[.5,.5,.5]); hold on;
plot([-.1,0.4],[.5134,.5134],'k.-','lineWidth',.5,'color',[.5,.5,.5]);
hg=get(o1,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');
uistack(o1,'bottom')

%
text(.61,.65,'goal aligned','VerticalAlignment','bottom','HorizontalAlignment','left','FontSize',8,'rotation',90);
text(.65,.61,'goal mis-aligned','VerticalAlignment','top','HorizontalAlignment','left','FontSize',8,'rotation',0);
% mark comparison points on the graph 

set(gca,'ytick',y,'yticklabel',sprintf('%1.1f|',y),'xtick',y,'xticklabel',sprintf('%1.1f|',y),'fontsize',8)
xlabel('Position Gain','fontsize',8);ylabel('Velocity Gain','fontsize',8);    
leg=legend('show','location',[.175,.85,.05,.05]);
set(leg,'FontSize',8);

%%
if show_error_ellipse
    % position
    subplot('position',[.1,.5,.25,.45]);
    Display_SE_ellipses_11_07_14({PV_abrupt_short_test_subjects{1}*0,PV_abrupt_short_test_subjects{:}}',...
        [abrupt_short_test_misaligned_comp_ave,abrupt_short_test_aligned_comp_ave],abrupt_short_adapt_color,.5,'dont_show_orientation',1,1,[1,2]);
    Display_SE_ellipses_11_07_14({PV_abrupt_short_test_subjects{end}*0,PV_abrupt_short_wash_subjects{:}}',...
        [abrupt_short_wash_misaligned_comp_ave,abrupt_short_wash_aligned_comp_ave],abrupt_short_wash_shade,.5,'dont_show_orientation',1,1,[1,2]);
    daspect([1,1,1])
    % velocity
    subplot('position',[.4,.5,.25,.45]);
    Display_SE_ellipses_11_07_14({PV_abrupt_long_test_subjects{1}*0,PV_abrupt_long_test_subjects{:}}',...
        [abrupt_long_test_misaligned_comp_ave,abrupt_long_test_aligned_comp_ave],abrupt_long_adapt_color,.5,'dont_show_orientation',1,1,[1,2]);
    Display_SE_ellipses_11_07_14({PV_abrupt_long_test_subjects{end}*0,PV_abrupt_long_wash_subjects{:}}',...
        [abrupt_long_wash_misaligned_comp_ave,abrupt_long_wash_aligned_comp_ave],abrupt_long_wash_shade,.5,'dont_show_orientation',1,1,[1,2]);
    daspect([1,1,1])
    
        subplot('position',[.7,.5,.25,.45]);
    Display_SE_ellipses_11_07_14({PV_gradual_test_subjects{1}*0,PV_gradual_test_subjects{:}}',...
        [gradual_test_misaligned_comp_ave,gradual_test_aligned_comp_ave],gradual_adapt_color,.5,'dont_show_orientation',1,1,[1,2]);
    Display_SE_ellipses_11_07_14({PV_gradual_test_subjects{end}*0,PV_gradual_wash_subjects{:}}',...
        [gradual_wash_misaligned_comp_ave,gradual_wash_aligned_comp_ave],gradual_wash_shade,.5,'dont_show_orientation',1,1,[1,2]);
    daspect([1,1,1])
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% show relevant and irrelevant primitive behavior
% % position
 subplot('position',[.1,.25,.25,.2])
 abrupt_long_wash_EC_NDX_corrected=MT_info_all.abrupt_long_wash_EC_NDX+1;
gradual_wash_EC_NDX_corrected=MT_info_all.gradual_wash_EC_NDX+1;
%
Display_single_adaptation_normalize_11_7_14(gradual_wash_aligned_comp_ave(2:end),1,gradual_wash_EC_NDX_corrected,gradual_adapt_color,'off',curve_widith,'-');
Display_single_adaptation_normalize_11_7_14(abrupt_long_wash_aligned_comp_ave(2:end),1,abrupt_long_wash_EC_NDX_corrected,abrupt_long_adapt_color,'off',curve_widith,'-');
%
Display_single_adaptation_normalize_11_7_14(gradual_wash_misaligned_comp_ave(2:end),1,gradual_wash_EC_NDX_corrected,gradual_adapt_color,'off',curve_widith,'--');
Display_single_adaptation_normalize_11_7_14(abrupt_long_wash_misaligned_comp_ave(2:end),1,abrupt_long_wash_EC_NDX_corrected,abrupt_long_adapt_color,'off',curve_widith,'--');

% % shading 
% % base
 standard_error_shading_11_07_14(-gradual_wash_aligned_comp_ave(2:end),gradual_wash_aligned_comp_sd(2:end),gradual_wash_EC_NDX_corrected,MT_num_of_subjects,gradual_adapt_shade)
 standard_error_shading_11_07_14(-abrupt_long_wash_aligned_comp_ave(2:end),abrupt_long_wash_aligned_comp_sd(2:end),abrupt_long_wash_EC_NDX_corrected,MT_num_of_subjects,abrupt_long_adapt_shade)% % test
 %
standard_error_shading_11_07_14(-gradual_wash_misaligned_comp_ave(2:end),gradual_wash_misaligned_comp_sd(2:end),gradual_wash_EC_NDX_corrected,MT_num_of_subjects,gradual_adapt_shade)
standard_error_shading_11_07_14(-abrupt_long_wash_misaligned_comp_ave(2:end),abrupt_long_wash_misaligned_comp_sd(2:end),abrupt_long_wash_EC_NDX_corrected,MT_num_of_subjects,abrupt_long_adapt_shade)% % test

o1=plot([-0,60],[0,0],'k--','lineWidth',.5);uistack(o1,'bottom');


hg=get(o1,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');
uistack(o1,'bottom');
% add shades 
h4=area([early_wash_st+1,early_wash_st+window_length],[1.01,1.01],'linestyle','none','facecolor',early_adapt_shade,'basevalue',-.2);
hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');
%
h4=area([mid_wash_st,mid_wash_st+window_length],[1.01,1.01],'linestyle','none','facecolor',mid_wash_shade,'basevalue',-.2);
hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');
%
h4=area([gradual_wash_EC_NDX_corrected(end-window_length),gradual_wash_EC_NDX_corrected(end)],[1.01,1.01],'linestyle','none','facecolor',late_wash_shade,'basevalue',-.2);
hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');
%
text(early_wash_st+window_length/2,-.05,'E','VerticalAlignment','top','HorizontalAlignment','center','FontSize',8);
text(gradual_wash_EC_NDX_corrected(mid_wash_st+floor(window_length/2)),-.05,'M','VerticalAlignment','top','HorizontalAlignment','center','FontSize',8);
text(gradual_wash_EC_NDX_corrected(end-floor(window_length/2)),-.05,'L','VerticalAlignment','top','HorizontalAlignment','center','FontSize',8);
%
text(gradual_wash_EC_NDX_corrected(ceil(end/2)),1.05,'Adaptation','VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',7);
text(gradual_wash_EC_NDX_corrected(ceil(end/2)),1.05,'Unlearning','VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',7);
%
y=[-.2:.2:1.2];
set(gca,'fontsize',8,'ytick',y,'yticklabel',sprintf('%1.1f|',y),'xtick',[0:10:60],'xlim',[0,62],'ylim',[-0.2,1.01],'layer','top');
ylabel('Adaptation Coefficient','FontSize',8,'FontWeight','normal','Color','k');
xlabel('Trial Number','FontSize',8,'FontWeight','normal','Color','k');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    all gain space analyses occur above
subplot('position',[.36,.25,.12,.2])
x=[.25 .75;.25 .75];
fit_early_adapt_mid_wash_norm_ave=[misaligned_data_early_wash_abrupt_gradual_ave_norm',misaligned_data_mid_wash_abrupt_gradual_ave_norm'];
fit_early_adapt_mid_wash_norm_se=[misaligned_data_early_wash_abrupt_gradual_se_norm',misaligned_data_mid_wash_abrupt_gradual_se_norm'];

Training_sequence={'abrupt long','gradual'};
Training_color_seq=[abrupt_long_adapt_color;gradual_adapt_color];
plot_bar_with_error_11_07_14(x',fit_early_adapt_mid_wash_norm_ave',fit_early_adapt_mid_wash_norm_se',Training_sequence,Training_color_seq,h_matrix_misaligned_early_wash_norm,h_matrix_misaligned_mid_wash_norm);
%
fit_late_wash_norm_ave=[[nan,nan]',misaligned_data_late_wash_abrupt_gradual_ave_norm'];
fit_late_wash_norm_se=[[nan,nan]',misaligned_data_late_wash_abrupt_gradual_se_norm'];
x=[.75 1.25;.75 1.25];
Training_sequence={'abrupt long','gradual'};
Training_color_seq=[abrupt_long_adapt_color;gradual_adapt_color];
plot_bar_with_error_11_07_14(x',fit_late_wash_norm_ave',fit_late_wash_norm_se',Training_sequence,Training_color_seq,zeros(2),h_matrix_misaligned_late_wash_norm);
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
y=[-.1:.05:.1];
set(gca,'FontSize',8,'ytick',y,'yticklabel','','xtick',[0.25,0.75,1.25],'xticklabel','','xlim',[0,1.5],'ylim',[-0.1,.1],'layer','top','box','off');
%%
subplot('position',[.6,.25,.12,.2])

%Bar graphs of interest

x=[.25 .75;.25 .75];
fit_early_adapt_mid_wash_norm_ave=[misaligned_data__abrupt_short_initial_adaptation_equal_wash_ave',[nan,nan]'];
fit_early_adapt_mid_wash_norm_se=[misaligned_data__abrupt_short_initial_adaptation_equal_wash_se',[nan,nan]'];

Training_sequence={'abrupt short','abrupt_short'};
Training_color_seq=[abrupt_short_adapt_color;abrupt_short_adapt_color];
plot_bar_with_error_11_07_14(x',fit_early_adapt_mid_wash_norm_ave',fit_early_adapt_mid_wash_norm_se',Training_sequence,Training_color_seq,h_matrix_abrupt_short_initial_adaptation_equal_wash,zeros(2));
%
x=[.75 1.25;.75 1.25];
fit_early_adapt_mid_wash_norm_ave=[misaligned_data__abrupt_long_initial_adaptation_equal_wash_ave',[nan,nan]'];
fit_early_adapt_mid_wash_norm_se=[misaligned_data__abrupt_long_initial_adaptation_equal_wash_se',[nan,nan]'];

Training_sequence={'abrupt long','abrupt_long'};
Training_color_seq=[abrupt_long_adapt_color;abrupt_long_adapt_color];
plot_bar_with_error_11_07_14(x',fit_early_adapt_mid_wash_norm_ave',fit_early_adapt_mid_wash_norm_se',Training_sequence,Training_color_seq,h_matrix_abrupt_long_initial_adaptation_equal_wash,zeros(2));
%
x=[.75 1.25;.75 1.25];
fit_early_adapt_mid_wash_norm_ave=[[nan,nan]',misaligned_data__gradual_initial_adaptation_equal_wash_ave'];
fit_early_adapt_mid_wash_norm_se=[[nan,nan]',misaligned_data__gradual_initial_adaptation_equal_wash_se'];

Training_sequence={'gradual','gradual'};
Training_color_seq=[gradual_adapt_color;gradual_adapt_color];
plot_bar_with_error_11_07_14(x',fit_early_adapt_mid_wash_norm_ave',fit_early_adapt_mid_wash_norm_se',Training_sequence,Training_color_seq,zeros(2),h_matrix_gradual_initial_adaptation_equal_wash);

%
h4=area([0,.5],[1.01,1.01],'linestyle','none','facecolor',early_wash_shade,'basevalue',-.2);
hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');
%
h4=area([.5,1],[1.01,1.01],'linestyle','none','facecolor',mid_wash_shade,'basevalue',-.2);
hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');
%
h4=area([1,1.5],[1.01,1.01],'linestyle','none','facecolor',late_wash_shade,'basevalue',-.2);
hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');

text(0.25,-0.05,'AS','VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
text(0.75,-0.05,'AL','VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
text(1.25,-0.05,'G','VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
%
y=[-.2:.2:0.4];
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,0.75,1.25],'xticklabel','','xlim',[0,1.5],'ylim',[-0.2,.40],'layer','top','box','off');

% decay_trials=[160:2:219];
% figure; hold on;
% %%%learning
% plot(abrupt_short_EC_test_NDX,ave_r2_test_AS,'.-','Linewidth',2,'markersize',20)
% plot([abrupt_short_EC_test_NDX(end):decay_trials(1)],[repmat(ave_r2_test_AS(end),decay_trials(1)-abrupt_short_EC_test_NDX(end)+1,1)],'--','Linewidth',2)
% plot(decay_trials,ave_r2_wash_AS,'s-','Linewidth',2,'markersize',5)
% 
% plot(abrupt_long_EC_test_NDX,ave_r2_test_AL,'r.-','Linewidth',2,'markersize',20)
% plot([abrupt_long_EC_test_NDX(end),abrupt_long_EC_wash_NDX(1)],[ave_r2_test_AL(end),ave_r2_wash_AL(1)],'r-','Linewidth',2)
% plot(abrupt_long_EC_wash_NDX,ave_r2_wash_AL,'rs-','Linewidth',2,'markersize',5)
% 
% plot(gradual_EC_test_NDX,ave_r2_test_GL,'g.-','Linewidth',2,'markersize',20)
% plot([gradual_EC_test_NDX(end),gradual_EC_wash_NDX(1)],[ave_r2_test_GL(end),ave_r2_wash_GL(1)],'g-','Linewidth',2)
% plot(gradual_EC_wash_NDX,ave_r2_wash_GL,'gs-','Linewidth',2,'markersize',5)
% 
% title('R-squared progession','Fontsize',14);
% set(gca,'Fontsize',12);
% ylabel('R-squared value','Fontsize',12)
% xlabel('Trial after learning onset','Fontsize',12);
% ylim([0 1])



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% annotation('textbox',[.1,.95,.35,.05],'string','Position FF','parent',h,'edgecolor','none','color','k','horizontalalignment','center','verticalalignment','middle','fontsize',10,'fontweight','demi');
% annotation('textbox',[.6,.95,.35,.05],'string','Velocity FF','parent',h,'edgecolor','none','color','k','horizontalalignment','center','verticalalignment','middle','fontsize',10,'fontweight','demi');
% annotation('textbox',[.1,.52,.38,.05],'string','Position FF','parent',h,'edgecolor','none','color','k','horizontalalignment','center','verticalalignment','middle','fontsize',10,'fontweight','demi')
% annotation('textbox',[.6,.52,.38,.05],'string','Velocity FF','parent',h,'edgecolor','none','color','k','horizontalalignment','center','verticalalignment','middle','fontsize',10,'fontweight','demi')
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% create supplimentary figure for orientation of variability during decay 
% posexp_wash_var_orientation=(posexp_wash_misaligned_comp_sd./posexp_wash_aligned_comp_sd);
% velexp_wash_var_orientation=(velexp_wash_misaligned_comp_sd./velexp_wash_aligned_comp_sd);
% 
% figure(100)
% Display_single_adaptation_normalize_11_7_14(posexp_wash_var_orientation,1,posexp_EC_wash_NDX,posexp_adaptation_color,'off',curve_widith,'-');
% Display_single_adaptation_normalize_11_7_14(velexp_wash_var_orientation,1,velexp_EC_wash_NDX,velexp_adaptation_color,'off',curve_widith,'-');


end

