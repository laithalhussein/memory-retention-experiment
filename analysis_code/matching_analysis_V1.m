close all; clear all;
load GL_all;
load AL_all;
load AS_all;

AL_all = window_as(AL_all);
AS_all = window_as(AS_all);

early=1:10;
late = 20:30;
trials=1:2:60;

f_idx = 12; %final learning indices

for i=1:8
    
%    fl_gl(i) = nanmean( GL_all(i,f_idx));
%    fde_gl(i) = nanmean( GL_all(i, early));
%    fdl_gl(i) = nanmean( GL_all(i, late));

   fl_al(i) = nanmean( AL_all(i,f_idx));
   fde_al(i) = nanmean( AL_all(i, early));
   fdl_al(i) = nanmean( AL_all(i, late));
   
   fl_as(i) = nanmean( AS_all(i,2));
   fde_as(i) = nanmean( AS_all(i, early));
   fdl_as(i) = nanmean( AS_all(i, late));
    
end

%figure; hold on;
nn = 4; %number of subjects to remove
nq = 4; %number of subjects analyzed

al_large = sort(fl_al); 
al_large = al_large(1:nn);

as_small= sort(fl_as); 
as_small= as_small(end-nn-1:end);

al_large_idx = ismember(fl_al,al_large);
as_small_idx = ismember(fl_as,as_small);

new_al = AL_all(al_large_idx,:);
new_as = AS_all(as_small_idx,:);

new_retention_al_sub = new_al(:,end-29:end);
new_retention_as_sub = new_as(:,end-29:end);


retention_al_norm = nanmean(new_retention_al_sub,1); 
al_norm_factor = retention_al_norm(1);
retention_al_norm = retention_al_norm/al_norm_factor;

retention_as_norm = nanmean(new_retention_as_sub,1); 
as_norm_factor = retention_as_norm(1);
retention_as_norm = retention_as_norm/as_norm_factor;

retention_al_sub_norm = new_retention_al_sub ./ ( ones(size(new_retention_al_sub)) * al_norm_factor);
retention_as_sub_norm = new_retention_as_sub ./ ( ones(size(new_retention_as_sub)) * as_norm_factor);

for k=1:nq
    
   early_retention_ave_sub_al(k) = mean(retention_al_sub_norm(k,early));
   late_retention_ave_sub_al(k) = mean(retention_al_sub_norm(k,late));
   
   early_retention_ave_sub_as(k) = mean(retention_as_sub_norm(k,early));
   late_retention_ave_sub_as(k) = mean(retention_as_sub_norm(k,late));
end

v_early_ave = [mean(early_retention_ave_sub_al), mean(early_retention_ave_sub_as)];
v_early_std = [std(early_retention_ave_sub_al), std(early_retention_ave_sub_as)];

v_late_ave = [mean(late_retention_ave_sub_al), mean(late_retention_ave_sub_as)];
v_late_std = [std(late_retention_ave_sub_al), std(late_retention_ave_sub_as)];

figure; hold on;
plot(trials,retention_al_norm,'r');
plot(trials,retention_as_norm,'b');
title('Retention after matching learning');
xlabel('Decay period');
ylabel('% retention');
set(gca,'Fontsize',12);


%Early/late analysis for matching stuff
abrupt_short_adapt_color=[0,0,256]/256;
abrupt_long_adapt_color=[256,0,0]/256;

h_dummy=zeros(2,2);
y=0:0.2:1;

figure;

