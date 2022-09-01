figure;
 subplot('position',[.36,.25,.12,.2])
trials_decay=[1:2:59];

ave_velocity_fit_gradual_sub_wash_temp=ave_velocity_fit_gradual_sub_wash(2:end);
ave_velocity_fit_abrupt_long_sub_wash_temp=ave_velocity_fit_abrupt_long_sub_wash(2:end);
ave_velocity_fit_abrupt_short_sub_wash_temp=ave_velocity_fit_abrupt_short_sub_wash(2:end);

Display_single_adaptation_11_07_14(ave_velocity_fit_abrupt_short_sub_wash_temp,trials_decay,abrupt_short_adapt_color,'off',curve_width,'-');
Display_single_adaptation_11_07_14(ave_velocity_fit_abrupt_long_sub_wash_temp,trials_decay,abrupt_long_adapt_color,'off',curve_width,'-');
Display_single_adaptation_11_07_14(ave_velocity_fit_gradual_sub_wash_temp,trials_decay,gradual_adapt_color,'off',curve_width,'-');
% add SE shades 
% baseline
standard_error_shading_11_07_14(-ave_velocity_fit_abrupt_short_sub_wash_temp,sd_velocity_fit_abrupt_short_sub_wash(2:end),trials_decay,MT_num_of_subjects,abrupt_short_adapt_shade);
standard_error_shading_11_07_14(-ave_velocity_fit_abrupt_long_sub_wash_temp,sd_velocity_fit_abrupt_long_sub_wash(2:end),trials_decay,MT_num_of_subjects,abrupt_long_adapt_shade);
standard_error_shading_11_07_14(-ave_velocity_fit_gradual_sub_wash_temp,sd_velocity_fit_gradual_sub_wash(2:end),trials_decay,MT_num_of_subjects,gradual_adapt_shade);
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
ylabel('Unnormalized Adaptation Coefficient','FontSize',8,'FontWeight','normal','Color','k');
leg=legend('show','location','northeast');set(leg,'FontSize',8)









 subplot('position',[.6,.25,.12,.2])
fit_early_adapt_mid_wash_ave=[fit_data_early_wash_ave_all',fit_data_mid_wash_ave_all'];
fit_early_adapt_mid_wash_se=[fit_data_early_wash_se_all',fit_data_mid_wash_se_all'];
x=[.25 .75;.25 .75;.25 .75];
Training_sequence={'Position','position','position'};
Training_color_seq=[abrupt_short_adapt_color;abrupt_long_adapt_color;gradual_adapt_color];
plot_bar_with_error_11_07_14(x',fit_early_adapt_mid_wash_ave',fit_early_adapt_mid_wash_se',Training_sequence,Training_color_seq,h_matrix_fit_early_wash_all,h_matrix_fit_mid_wash_all);
%
fit_late_wash_ave=[nan*[0,0,0]',fit_data_late_wash_ave_all'];
fit_late_wash_se=[nan*[0,0,0]',fit_data_late_wash_se_all'];
x=[.75 1.25;.75 1.25;.75 1.25];
Training_sequence={'Position','position','position'};
Training_color_seq=[abrupt_short_adapt_color;abrupt_long_adapt_color;gradual_adapt_color];
plot_bar_with_error_11_07_14(x',fit_late_wash_ave',fit_late_wash_se',Training_sequence,Training_color_seq,zeros(3),h_matrix_fit_late_wash_all);


h4=area([0,.5],[1.01,1.01],'linestyle','none','facecolor',early_wash_shade,'basevalue',0);
hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');
%
h4=area([.5,1],[1.01,1.01],'linestyle','none','facecolor',mid_wash_shade,'basevalue',0);
hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');
%
h4=area([1,1.5],[1.01,1.01],'linestyle','none','facecolor',late_wash_shade,'basevalue',0);
hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');
%
text(.25,-0.05,'E','VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
text(.75,-0.05,'M','VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
text(1.25,-0.05,'L','VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
%
set(gca,'FontSize',8,'ytick',y,'yticklabel','','xtick',[0.25,0.75,1.25],'xticklabel','','xlim',[0,1.5],'ylim',[-0.2,1.01],'layer','top','box','off');



set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperSize', [6.25 7.5]);
set(gcf, 'PaperPositionMode', 'manual');

set(gcf, 'PaperPosition', [.5 .5 5.5 6.5]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% annotation('textbox',[0.05,.9,.38,.05],'string','A.','edgecolor','none','color','k'...
%     ,'horizontalalignment','left','verticalalignment','middle','fontsize',10,'fontweight','demi');
% annotation('textbox',[.55,.9,.34,.05],'string','B.','edgecolor','none','color','k'...
%     ,'horizontalalignment','left','verticalalignment','middle','fontsize',10,'fontweight','demi');

print -dpdf -cmyk -painters AC_vff_unnorm_6_11.pdf



