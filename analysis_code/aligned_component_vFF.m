figure(4);
    %Bar graphs of interest   
    
x=[.25 .75;.25 .75];
fit_early_adapt_mid_wash_norm_ave=[aligned_data__abrupt_short_initial_adaptation_equal_wash_ave',[nan,nan]'];
fit_early_adapt_mid_wash_norm_se=[aligned_data__abrupt_short_initial_adaptation_equal_wash_se',[nan,nan]'];

Training_sequence={'abrupt short','abrupt_short'};
Training_color_seq=[abrupt_short_adapt_color;abrupt_short_adapt_color];
plot_bar_with_error_11_07_14(x',fit_early_adapt_mid_wash_norm_ave',fit_early_adapt_mid_wash_norm_se',Training_sequence,Training_color_seq,h_matrix_abrupt_short_initial_adaptation_equal_wash_aligned,zeros(2));
%
x=[.75 1.25;.75 1.25];
fit_early_adapt_mid_wash_norm_ave=[aligned_data__abrupt_long_initial_adaptation_equal_wash_ave',[nan,nan]'];
fit_early_adapt_mid_wash_norm_se=[aligned_data__abrupt_long_initial_adaptation_equal_wash_se',[nan,nan]'];

Training_sequence={'abrupt long','abrupt_long'};
Training_color_seq=[abrupt_long_adapt_color;abrupt_long_adapt_color];
plot_bar_with_error_11_07_14(x',fit_early_adapt_mid_wash_norm_ave',fit_early_adapt_mid_wash_norm_se',Training_sequence,Training_color_seq,h_matrix_abrupt_long_initial_adaptation_equal_wash_aligned,zeros(2));
%
x=[.75 1.25;.75 1.25];
fit_early_adapt_mid_wash_norm_ave=[[nan,nan]',aligned_data__gradual_initial_adaptation_equal_wash_ave'];
fit_early_adapt_mid_wash_norm_se=[[nan,nan]',aligned_data__gradual_initial_adaptation_equal_wash_se'];

Training_sequence={'gradual','gradual'};
Training_color_seq=[gradual_adapt_color;gradual_adapt_color];
plot_bar_with_error_11_07_14(x',fit_early_adapt_mid_wash_norm_ave',fit_early_adapt_mid_wash_norm_se',Training_sequence,Training_color_seq,zeros(2),h_matrix_gradual_initial_adaptation_equal_wash_aligned);


h4=area([0,.5],[1.01,1.01],'linestyle','none','facecolor',early_wash_shade,'basevalue',-.2);
hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');
%
h4=area([.5,1],[1.01,1.01],'linestyle','none','facecolor',mid_wash_shade,'basevalue',-.2);
hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');
%
h4=area([1,1.6],[1.01,1.01],'linestyle','none','facecolor',late_wash_shade,'basevalue',-.2);
hg=get(h4,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h4,'bottom');

text(0.25,-0.05,'AS','VerticalAlignment','top','HorizontalAlignment','center','FontSize',10);
text(0.75,-0.05,'AL','VerticalAlignment','top','HorizontalAlignment','center','FontSize',10);
text(1.25,-0.05,'G','VerticalAlignment','top','HorizontalAlignment','center','FontSize',10);
%
y=[-.2:.2:0.8];
set(gca,'FontSize',12,'ytick',y,'xtick',[0.25,0.75,1.25],'xticklabel','','xlim',[0,1.5],'ylim',[-0.2,.8],'layer','top','box','off');

if goal_aligned_cut < 0.5
    title('Aligned Component (First grey point)','Fontsize',12);
else
    title('Aligned Component (Second grey point)','Fontsize',12);
end