v_early=[[nan,nan]',v_early_ave'];
v_early_se=[[nan,nan]',v_early_std'*nq.^-.5];
x=[.75 1.25;.75 1.25];
Training_sequence={'abrupt long','abrupt short'};
Training_color_seq=[abrupt_long_adapt_color;abrupt_short_adapt_color];
plot_bar_with_error_27_01_15(x',v_early',v_early_se',Training_sequence,Training_color_seq,zeros(2),h_dummy);

%
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('vFF early after matching','Fontsize',12);
ylabel('% retention');


figure;

v_late=[[nan,nan]',v_late_ave'];
v_late_se=[[nan,nan]',v_late_std'*nq.^-.5];
x=[.75 1.25;.75 1.25];
Training_sequence={'abrupt long','abrupt short'};
Training_color_seq=[abrupt_long_adapt_color;abrupt_short_adapt_color];
plot_bar_with_error_27_01_15(x',v_late',v_late_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);

set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('vFF late after matching','Fontsize',12);
ylabel('% retention');

%do final learning as well
fl_ave = [mean(al_large), mean(as_small)];
fl_ave = [[nan,nan]',fl_ave'];
fl_se = [std(al_large), std(as_small)] * 4^-0.5;
fl_se = [[nan,nan]',fl_se'];
figure;
plot_bar_with_error_27_01_15(x',fl_ave',fl_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);

%
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('Final learning level after matching (vFF)','Fontsize',12);
ylabel('AC');

%now look at p-values
%p values comparing final adaptation between AL and AS
[~, p_learning] = ttest2(al_large, as_small)

%p values for early period
[~, p_early] = ttest2(early_retention_ave_sub_al, early_retention_ave_sub_as)

%p-values for late
[~, p_late] = ttest2(late_retention_ave_sub_al, late_retention_ave_sub_as)

%% repeat everything for position
%close all; 
clear all;
abrupt_short_adapt_color=[0,0,256]/256;
abrupt_long_adapt_color=[256,0,0]/256;

load('pff_al_all_new.mat');
load('pff_as_all_new.mat');
pal = pff_al_all_new;
pas = pff_as_all_new;

al_learning = pal(:,13);
as_learning = pas(:,3);

al_srt = sort(al_learning);
as_srt = sort(as_learning);
%take care of nan before cumsum 
as_srt(isnan(as_srt)) =0;

figure; hold on;
plot([cumsum(flipud(as_srt))./[1:14]',cumsum(al_srt)./[1:14]'],'-o'); %corresponds to 11
% plot([cumsum(flipud(as_srt))./[1:14]'],'-o');

nq = 14-2;
%nn = 14-nq;
al_match = al_srt(1:nq);
as_match = as_srt(end-nq:end);

%nanmean(al_match) - nanmean(as_match)

[~,p_pAL] = ttest2(al_match, as_match) 

figure;
h_dummy=zeros(2,2);
y=0:0.2:1;

pfl_ave=[[nan,nan]',[nanmean(al_match),nanmean(as_match)]'];
pfl_se=[[nan,nan]',[ nanstd(al_match), nanstd(as_match)]' * nq^-0.5];
x=[.75 1.25;.75 1.25];
Training_sequence={'abrupt long','abrupt short'};
Training_color_seq=[abrupt_long_adapt_color;abrupt_short_adapt_color];
plot_bar_with_error_27_01_15(x',pfl_ave',pfl_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);

set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('Final learning after matching (pFF)','Fontsize',12);
ylabel('AC');

%now do the bar graphs for early and late
pal_idx = ismember(al_match, al_srt);
pas_idx = ismember(as_match, as_srt);

new_pal = pal(pal_idx, :);
new_pas = pas(pas_idx,:);

%calculate % retention
retention_pal_sub = new_pal(:, end-29:end);
retention_pas_sub = new_pas(:, end-29:end);

ret_pal_ave = nanmean(retention_pal_sub,1);
ret_pas_ave = nanmean(retention_pal_sub,1);

pal_norm_factor = ret_pal_ave(1);
pas_norm_factor = ret_pas_ave(1);

pal_ret_norm_sub = retention_pal_sub * (eye(30) / pal_norm_factor);
pas_ret_norm_sub = retention_pas_sub * (eye(30) / pas_norm_factor);

early=1:10;
late = 20:30;
trials=1:2:60;

pal_early_sub = pal_ret_norm_sub(:,early);
pal_early = nanmean(pal_early_sub,1);
pas_early_sub = pas_ret_norm_sub(:,early);
pas_early = nanmean(pas_early_sub,1);

pal_late_sub = pal_ret_norm_sub(:,late);
pal_late = nanmean(pal_late_sub,1);
pas_late_sub = pas_ret_norm_sub(:,late);
pas_late = nanmean(pas_late_sub,1);

p_early_ave = [[nan,nan]',[nanmean(pal_early), nanmean(pas_early)]'];
p_early_se = [[nan,nan]',[std(pal_early), std(pas_early)]' * nq^-0.5];

p_late_ave = [[nan,nan]',[nanmean(pal_late), nanmean(pas_late)]'];
p_late_se = [[nan,nan]',[std(pal_late), std(pas_late)]' * nq^-0.5];

%early
figure;
plot_bar_with_error_27_01_15(x',p_early_ave',p_early_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('pFF early after matching','Fontsize',12);
ylabel('% retention');

%late
figure;
plot_bar_with_error_27_01_15(x',p_late_ave',p_late_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('pFF late after matching','Fontsize',12);
ylabel('% retention');


[~,p_pEarly] = ttest2(pal_early,pas_early)
[~,p_pLate] = ttest2(pal_late,pas_late)














































