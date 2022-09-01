close all 
%clear all 
home
%%

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
early_wash_st=10;
mid_wash_st=30;
window_length=10;
curve_width=1.5;
iteration=200;
%
 wash_period_abrupt_long=[176,235];
%wash_period_abrupt_long=[61,180];
F_abrupt_long=[zeros(15,1);ones(160,1)];
% F_abrupt_long=[zeros(10,1);ones(50,1)];
Abrupt_long_output=zeros(iteration,wash_period_abrupt_long(end));
Abrupt_long_slow=Abrupt_long_output*0;
Abrupt_long_fast=Abrupt_long_output*0;

F_abrupt_short=[zeros(15,1);ones(15,1)];
wash_period_abrupt_short=[31,90];
Abrupt_short_output=zeros(iteration,wash_period_abrupt_short(end));
Abrupt_short_slow=Abrupt_short_output*0;
Abrupt_short_fast=Abrupt_short_output*0;

F_gradual=[zeros(15,1);min([1/15*(1:160).^(log(15)/log(145));ones(1,160)])'];
%F_gradual=[zeros(9,1);linspace(0,1,16)';ones(5,1)];
 wash_period_gradual=[176,235]; %should end at 235
%wash_period_gradual=[31,90];
Gradual_output=zeros(iteration,wash_period_gradual(end));
Gradual_slow=Gradual_output*0;
Gradual_fast=Gradual_output*0;


% simulate abrupt long 
R_ratio=0.1:0.03:.6;

%Smith 2006
% As=.992;
% Af=.59;
% Bf =.21;
% Bs=.02;


% Joiner&Smith 2008
% As=.998;
% Af=.85;
% Bf =.11;
% Bs=.021;

% Reza
% As=.988;
% Af=.85;
% Bf =.08;
% Bs=.04;


As=0.9836;
Af=0.8192;
Bf=0.2103;
Bs=0.0348;

% As=0.9739;
% Af=0.6513;
% Bf=0.3634;
% Bs=0.0368;

A=[As 0;0, Af];
B=[Bs;Bf];

R=1e-2;
 Q=sqrt(3)*10^-2;
% R=0;
% Q=0;

for nn=1:iteration;
    %
    [two_state_model_output_AL,slow_state_AL,fast_state_AL]=two_state_model_simulation_15_10_14(A,B,Q,R,F_abrupt_long,wash_period_abrupt_long);
    Abrupt_long_output(nn,:)=two_state_model_output_AL;
    Abrupt_long_slow(nn,:)=slow_state_AL;
    Abrupt_long_fast(nn,:)=fast_state_AL;
    % 
    [two_state_model_output_AS,slow_state_AS,fast_state_AS]=two_state_model_simulation_15_10_14(A,B,Q,R,F_abrupt_short,wash_period_abrupt_short);
    Abrupt_short_output(nn,:)=two_state_model_output_AS;
    Abrupt_short_slow(nn,:)=slow_state_AS;
    Abrupt_short_fast(nn,:)=fast_state_AS;
    % 
    [two_state_model_output_G,slow_state_G,fast_state_G]=two_state_model_simulation_15_10_14(A,B,Q,R,F_gradual,wash_period_gradual);
    Gradual_output(nn,:)=two_state_model_output_G;
    Gradual_slow(nn,:)=slow_state_G;
    Gradual_fast(nn,:)=fast_state_G;
end

% run comparision between cases
Abrupt_short_late_wash=Abrupt_short_output(:,end-9:end);
Abrupt_long_late_wash=Abrupt_long_output(:,end-9:end);
Gradual_late_wash=Gradual_output(:,end-9:end);
%
data_late_wash_all={Abrupt_short_late_wash(:),Abrupt_long_late_wash(:),Gradual_late_wash(:)};
%
fit_data_late_wash_ave_all=cellfun(@nanmean,data_late_wash_all);
%
fit_data_late_wash_sd_all=cellfun(@nanstd,data_late_wash_all);
%
[h_matrix_fit_late_wash_all,p_matrix_fit_late_wash_all]=calculate_t_test_for_subject_data_13_07_14(data_late_wash_all);
%% Normalized%%
Abrupt_short_late_wash_norm=Abrupt_short_output(:,end-9:end)'/diag(Abrupt_short_output(:,end-59));
Abrupt_long_late_wash_norm=Abrupt_long_output(:,end-9:end)'/diag(Abrupt_long_output(:,end-59));
Gradual_late_wash_norm=Gradual_output(:,end-9:end)'/diag(Gradual_output(:,end-59));
%
data_late_wash_all_norm={Abrupt_short_late_wash_norm(:),Abrupt_long_late_wash_norm(:),Gradual_late_wash_norm(:)};
%
fit_data_late_wash_ave_all_norm=cellfun(@nanmean,data_late_wash_all_norm);
%
fit_data_late_wash_sd_all_norm=cellfun(@nanstd,data_late_wash_all_norm);
%
[h_matrix_fit_late_wash_all_norm,p_matrix_fit_late_wash_all_norm]=calculate_t_test_for_subject_data_13_07_14(data_late_wash_all_norm);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
figure(10);
%subplot('position',[.6,.65,.25,.2])
%
washout_trial=[1:60];

Display_single_adaptation_normalize_11_7_14(mean(Abrupt_short_output)',1,[1:length(mean(Abrupt_short_output))],abrupt_short_adapt_color,'off',curve_width,'-');
Display_single_adaptation_normalize_11_7_14(mean(Abrupt_long_output)',1,[1:length(mean(Abrupt_long_output))],abrupt_long_adapt_color,'off',curve_width,'-');
Display_single_adaptation_normalize_11_7_14(mean(Gradual_output)',1,[1:length(mean(Gradual_output))],gradual_adapt_color,'off',curve_width,'-');
% 
% standard_error_shading_11_07_14(-mean(Abrupt_short_output)',std(Abrupt_short_output)',[1:length(mean(Abrupt_short_output))],2,abrupt_short_adapt_shade);
% standard_error_shading_11_07_14(-mean(Abrupt_long_output)',std(Abrupt_long_output)',[1:length(mean(Abrupt_long_output))],2,abrupt_long_adapt_shade);
% standard_error_shading_11_07_14(-mean(Gradual_output)',std(Gradual_output)',[1:length(mean(Gradual_output))],2,gradual_adapt_shade);

figure(110);
Display_single_adaptation_normalize_11_7_14(mean(Abrupt_short_output(:,end-59:end))',1,[1:60],abrupt_short_adapt_color,'off',curve_width,'-');
Display_single_adaptation_normalize_11_7_14(mean(Abrupt_long_output(:,end-59:end))',1,[1:60],abrupt_long_adapt_color,'off',curve_width,'-');
Display_single_adaptation_normalize_11_7_14(mean(Gradual_output(:,end-59:end))',1,[1:60],gradual_adapt_color,'off',curve_width,'-');


% standard_error_shading_11_07_14(-mean(Abrupt_short_output(:,end-59:end))',std(Abrupt_short_output(:,end-59:end))',[1:60],2,abrupt_short_adapt_shade);
% standard_error_shading_11_07_14(-mean(Abrupt_long_output(:,end-59:end))',std(Abrupt_long_output(:,end-59:end))',[1:60],2,abrupt_long_adapt_shade);
% standard_error_shading_11_07_14(-mean(Gradual_output(:,end-59:end))',std(Gradual_output(:,end-59:end))',[1:60],2,gradual_adapt_shade);
%
o1=plot([0,60],[0,0],'k--','lineWidth',.5);
hg=get(o1,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');
%
%
h4=area([washout_trial(end-window_length),washout_trial(end)],[1.2,1.2],'linestyle','none','facecolor',late_wash_shade,'basevalue',-.2);
hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');
%
text(washout_trial(end-floor(window_length/2)),-0.05,'L','VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
%
set(gca,'FontSize',8,'xtick',[0,10:10:60],'ytick',y,'xlim',[0,61],'ylim',[-0.2,1.01],'layer','top');
xlabel('Trial Number (Unlearing Period)','FontSize',8,'FontWeight','normal','Color','k');
ylabel('Adaptation Coefficient','FontSize',8,'FontWeight','normal','Color','k');
leg=legend('show','location','northeast');set(leg,'FontSize',8)
title('Unnormalized Decay Curves','Fontsize',12);
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% subplot('position',[.86,.65,.12,.2])
figure;
% fit_early_adapt_mid_wash_norm_ave=[fit_data_early_wash_ave_all',fit_data_mid_wash_ave_all'];
% fit_early_adapt_mid_wash_norm_se=[fit_data_early_wash_sd_all',fit_data_mid_wash_sd_all'];
% x=[.25 .75;.25 .75;.25 .75];
% Training_sequence={'abrupt short','abrupt long','gradual'};
% Training_color_seq=[abrupt_short_adapt_color;abrupt_long_adapt_color;gradual_adapt_color];
% plot_bar_with_error_27_01_15(x',fit_early_adapt_mid_wash_norm_ave',fit_early_adapt_mid_wash_norm_se',Training_sequence,Training_color_seq,h_matrix_fit_early_wash_all,h_matrix_fit_mid_wash_all);
%
fit_late_wash_ave=[[nan,nan,nan]',fit_data_late_wash_ave_all'];
fit_late_wash_se=[[nan,nan,nan]',fit_data_late_wash_sd_all'];
x=[.75 1.25;.75 1.25;.75 1.25];
Training_sequence={'abrupt short','abrupt long','gradual'};
Training_color_seq=[abrupt_short_adapt_color;abrupt_long_adapt_color;gradual_adapt_color];
plot_bar_with_error_27_01_15(x',fit_late_wash_ave',fit_late_wash_se',Training_sequence,Training_color_seq,zeros(3),h_matrix_fit_late_wash_all);

%
% h4=area([0,.5],[1.01,1.01],'linestyle','none','facecolor',early_wash_shade,'basevalue',-.2);
% hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');
% %
% h4=area([.5,1],[1.01,1.01],'linestyle','none','facecolor',mid_wash_shade,'basevalue',-.2);
% hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');
%
h4=area([1,1.5],[1.01,1.01],'linestyle','none','facecolor',late_wash_shade,'basevalue',0);
hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');

% text(0.25,-0.05,'E','VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
% text(0.75,-0.05,'M','VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
%text(1.25,-0.05,'L','VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
%
% set(gca,'FontSize',8,'ytick',y,'yticklabel','','xtick',[0.25,0.75,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[-0.2,1.01],'layer','top','box','off');
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,0.75,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[-0.2,1.01],'layer','top','box','off');
title('Unnormalized Decay in late period','Fontsize',12);
%% Normalized %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% subplot('position',[.6,.15,.25,.2])
%
figure(111);
washout_trial=[1:60];
Display_single_adaptation_normalize_11_7_14(mean((Abrupt_short_output(:,end-59:end)'/diag(Abrupt_short_output(:,end-59))')')',1,[1:60],abrupt_short_adapt_color,'off',curve_width,'-');
Display_single_adaptation_normalize_11_7_14(mean((Abrupt_long_output(:,end-59:end)'/diag(Abrupt_long_output(:,end-59))')')',1,[1:60],abrupt_long_adapt_color,'off',curve_width,'-');
Display_single_adaptation_normalize_11_7_14(mean((Gradual_output(:,end-59:end)'/diag(Gradual_output(:,end-59))')')',1,[1:60],gradual_adapt_color,'off',curve_width,'-');
% display_fit_data 

% standard_error_shading_11_07_14(-mean((Abrupt_short_output(:,end-59:end)'/diag(Abrupt_short_output(:,end-59))')'),...
%     std((Abrupt_short_output(:,end-59:end)'/diag(Abrupt_short_output(:,end-59))')'),[1:60],2,abrupt_short_adapt_shade);
% standard_error_shading_11_07_14(-mean((Abrupt_long_output(:,end-59:end)'/diag(Abrupt_long_output(:,end-59))')'),...
%     std((Abrupt_long_output(:,end-59:end)'/diag(Abrupt_long_output(:,end-59))')'),[1:60],2,abrupt_long_adapt_shade);
% standard_error_shading_11_07_14(-mean((Gradual_output(:,end-59:end)'/diag(Gradual_output(:,end-59))')'),...
%     std((Gradual_output(:,end-59:end)'/diag(Gradual_output(:,end-59))')')',[1:60],2,gradual_adapt_shade);
%

o1=plot([0,60],[0,0],'k--','lineWidth',.5);
hg=get(o1,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');
%
%
h4=area([washout_trial(end-window_length),washout_trial(end)],[1.2,1.2],'linestyle','none','facecolor',late_wash_shade,'basevalue',-.2);
hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');
%
text(washout_trial(end-floor(window_length/2)),-0.05,'L','VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
%
set(gca,'FontSize',8,'xtick',[0,10:10:60],'ytick',y,'xlim',[0,61],'ylim',[-0.2,1.01],'layer','top');
xlabel('Trial Number (Unlearing Period)','FontSize',8,'FontWeight','normal','Color','k');
ylabel('Adaptation Coefficient','FontSize',8,'FontWeight','normal','Color','k');
leg=legend('show','location','northeast');set(leg,'FontSize',8)
title('Normalized Decay Curves','Fontsize',12);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
fit_late_wash_ave=[[nan,nan,nan]',fit_data_late_wash_ave_all_norm'];
fit_late_wash_se=[[nan,nan,nan]',fit_data_late_wash_sd_all_norm'];
x=[.75 1.25;.75 1.25;.75 1.25];
Training_sequence={'abrupt short','abrupt long','gradual'};
Training_color_seq=[abrupt_short_adapt_color;abrupt_long_adapt_color;gradual_adapt_color];
plot_bar_with_error_27_01_15(x',fit_late_wash_ave',fit_late_wash_se',Training_sequence,Training_color_seq,zeros(3),h_matrix_fit_late_wash_all_norm);

%
%
% h4=area([0,.5],[1.01,1.01],'linestyle','none','facecolor',early_wash_shade,'basevalue',-.2);
% hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');
% %
% h4=area([.5,1],[1.01,1.01],'linestyle','none','facecolor',mid_wash_shade,'basevalue',-.2);
% hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');
%
h4=area([1,1.5],[1.01,1.01],'linestyle','none','facecolor',late_wash_shade,'basevalue',0);
hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');

% text(0.25,-0.05,'E','VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
% text(0.75,-0.05,'M','VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
%text(1.25,-0.05,'L','VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
%
% set(gca,'FontSize',8,'ytick',y,'yticklabel','','xtick',[0.25,0.75,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[-0.2,1.01],'layer','top','box','off');
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,0.75,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[-0.2,1.01],'layer','top','box','off');
title('Normalized Decay in late period','Fontsize',12);