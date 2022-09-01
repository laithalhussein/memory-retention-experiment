close all;
clear all;



load pret_sub; load vret_sub;
early=1:10;
late = 21:30;
early = late;

%window velocity data
vret_sub.al = window_as(vret_sub.al');
vret_sub.as = window_as(vret_sub.as');
vret_sub.gl = window_as(vret_sub.gl');

vret_sub.al = vret_sub.al';
vret_sub.gl = vret_sub.gl';
vret_sub.as = vret_sub.as';

alp = nanmean(pret_sub.al(early,:),1); glp = nanmean(pret_sub.gl(early,:),1); asp = nanmean(pret_sub.as(early,:),1);
alv = nanmean(vret_sub.al(early,:),1); glv = nanmean(vret_sub.gl(early,:),1); asv = nanmean(vret_sub.as(early,:),1);

alp_ave = nanmean(alp); alp_std = std(alp);
glp_ave = nanmean(glp); glp_std = std(glp);
als_ave = nanmean(asp); asp_std = std(asp);

alv_ave = nanmean(alv); alv_std = std(alv);
glv_ave = nanmean(glv); glv_std = std(glv);
asv_ave = nanmean(asv); asv_std = std(asv);

p_early_ave = [alp_ave,glp_ave,als_ave]; p_early_std = [alp_std,glp_std,asp_std];
v_early_ave = [alv_ave,glv_ave,asv_ave]; v_early_std = [alv_std,glv_std,asv_std];

trials = [1:2:60]';

%% %%some stats
%position
% [p,h,~,stats] = ttest2(alp,glp)
% 
% [p,h,~,stats] = ttest2(alp,asp)
% 
% [p,h,~,stats] = ttest2(glp,asp)

%velocity
[p,h,~,stats] = ttest2(alv,glv)

[p,h,~,stats] = ttest2(alv,asv)

[p,h,~,stats] = ttest2(glv,asv)



%%%%%


%% 
abrupt_short_adapt_color=[0,0,256]/256;
abrupt_long_adapt_color=[256,0,0]/256;
gradual_adapt_color=[0,256,0]/256;

h_dummy=zeros(3,3);
y=0:0.2:1;

% vret_ave = [0.5735, 0.5528, 0.3698] *100; vret_se = [0.2033, 0.226, 0.28] *100;
% 
% pret_ave = [0.5926, 0.6248, 0.3776]*100; pret_se = [0.2225, 0.2153, 0.2726]*100;

figure;

time_const=[[nan,nan,nan]',p_early_ave'];
p_early_se=[[nan,nan,nan]',p_early_std'*14.^-.5];
% time_const=[[nan,nan,nan]',v_early_ave'];
% time_const_se=[[nan,nan,nan]',v_early_std'*8.^-.5];
x=[.75 1.25;.75 1.25;.75 1.25];
Training_sequence={'abrupt long','gradual','abrupt short'};
Training_color_seq=[abrupt_long_adapt_color;gradual_adapt_color;abrupt_short_adapt_color];
plot_bar_with_error_27_01_15(x',time_const',p_early_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);

%
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,0.75,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('pFF Early Period (1-20)','Fontsize',12);





%%

figure;


time_const=[[nan,nan,nan]',v_early_ave'];
p_early_se=[[nan,nan,nan]',v_early_std'*24.^-.5];
x=[.75 1.25;.75 1.25;.75 1.25];
Training_sequence={'abrupt long','gradual','abrupt short'};
Training_color_seq=[abrupt_long_adapt_color;gradual_adapt_color;abrupt_short_adapt_color];
plot_bar_with_error_27_01_15(x',time_const',p_early_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);

%
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,0.75,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('vFF Early Period (1-20)','Fontsize',12);

%%

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




%% time constans
iter=2000;
% [tau_boot_pal,const_boot_pal]=perform_bootstrap_on_data_timeconst_5_30_16(pret_sub.al',iter);
% [tau_boot_pgl,const_boot_pgl]=perform_bootstrap_on_data_timeconst_5_30_16(pret_sub.gl',iter);
% [tau_boot_pas,const_boot_pas]=perform_bootstrap_on_data_timeconst_5_30_16(pret_sub.as',iter);
% 
% [tau_boot_val,const_boot_val]=perform_bootstrap_on_data_timeconst_5_30_16(vret_sub.al',iter);
% [tau_boot_vgl,const_boot_vgl]=perform_bootstrap_on_data_timeconst_5_30_16(vret_sub.gl',iter);
% [tau_boot_vas,const_boot_vas]=perform_bootstrap_on_data_timeconst_5_30_16(vret_sub.as',iter);
% 
% save('tau_3_23.mat','tau_boot_pal', 'tau_boot_pal', 'tau_boot_pgl', 'tau_boot_pas', 'tau_boot_val', 'tau_boot_vgl','tau_boot_vas');

% tau_boot_pal= bootstrp(iter,@calculate_exp_fit_for_data_5_30_16,trials,nanmean(pret_sub.al,2));
% tau_boot_pas= bootstrp(iter,@calculate_exp_fit_for_data_5_30_16,trials,nanmean(pret_sub.as,2));
% tau_boot_pgl = bootstrp(iter,@calculate_exp_fit_for_data_5_30_16,trials,nanmean(pret_sub.gl,2));
% 
% tau_boot_val = bootstrp(iter,@calculate_exp_fit_for_data_5_30_16,trials,nanmean(vret_sub.al,2));
% tau_boot_vas = bootstrp(iter,@calculate_exp_fit_for_data_5_30_16,trials,nanmean(vret_sub.as,2));
% tau_boot_vgl = bootstrp(iter,@calculate_exp_fit_for_data_5_30_16,trials,nanmean(vret_sub.gl,2));
% 
% %velocity
% [h,p] = ttest2(tau_boot_val,tau_boot_vas)
% [h,p] = ttest2(tau_boot_vgl,tau_boot_vas)
% [h,p] = ttest2(tau_boot_vgl,tau_boot_val)
% 
% %position
% [h,p] = ttest2(tau_boot_pal,tau_boot_pas)
% [h,p] = ttest2(tau_boot_pgl,tau_boot_pas)
% [h,p] = ttest2(tau_boot_pgl,tau_boot_pal)

%%
close all;
% load('tau_3_11.mat');
% p_tau_ave = [mean(tau_boot_pal), mean(tau_boot_pgl), mean(tau_boot_pas)]; 
% p_tau_se = [std(tau_boot_pal), std(tau_boot_pgl), std(tau_boot_pas)];
% % 
% v_tau_ave = [mean(tau_boot_val), mean(tau_boot_vgl), mean(tau_boot_vas)]; 
% v_tau_se = [std(tau_boot_val), std(tau_boot_vgl), std(tau_boot_vas)];
% 
p_tau_ave = [11.16, 9.87, 6.5]; 
p_tau_se = [1.89,1.65, 0.95] * 14^-0.5;

v_tau_ave = [10.72, 11.87, 6.77]; 
v_tau_se = [1.41, 1.89, 1.05] * 8^-0.5;


y=0:2:16;

figure;


time_const=[[nan,nan,nan]',p_tau_ave'];
p_early_se=[[nan,nan,nan]',p_tau_se'];
x=[.75 1.25;.75 1.25;.75 1.25];
Training_sequence={'abrupt long','gradual','abrupt short'};
Training_color_seq=[abrupt_long_adapt_color;gradual_adapt_color;abrupt_short_adapt_color];
plot_bar_with_error_27_01_15(x',time_const',p_early_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);

%
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,0.75,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,16],'layer','top','box','off');
title('pFF tau','Fontsize',12);



figure;


time_const=[[nan,nan,nan]',v_tau_ave'];
p_early_se=[[nan,nan,nan]',v_tau_se'];
x=[.75 1.25;.75 1.25;.75 1.25];
Training_sequence={'abrupt long','gradual','abrupt short'};
Training_color_seq=[abrupt_long_adapt_color;gradual_adapt_color;abrupt_short_adapt_color];
plot_bar_with_error_27_01_15(x',time_const',p_early_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);

%
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,0.75,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,16],'layer','top','box','off');
title('vFF tau','Fontsize',12);


%% Individual subject time constant
%close all;

alv_tau = zeros(1,8);
asv_tau = alv_tau;
glv_tau = alv_tau;

alp_tau = zeros(1,14);
asp_tau = alv_tau;
glp_tau = zeros(1,13);
glp_tau(14) = NaN;


% for i=1:24,
%     
%    [alv_tau(i),~] = calculate_exp_fit_for_data_5_30_16(trials,vret_sub.al(:,i));
%    [asv_tau(i),~] = calculate_exp_fit_for_data_5_30_16(trials,vret_sub.as(:,i));
%    [glv_tau(i),~] = calculate_exp_fit_for_data_5_30_16(trials,vret_sub.gl(:,i));
%    
%    if i<=14
%    [alp_tau(i),~] = calculate_exp_fit_for_data_5_30_16(trials,pret_sub.al(:,i));
%    [asp_tau(i),~] = calculate_exp_fit_for_data_5_30_16(trials,pret_sub.as(:,i));
%    end
%    if i<=13
%    [glp_tau(i),~] = calculate_exp_fit_for_data_5_30_16(trials,pret_sub.gl(:,i));
%    end
%     
% end

load pff_gl_all;
load pff_al_all;
load pff_as_all;

load GL_all;
load AL_all;
load AS_all;

AL_all = window_as(AL_all);
AS_all = window_as(AS_all);
GL_all = window_as(GL_all);

for i=1:14
    if i<=8
        [alv_tau(i)] = calculate_exp_fit_for_data_5_30_16(trials,AL_all(i,13:end)');
        [asv_tau(i)] = calculate_exp_fit_for_data_5_30_16(trials,AS_all(i,13:end)');
        [glv_tau(i)] = calculate_exp_fit_for_data_5_30_16(trials,GL_all(i,13:end)');
    end
    
    if i<=14
        [alp_tau(i)] = calculate_exp_fit_for_data_5_30_16(trials,pff_al_all(i,14:end)');
        [asp_tau(i)] = calculate_exp_fit_for_data_5_30_16(trials,pff_as_all(i,14:end)');
    end
    
    if i<=13
        [glp_tau(i)] = calculate_exp_fit_for_data_5_30_16(trials,pff_gl_all(i,14:end)');
    end
    
end


p_tau_ave = [nanmean(alp_tau), nanmean(glp_tau),nanmean(asp_tau)];
p_tau_se = [std(alp_tau), std(glp_tau),std(asp_tau)] * (14^-0.5);

v_tau_ave = [nanmean(alv_tau), nanmean(glv_tau),nanmean(asv_tau)];
v_tau_se = [std(alv_tau), std(glv_tau),std(asv_tau)] * (24^-0.5);

y=0:2:10;

figure;


time_const=[[nan,nan,nan]',p_tau_ave'];
p_early_se=[[nan,nan,nan]',p_tau_se'];
x=[.75 1.25;.75 1.25;.75 1.25];
Training_sequence={'abrupt long','gradual','abrupt short'};
Training_color_seq=[abrupt_long_adapt_color;gradual_adapt_color;abrupt_short_adapt_color];
plot_bar_with_error_27_01_15(x',time_const',p_early_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);

%
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,0.75,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,10],'layer','top','box','off');
title('pFF tau','Fontsize',12);


figure;


time_const=[[nan,nan,nan]',v_tau_ave'];
p_early_se=[[nan,nan,nan]',v_tau_se'];
x=[.75 1.25;.75 1.25;.75 1.25];
Training_sequence={'abrupt long','gradual','abrupt short'};
Training_color_seq=[abrupt_long_adapt_color;gradual_adapt_color;abrupt_short_adapt_color];
plot_bar_with_error_27_01_15(x',time_const',p_early_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);

%
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,0.75,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,10],'layer','top','box','off');
title('vFF tau','Fontsize',12);



%velocity
[h,p,~,stats] = ttest2(alv_tau,asv_tau)
[h,p,~,stats] = ttest2(glv_tau,asv_tau)
[h,p,~,stats] = ttest2(alv_tau,glv_tau)

%position
[h,p,~,stats] = ttest2(alp_tau,asp_tau)
[h,p,~,stats] = ttest2(glp_tau,asp_tau)
[h,p,~,stats] = ttest2(glp_tau,alp_tau)

dummy=1;

% %% matching analysis
% close all;
% load GL_all;
% load AL_all;
% load AS_all;
% 
% AL_all = window_as(AL_all);
% AS_all = window_as(AS_all);
% 
% early=1:10;
% late = 20:30;
% trials=1:2:60;
% 
% f_idx = 12; %final learning indices
% 
% for i=1:8
%     
% %    fl_gl(i) = nanmean( GL_all(i,f_idx));
% %    fde_gl(i) = nanmean( GL_all(i, early));
% %    fdl_gl(i) = nanmean( GL_all(i, late));
% 
%    fl_al(i) = nanmean( AL_all(i,f_idx));
%    fde_al(i) = nanmean( AL_all(i, early));
%    fdl_al(i) = nanmean( AL_all(i, late));
%    
%    fl_as(i) = nanmean( AS_all(i,2));
%    fde_as(i) = nanmean( AS_all(i, early));
%    fdl_as(i) = nanmean( AS_all(i, late));
%     
% end
% 
% %figure; hold on;
% nn = 4; %number of subjects to remove
% nq = 4; %number of subjects analyzed
% 
% al_large = sort(fl_al); al_large = al_large(1:nn);
% as_small= sort(fl_as); as_small= as_small(end-nn-1:end);
% 
% al_large_idx = ismember(fl_al,al_large);
% as_small_idx = ismember(fl_as,as_small);
% 
% new_al = AL_all(al_large_idx,:);
% new_as = AS_all(as_small_idx,:);
% 
% new_retention_al_sub = new_al(:,end-29:end);
% new_retention_as_sub = new_as(:,end-29:end);
% 
% 
% retention_al_norm = nanmean(new_retention_al_sub,1); 
% al_norm_factor = retention_al_norm(1);
% retention_al_norm = retention_al_norm/al_norm_factor;
% 
% retention_as_norm = nanmean(new_retention_as_sub,1); 
% as_norm_factor = retention_as_norm(1);
% retention_as_norm = retention_as_norm/as_norm_factor;
% 
% retention_al_sub_norm = new_retention_al_sub ./ ( ones(size(new_retention_al_sub)) * al_norm_factor);
% retention_as_sub_norm = new_retention_as_sub ./ ( ones(size(new_retention_as_sub)) * as_norm_factor);
% 
% for k=1:nq
%     
%    early_retention_ave_sub_al(k) = mean(retention_al_sub_norm(k,early));
%    late_retention_ave_sub_al(k) = mean(retention_al_sub_norm(k,late));
%    
%    early_retention_ave_sub_as(k) = mean(retention_as_sub_norm(k,early));
%    late_retention_ave_sub_as(k) = mean(retention_as_sub_norm(k,late));
% end
% 
% v_early_ave = [mean(early_retention_ave_sub_al), mean(early_retention_ave_sub_as)];
% v_early_std = [std(early_retention_ave_sub_al), std(early_retention_ave_sub_as)];
% 
% v_late_ave = [mean(late_retention_ave_sub_al), mean(late_retention_ave_sub_as)];
% v_late_std = [std(late_retention_ave_sub_al), std(late_retention_ave_sub_as)];
% 
% figure; hold on;
% plot(trials,retention_al_norm,'r');
% plot(trials,retention_as_norm,'b');
% title('matching analysis');
% xlabel('Decay period');
% ylabel('% retention');
% set(gca,'Fontsize',12);
% 
% 
% %Early/late analysis for matching stuff
% abrupt_short_adapt_color=[0,0,256]/256;
% abrupt_long_adapt_color=[256,0,0]/256;
% 
% h_dummy=zeros(2,2);
% y=0:0.2:1;
% 
% figure;
% 
% v_early=[[nan,nan]',v_early_ave'];
% v_early_se=[[nan,nan]',v_early_std'*nq.^-.5];
% x=[.75 1.25;.75 1.25];
% Training_sequence={'abrupt long','abrupt short'};
% Training_color_seq=[abrupt_long_adapt_color;abrupt_short_adapt_color];
% plot_bar_with_error_27_01_15(x',v_early_ave',v_early_se',Training_sequence,Training_color_seq,zeros(2),h_dummy);
% 
% %
% set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
% title('vFF early after matching','Fontsize',12);
% 
% 
% figure;
% 
% 
% time_const=[[nan,nan]',v_late_ave'];
% p_early_se=[[nan,nan]',v_late_std'*nq.^-.5];
% x=[.75 1.25;.75 1.25;.75 1.25];
% Training_sequence={'abrupt long','abrupt short'};
% Training_color_seq=[abrupt_long_adapt_color;abrupt_short_adapt_color];
% plot_bar_with_error_27_01_15(x',time_const',p_early_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
% 
% %
% set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
% title('vFF late after matching','Fontsize',12);
























