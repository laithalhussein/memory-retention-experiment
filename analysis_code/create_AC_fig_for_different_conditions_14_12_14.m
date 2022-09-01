clear all 
close all 

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


abrupt_shorts=strfind(MT_info_all.FF_schedule,'AS');
abrupt_shorts=(1-cellfun(@isempty,abrupt_shorts));
graduals=strfind(MT_info_all.FF_schedule,'GL');
graduals=(1-cellfun(@isempty,graduals));
abrupt_longs=strfind(MT_info_all.FF_schedule,'AL');
abrupt_longs=(1-cellfun(@isempty,abrupt_longs));
FF_in_90_direction=MT_info_all.test_directions==90;
FF_in_270_direction=MT_info_all.test_directions==270;
% 
% calculate subject vector
% sub_w_grad_in_270=find(sum(graduals.*FF_in_270_direction,2));
% sub_w_abrupt_short_in_270=find(sum(abrupt_shorts.*FF_in_270_direction,2));
% sub_w_abrupt_long_in_270=find(sum(abrupt_longs.*FF_in_270_direction,2));
% % all subjects
% 
% % 
% create_AC_fig_multiple_training_for_diff_conditions_14_12_14(2,sub_w_abrupt_short_in_270,sub_w_abrupt_long_in_270,sub_w_grad_in_270)
% 
% 
% 
% 
% print -depsc2 -painters -cmyk AC_compare_for_270_fig_14_12_14.eps
% % pdf printing 
% set(gcf, 'PaperPosition', [.5 .5 5.5 6.5]);
% print -dpdf -cmyk -painters AC_compare_for_270_fig_14_12_14.pdf
%%
sub_w_grad=[1:24];
sub_w_abrupt_short=[1:24];
sub_w_abrupt_long=[1:24];
% all subjects

% 
[v_AL,V_GL]=create_AC_fig_multiple_training_for_diff_conditions_14_12_14_LB(2,sub_w_abrupt_short,sub_w_abrupt_long,sub_w_grad)




print -depsc2 -painters -cmyk AC_compare_for_all_fig_20_01_15.eps
% pdf printing 
set(gcf, 'PaperPosition', [.5 .5 5.5 6.5]);
print -dpdf -cmyk -painters AC_vff_6_11.pdf



