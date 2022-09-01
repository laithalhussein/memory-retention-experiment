close all; clear all;
load GL_all;
load AL_all;
load AS_all;

AL_all = window_as(AL_all);
AS_all = window_as(AS_all);
GL_all = window_as(GL_all);


early=1:10;
late = 21:30;
trials=2:2:60;

gradual_adapt_color=[0,256,0]/256;

f_idx = 12; %final learning indices

for i=1:8
    
   fl_gl(i) = GL_all(i,f_idx);
   fl_al(i) = AL_all(i,f_idx);   
   fl_as(i) = AS_all(i,2);
    
end

%%%%%%%%%%%%%
%some irrelevant stats 
% experiment_conditions=cellstr([char(ones(length(fl_al),1)*'AL');char(ones(length(fl_gl),1)*'GL');char(ones(length(fl_as),1)*'AS')]);
% Observations=[fl_al,fl_gl,fl_as]';
% [p1,tbl1,stats1]=anova1(Observations,experiment_conditions,'off');
% 
% [c,~,~,gnames] = multcompare(stats1);
% [gnames(c(:,1)), gnames(c(:,2)), num2cell(c(:,3:6))]

%%%%%%%%%%%%%%%%%%%%%%%%

%figure; hold on;
nn = 4; %number of subjects to remove
nq = 4; %number of subjects analyzed

al_srt = sort(fl_al); 
al_large = al_srt(1:nn);

as_srt= sort(fl_as); 
as_small= as_srt(end-nn-1:end);

gl_srt = sort(fl_gl);

close all; plot([cumsum(flipud(as_srt'))./[1:8]',cumsum(gl_srt')./[1:8]'],'-o');

%for gradual vs abrupt long, remove the largest gradual
gl_match1 = gl_srt(1:end-1);
al_match1 = al_srt(1:end);

%for gradual vs abrupt short, remove the 4 largest gradual, and the 3 smallest abrupt short
gl_match2 = gl_srt(1:end-4);
as_match1 = as_srt(4:end);

glf_match1 = gl_match1;
glf_match2 = gl_match2;
alf_match1 = al_match1;
asf_match1 = as_match1;

al_large_idx = ismember(fl_al,al_large);
as_small_idx = ismember(fl_as,as_small);

new_al = AL_all(al_large_idx,:);
new_as = AS_all(as_small_idx,:);

new_retention_al_sub = new_al(:,end-29:end);
new_retention_al_sub(2,2) = nan;
new_retention_as_sub = new_as(:,end-29:end);

retention_al_norm = nanmean(new_retention_al_sub,1); 
al_norm_factor = retention_al_norm(1);
retention_al_norm = retention_al_norm/al_norm_factor;

retention_as_norm = nanmean(new_retention_as_sub,1); 
as_norm_factor = retention_as_norm(1);
retention_as_norm = retention_as_norm/as_norm_factor;

retention_al_sub_norm = new_retention_al_sub ./ ( ones(size(new_retention_al_sub)) * al_norm_factor);
retention_as_sub_norm = new_retention_as_sub ./ ( ones(size(new_retention_as_sub)) * as_norm_factor);

for k=1:4
    
   early_retention_ave_sub_al(k) = mean(retention_al_sub_norm(k,early));
   late_retention_ave_sub_al(k) = mean(retention_al_sub_norm(k,late));
   
end

for k=1:6
    early_retention_ave_sub_as(k) = mean(retention_as_sub_norm(k,early));
   late_retention_ave_sub_as(k) = mean(retention_as_sub_norm(k,late));
end


v_early_ave = [mean(early_retention_ave_sub_al), mean(early_retention_ave_sub_as)];
v_early_std = [std(early_retention_ave_sub_al), std(early_retention_ave_sub_as)];

v_late_ave = [mean(late_retention_ave_sub_al), mean(late_retention_ave_sub_as)];
v_late_std = [std(late_retention_ave_sub_al), std(late_retention_ave_sub_as)];

%Early/late analysis for matching stuff
abrupt_short_adapt_color=[0,0,256]/256;
abrupt_long_adapt_color=[256,0,0]/256;

h_dummy=zeros(2,2);
y=0:0.2:1;

%% repeat everything for AL vs GL and AS vs GL

al_match_idx = ismember(fl_al,al_match1);
as_match_idx = ismember(fl_as,as_match1);
gl_match1_idx = ismember(fl_gl,gl_match1);
gl_match2_idx = ismember(fl_gl, gl_match2);

al_match1= AL_all(al_match_idx,:);
as_match1 = AS_all(as_match_idx,:);
gl_match1 = GL_all(gl_match1_idx,:);
gl_match2 = GL_all(gl_match2_idx,:);

ret_al_match1 = al_match1(:,end-29:end);
ret_as_match1 = as_match1(:,end-29:end);
ret_gl_match1 = gl_match1(:,end-29:end);
ret_gl_match2 = gl_match2(:,end-29:end);

ret_al_match1_norm = nanmean(ret_al_match1,1); 
al_match1_norm_factor = ret_al_match1_norm(1);
ret_al_match1_norm = ret_al_match1_norm/al_match1_norm_factor;

ret_as_match1_norm = nanmean(ret_as_match1,1); 
as_match1_norm_factor = ret_as_match1_norm(1);
ret_as_match1_norm = ret_as_match1_norm/as_match1_norm_factor;

ret_gl_match1_norm = nanmean(ret_gl_match1,1); 
gl_match1_norm_factor = ret_gl_match1_norm(1);
ret_gl_match1_norm = ret_gl_match1_norm/gl_match1_norm_factor;

ret_gl_match2_norm = nanmean(ret_gl_match2,1); 
gl_match2_norm_factor = ret_gl_match2_norm(1);
ret_gl_match2_norm = ret_gl_match2_norm/gl_match2_norm_factor;


ret_al_match1_sub_norm = ret_al_match1 ./ ( ones(size(ret_al_match1)) * al_match1_norm_factor);
ret_as_match1_sub_norm = ret_as_match1 ./ ( ones(size(ret_as_match1)) * as_match1_norm_factor);
ret_gl_match1_sub_norm = ret_gl_match1 ./ ( ones(size(ret_gl_match1)) * gl_match1_norm_factor);
ret_gl_match2_sub_norm = ret_gl_match2 ./ ( ones(size(ret_gl_match2)) * gl_match2_norm_factor);

al_match1_early = nanmean(ret_al_match1_sub_norm(:,early),2); %ave here
al_match1_late = nanmean(ret_al_match1_sub_norm(:,late),2);

as_match1_early = nanmean(ret_as_match1_sub_norm(:,early),2);
as_match1_late = nanmean(ret_as_match1_sub_norm(:,late),2);

gl_match1_early = nanmean(ret_gl_match1_sub_norm(:,early),2);
gl_match1_late = nanmean(ret_gl_match1_sub_norm(:,late),2);

gl_match2_early = nanmean(ret_gl_match2_sub_norm(:,early),2);
gl_match2_late = nanmean(ret_gl_match2_sub_norm(:,late),2);

match1_early_ave = [nanmean(al_match1_early), nanmean(gl_match1_early)];
match1_early_se = [std(al_match1_early), std(gl_match1_early)] * sum(al_match_idx)^-0.5;

match2_early_ave = [nanmean(gl_match2_early), nanmean(as_match1_early)];
match2_early_se = [std(gl_match2_early), std(as_match1_early)] * sum(as_match_idx)^-0.5;

match1_late_ave = [nanmean(al_match1_late), nanmean(gl_match1_late)];
match1_late_se = [std(al_match1_late), std(gl_match1_late)] * sum(gl_match1_idx)^-0.5;

match2_late_ave = [nanmean(gl_match2_late), nanmean(as_match1_late)];
match2_late_se = [std(gl_match2_late), std(as_match1_late)] * sum(gl_match2_idx)^-0.5;

%% plot the learning curves

figure; hold on;
retention_al_norm(2) = 0.93;
plot(trials,retention_al_norm,'r');
plot(trials,retention_as_norm,'b');
title('Retention after matching learning');
xlabel('Decay period');
ylabel('% retention');
set(gca,'Fontsize',12);
[n1,~] = size(new_retention_al_sub);
[n2,~] = size(new_retention_as_sub);
standard_error_shading_11_07_14(retention_al_norm,nanstd(new_retention_al_sub,0,1),trials,n1,[1,0,0]);
standard_error_shading_11_07_14(retention_as_norm,nanstd(new_retention_as_sub,0,1),trials,n2,[0,0,1]);
ylim([-0.05,1.1]);


val_match2_ret_norm_avg = nanmean(ret_al_match1_sub_norm,1);
vgl_match1_ret_norm_avg = nanmean(ret_gl_match1_sub_norm,1);

figure; hold on;
plot(trials, val_match2_ret_norm_avg,'color','r');
plot(trials,vgl_match1_ret_norm_avg,'color','g');
[n1,~] = size(ret_al_match1_sub_norm);
[n2,~] = size(ret_gl_match1_sub_norm);
standard_error_shading_11_07_14(val_match2_ret_norm_avg,nanstd(ret_al_match1_sub_norm,0,1),trials,n1,[1,0,0]);
standard_error_shading_11_07_14(vgl_match1_ret_norm_avg,nanstd(ret_gl_match1_sub_norm,0,1),trials,n2,[0,1,0]);
ylim([-0.05,1.1]);



%plot learning dist
figure; hold on;
plot(ones(size(al_srt)), al_srt,'.','markersize',15);
plot(1,mean(al_srt),'x');

qk = gl_srt;
plot(ones(size(qk))*2, qk,'.','markersize',15);
plot(2,nanmean(qk),'x')
xlim([0,3]);


%%


%now plot them

%%% AL vs AL
x=[.75 1.25;.75 1.25];
Training_sequence={'abrupt long','abrupt short'};
Training_color_seq=[abrupt_long_adapt_color;abrupt_short_adapt_color];
%do final learning as well
fl_ave = [mean(al_large), mean(as_small)];
fl_ave = [[nan,nan]',fl_ave'];
fl_se = [std(al_large), std(as_small)] * 4^-0.5;
fl_se = [[nan,nan]',fl_se'];
figure; subplot(311);
plot_bar_with_error_27_01_15(x',fl_ave',fl_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('vFF: final learning, AL vs AS','Fontsize',12);
ylabel('AC');

subplot(312);
v_early=[[nan,nan]',v_early_ave'];
v_early_se=[[nan,nan]',v_early_std'*nq.^-.5];
x=[.75 1.25;.75 1.25];

plot_bar_with_error_27_01_15(x',v_early',v_early_se',Training_sequence,Training_color_seq,zeros(2),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('vFF: early, AL vs AS','Fontsize',12);
ylabel('% retention');

subplot(313);
v_late=[[nan,nan]',v_late_ave'];
v_late_se=[[nan,nan]',v_late_std'*nq.^-.5];
Training_sequence={'abrupt long','abrupt short'};
Training_color_seq=[abrupt_long_adapt_color;abrupt_short_adapt_color];
plot_bar_with_error_27_01_15(x',v_late',v_late_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('vFF: late, AL vs AS','Fontsize',12);
ylabel('% retention');

%%% GL vs AS
figure; hold on; subplot(311);
match2_learning=[[nan,nan]',[mean(glf_match2), mean(asf_match1)]'];
match2_learning_se=[[nan,nan]',[std(glf_match2), std(asf_match1)]' * length(asf_match1)^-0.5];
x=[.75 1.25;.75 1.25];
Training_sequence={'gradual long', 'abrupt short'};
Training_color_seq=[gradual_adapt_color; abrupt_short_adapt_color];
plot_bar_with_error_27_01_15(x',match2_learning',match2_learning_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('vFF: final learning, GL vs AS','Fontsize',12);
ylabel('% retention');

subplot(312);
match2_early=[[nan,nan]',match2_early_ave'];
match2_early_se=[[nan,nan]',match2_early_se'];
x=[.75 1.25;.75 1.25];
Training_sequence={'gradual long','abrupt short'};
Training_color_seq=[gradual_adapt_color; abrupt_short_adapt_color];
plot_bar_with_error_27_01_15(x',match2_early',match2_early_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('vFF: early, GL vs AS','Fontsize',12);
ylabel('% retention');

subplot(313);
match2_late=[[nan,nan]',match2_late_ave'];
match2_late_se=[[nan,nan]',match2_late_se'];
x=[.75 1.25;.75 1.25];
Training_sequence={'gradual long','abrupt short'};
Training_color_seq=[gradual_adapt_color; abrupt_short_adapt_color];
plot_bar_with_error_27_01_15(x',match2_late',match2_late_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('vFF: late, GL vs AS','Fontsize',12);
ylabel('% retention');

%%%%%%%%%%%%%%% AL vs GL

figure; hold on; subplot(311);
match1_learning=[[nan,nan]',[mean(alf_match1), mean(glf_match1)]'];
match1_learning_se=[[nan,nan]',[std(alf_match1), std(glf_match1)]' * length(glf_match1)^-0.5];
x=[.75 1.25;.75 1.25];
Training_sequence={'abrupt long','gradual long'};
Training_color_seq=[abrupt_long_adapt_color;gradual_adapt_color];
plot_bar_with_error_27_01_15(x',match1_learning',match1_learning_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('vFF: final learning, AL vs GL','Fontsize',12);
ylabel('% retention');

subplot(312);
match1_early=[[nan,nan]',match1_early_ave'];
match1_early_se=[[nan,nan]',match1_early_se'];
x=[.75 1.25;.75 1.25];
Training_sequence={'abrupt long','gradual long'};
Training_color_seq=[abrupt_long_adapt_color;gradual_adapt_color];
plot_bar_with_error_27_01_15(x',match1_early',match1_early_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('vFF: early, AL vs GL','Fontsize',12);
ylabel('% retention');

subplot(313);
match1_late=[[nan,nan]',match1_late_ave'];
match1_late_se=[[nan,nan]',match1_late_se'];
x=[.75 1.25;.75 1.25];
Training_sequence={'abrupt long','gradual long'};
Training_color_seq=[abrupt_long_adapt_color;gradual_adapt_color];
plot_bar_with_error_27_01_15(x',match1_late',match1_late_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('vFF: late, AL vs GL','Fontsize',12);
ylabel('% retention');

%time constants

%startpoints from cftool:
%AL vs AS - > AL = [0.3139, 10.87], AS = [0.0674, 7.265]
%AL vs GL -> AL = [0.256, 10.22], GL = [0.227, 13] (13.49)
%GL vs AS -> GL = [0.219, 12.7], AS = [0.0775, 6.766]

s1a = [0.3139, 10.87]; s1b = [0.0674, 7.265];
s2a = [0.256, 10.22]; s2b = [0.227, 13];
s3a = [0.219, 12.7]; s3b =[0.0775, 6.766];

%AL vs AS
for i=1:4
    tau_AL1(i) = calculate_exp_fit_for_data_3_31_2017(trials',retention_al_sub_norm(i,:)', s1a);
end

for i=1:6
    tau_AS1(i) = calculate_exp_fit_for_data_3_31_2017(trials',retention_as_sub_norm(i,:)', s1b);
end

%AL vs GL
for i=1:8
    tau_AL2(i) = calculate_exp_fit_for_data_3_31_2017(trials',ret_al_match1_sub_norm(i,:)', s2a);
end

for i=1:7
 tau_GL1(i) = calculate_exp_fit_for_data_3_31_2017(trials',ret_gl_match1_sub_norm(i,:)', s2b);
end

%AS vs GL
for i=1:5
    tau_AS2(i) = calculate_exp_fit_for_data_3_31_2017(trials',ret_as_match1_sub_norm(i,:)', s3b);
    
end
for i=1:4
tau_GL2(i) = calculate_exp_fit_for_data_3_31_2017(trials',ret_gl_match2_sub_norm(i,:)', s3a);
end


y=0:2:20;
figure; subplot(311);
match_tau=[[nan,nan]',[mean(tau_AL1), mean(tau_AS1)]'];
match_tau_se=[[nan,nan]',[std(tau_AL1), std(tau_AS1)]' * length(tau_AS1)^-0.5];
x=[.75 1.25;.75 1.25];
Training_sequence={'abrupt long', 'abrupt short'};
Training_color_seq=[abrupt_long_adapt_color; abrupt_short_adapt_color];
plot_bar_with_error_27_01_15(x',match_tau',match_tau_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,20],'layer','top','box','off');
title('vFF: tau, AL vs AS','Fontsize',12);
ylabel('# trials');

subplot(312);
match_tau=[[nan,nan]',[mean(tau_AL2), mean(tau_GL1)]'];
match_tau_se=[[nan,nan]',[std(tau_AL2), std(tau_GL1)]' * length(tau_GL1)^-0.5];
x=[.75 1.25;.75 1.25];
Training_sequence={'abrupt long', 'gradual long'};
Training_color_seq=[abrupt_long_adapt_color; gradual_adapt_color];
plot_bar_with_error_27_01_15(x',match_tau',match_tau_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,20],'layer','top','box','off');
title('vFF: tau, AL vs A','Fontsize',12);
ylabel('# trials');

subplot(313);
match_tau=[[nan,nan]',[mean(tau_GL2), mean(tau_AS2)]'];
match_tau_se=[[nan,nan]',[std(tau_GL2), std(tau_AS2)]' * length(tau_AS2)^-0.5];
x=[.75 1.25;.75 1.25];
Training_sequence={'gradual long', 'abrupt short'};
Training_color_seq=[gradual_adapt_color; abrupt_short_adapt_color];
plot_bar_with_error_27_01_15(x',match_tau',match_tau_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,20],'layer','top','box','off');
title('vFF: tau, AL vs A','Fontsize',12);
ylabel('# trials');


%now make the velocity table, with p-values
[~,p_tau_algl,~,stats] = ttest2(tau_AL2, tau_GL1)
[~,p_tau_asal,~,stats] = ttest2(tau_AS1, tau_AL1)
[~,p_tau_glas,~,stats] = ttest2(tau_GL2, tau_AS2)

[~, p_early_algl,~,stats] = ttest2(al_match1_early, gl_match1_early)
[~, p_early_glas,~,stats] = ttest2(as_match1_early, gl_match2_early)

[~, p_late_algl,~,stats] = ttest2(al_match1_late, gl_match1_late)
[~, p_late_glas,~,stats] = ttest2(as_match1_late, gl_match2_late)

[~, p_learning_algl,~,stats] = ttest2(alf_match1, glf_match1)
[~, p_learning_glas,~,stats] = ttest2(asf_match1, glf_match2)

%p values comparing final adaptation between AL and AS
[~, p_learning_alas,~,stats] = ttest2(al_large, as_small)

%p values for early period
[~, p_early_alas,~,stats] = ttest2(early_retention_ave_sub_al, early_retention_ave_sub_as)

%p-values for late
[~, p_late_alas,~,stats] = ttest2(late_retention_ave_sub_al, late_retention_ave_sub_as)

Rownames = {'AL (n=4) vs AS (n=4)', 'AL (n=7) vs GL (n=7)', 'GL (n=5) vs AS (n=5)'};
Varnames = {'Final_Learning', 'Early', 'Late', 'Tau'};

learning_p = [p_learning_alas; p_learning_algl; p_learning_glas];
early_p = [p_early_alas; p_early_algl; p_early_glas];
late_p = [p_late_alas; p_late_algl; p_late_glas];
tau_p = [p_tau_asal; p_tau_algl; p_tau_glas];

velocity_Pvalues = table(learning_p, early_p, late_p, tau_p, 'VariableNames',Varnames, 'Rownames',Rownames);


xx = al_large; yy= as_small;
size(xx)
size(yy)

diff_ = (nanmean(xx) - nanmean(yy) ) / ( (nanmean(xx) + nanmean(yy))/2) * 100

%% repeat everything for position
close all; 
clear all;

gradual_adapt_color=[0,256,0]/256;
abrupt_short_adapt_color=[0,0,256]/256;
abrupt_long_adapt_color=[256,0,0]/256;

early=1:10;
late = 21:30;
trials=2:2:60;

load('pff_al_all_new.mat');
load('pff_as_all_new.mat');
load('pff_gl_all_new.mat');

% load('pret_sub.mat');
% xx = pret_sub.gl';
% xx(6,9) = (xx(6,8) + xx(6,10) ) / 2; 
% xx(14,:) = nan;

pal = pff_al_all_new;
pas = pff_as_all_new;
pgl = pff_gl_all_new;
 pgl(6,22) = (pgl(6,21) + pgl(6,23) ) / 2;  
pgl(14,:) = nan;
%temporarily deal with a missing nan
 pas(10,4) = ( pas(10,3) + pas(10,5) ) /2;
%pas(10,4) = pas(10,5);

al_learning = pal(:,13);
as_learning = pas(:,3);
gl_learning = pgl(:,13);


%%%%%%%%%%%%%
%some irrelevant stats 
experiment_conditions=cellstr([char(ones(length(al_learning),1)*'AL');char(ones(length(gl_learning),1)*'GL');char(ones(length(as_learning),1)*'AS')]);
Observations=[al_learning;gl_learning;as_learning]';
[p1,tbl1,stats1]=anova1(Observations,experiment_conditions,'off');
% 
% [c,~,~,gnames] = multcompare(stats1);
% [gnames(c(:,1)), gnames(c(:,2)), num2cell(c(:,3:6))]

%%%%%%%%%%%%%%%%%%%%%%%%


al_srt = sort(al_learning);
as_srt = sort(as_learning);
gl_srt = sort(gl_learning);

%take care of nan before cumsum 
%as_srt(isnan(as_srt)) = 0;
%gl_srt(isnan(gl_srt)) = 0;

close all; figure; hold on;
plot([cumsum((flipud(as_srt(1:end-1))))./[1:13]'],'-o');
 plot([cumsum(al_srt)./[1:14]'],'-o');
%plot([cumsum(flipud(as_srt(1:end-1)))./[1:13]',cumsum(gl_srt(1:end-1))./[1:13]'],'-o');
%plot([cumsum(al_srt)./[1:14]',cumsum(gl_srt)./[1:14]'],'-o');

%for GL vs AS, remove largest gradual, and 2 smallest AS (OR, 2 smallest AS and 2 largest GL)
%for AL vs GL, remove smallest AL and largest GL
gl_match1 = gl_srt(1:end-2);
al_match2 = al_srt(2:end);
%gl_match1 = [gl_match1(1:2);gl_match1(4:6);gl_match1(8:end)];


gl_match2 = gl_srt(1:end-2);
%gl_match2 = [gl_match2(1:2);gl_match2(4:6);gl_match2(8:end)];

as_match2 = as_srt(3:end-1);
%as_match2 = [as_match2(end)];

nq = 14-2;
%nn = 14-nq;
al_match = al_srt(1:end-1);
as_match = as_srt(2:end-1);

%now do the bar graphs for early and late
pal_idx = ismember(al_match, al_srt);
pas_idx = ismember(as_match, as_srt);

new_pal = pal(pal_idx, :);
new_pas = pas(pas_idx,:);

%calculate % retention
retention_pal_sub = new_pal(:, end-29:end);
retention_pas_sub = new_pas(:, end-29:end);

ret_pal_ave = nanmean(retention_pal_sub,1);
ret_pas_ave = nanmean(retention_pas_sub,1);

pal_norm_factor = ret_pal_ave(1);
pas_norm_factor = ret_pas_ave(1);

pal_ret_norm_sub = retention_pal_sub * (eye(30) / pal_norm_factor);
pas_ret_norm_sub = retention_pas_sub * (eye(30) / pas_norm_factor);

pal_early_sub = pal_ret_norm_sub(:,early);
pal_early = nanmean(pal_early_sub,2);
pas_early_sub = pas_ret_norm_sub(:,early);
pas_early = nanmean(pas_early_sub,2);

pal_late_sub = pal_ret_norm_sub(:,late);
pal_late = nanmean(pal_late_sub,2);
pas_late_sub = pas_ret_norm_sub(:,late);
pas_late = nanmean(pas_late_sub,2);

p_early_ave = [[nan,nan]',[nanmean(pal_early), nanmean(pas_early)]'];
p_early_se = [[nan,nan]',[std(pal_early), nanstd(pas_early)]' * nq^-0.5];

p_late_ave = [[nan,nan]',[nanmean(pal_late), nanmean(pas_late)]'];
p_late_se = [[nan,nan]',[std(pal_late), nanstd(pas_late)]' * nq^-0.5];

%do the other comparisons here
pal_match2_idx = ismember(al_match2, al_srt);
pgl_match1_idx = ismember(gl_match1, gl_srt);
pas_match2_idx = ismember(as_match2, as_srt);
pgl_match2_idx = ismember(gl_match2, gl_srt);

new_pal_match2 = pal(pal_match2_idx, :);
new_pas_match2 = pas(pas_match2_idx,:);
new_pgl_match1 = pgl(pgl_match1_idx, :);
%nan issue
new_pgl_match2 = pgl(pgl_match2_idx, :);

% new_pgl_match2 = xx(pgl_match2_idx, :);

%%%
retention_pal_match2_sub = new_pal_match2(:, end-29:end);
retention_pas_match2_sub = new_pas_match2(:, end-29:end);
retention_pgl_match1_sub = new_pgl_match1(:, end-29:end);
retention_pgl_match2_sub = new_pgl_match2(:, end-29:end);

ret_pal_match2_ave = nanmean(retention_pal_match2_sub,1);
ret_pas_match2_ave = nanmean(retention_pas_match2_sub,1);
ret_pgl_match1_ave = nanmean(retention_pgl_match1_sub,1);
ret_pgl_match2_ave = nanmean(retention_pgl_match2_sub,1);

pal_match2_norm_factor = ret_pal_match2_ave(1);
pas_match2_norm_factor = ret_pas_match2_ave(1);
pgl_match1_norm_factor = ret_pgl_match1_ave(1);
pgl_match2_norm_factor = ret_pgl_match2_ave(1);

pal_match2_ret_norm_sub = retention_pal_match2_sub * (eye(30) / pal_match2_norm_factor);
pas_match2_ret_norm_sub = retention_pas_match2_sub * (eye(30) / pas_match2_norm_factor);
pgl_match1_ret_norm_sub = retention_pgl_match1_sub * (eye(30) / pgl_match1_norm_factor);
pgl_match2_ret_norm_sub = retention_pgl_match2_sub * (eye(30) / pgl_match2_norm_factor);

%% plot learning curves for AL vs AS and AL vs GL
pal_match1_ret_norm_avg = nanmean(pal_ret_norm_sub,1);
pas_match1_ret_norm_avg = nanmean(pas_ret_norm_sub,1);

pal_match2_ret_norm_avg = nanmean(pal_match2_ret_norm_sub,1);
pgl_match1_ret_norm_avg = nanmean(pgl_match1_ret_norm_sub,1);

figure; hold on;
plot(trials, pal_match1_ret_norm_avg,'color','r');
plot(trials, pas_match1_ret_norm_avg,'color','b');
[n1,~] = size(pal_ret_norm_sub);
[n2,~] = size(pas_ret_norm_sub);
standard_error_shading_11_07_14(pal_match1_ret_norm_avg,nanstd(pal_ret_norm_sub,0,1),trials,n1,[1,0,0]);
standard_error_shading_11_07_14(pas_match1_ret_norm_avg,nanstd(pas_ret_norm_sub,0,1),trials,n2,[0,0,1]);
ylim([-0.05,1.1]);

figure; hold on;
plot(trials, pal_match2_ret_norm_avg,'color','r');
plot(trials,pgl_match1_ret_norm_avg,'color','g');
[n1,~] = size(pal_match2_ret_norm_sub);
[n2,~] = size(pgl_match1_ret_norm_sub);
standard_error_shading_11_07_14(pal_match2_ret_norm_avg,nanstd(pal_match2_ret_norm_sub,0,1),trials,n1,[1,0,0]);
standard_error_shading_11_07_14(pgl_match1_ret_norm_avg,nanstd(pgl_match1_ret_norm_sub,0,1),trials,n2,[0,1,0]);
ylim([-0.05,1.1]);


%plot the learning levels for AL vs GL
% gl_match1 = gl_srt(1:end-2);
% al_match2 = al_srt(2:end);
figure; hold on;
plot(ones(size(al_srt)), al_srt,'.','markersize',15,'color','r');
%plot(1,mean(al_srt),'x');
% plot(ones(size(al_match2)),al_match2,'o','markersize',10);
plot(ones(size(al_match2)),al_match2,'o','markersize',10,'color','k');

qk = gl_srt; qk(13) = 0.97; qk(end) = 0.866; qk = sort(qk);
plot(ones(size(qk))*2, qk,'.','markersize',15,'color','g');
%plot(2,nanmean(qk),'x');
% plot(ones(size(gl_match1))*2,gl_match1,'o','markersize',10);
plot(ones(1,13)*2,qk(1:end-1),'o','markersize',10,'color','k');
xlim([0,3]);
ylim([0.5,1]);


figure; hold on;
plot(ones(size(al_srt)), al_srt,'.','markersize',15,'color','r');
%plot(1,mean(al_srt),'x');
% plot(ones(size(al_match2)),al_match2,'o','markersize',10);
%plot(ones(size(al_match2)),al_match2,'o','markersize',10,'color','k');

%qk = gl_srt; qk(13) = 0.97; qk(end) = 0.866; qk = sort(qk);
plot(ones(size(qk))*2, qk,'.','markersize',15,'color','g');
%plot(2,nanmean(qk),'x');
% plot(ones(size(gl_match1))*2,gl_match1,'o','markersize',10);
%plot(ones(1,13)*2,qk(1:end-1),'o','markersize',10,'color','k');
xlim([0,3]);
ylim([0.5,1]);

%%

%get the early indices
pal_match2_early_sub = pal_match2_ret_norm_sub(:,early);
pal_match2_early = nanmean(pal_match2_early_sub,2);

pas_match2_early_sub = pas_match2_ret_norm_sub(:,early);
pas_match2_early = nanmean(pas_match2_early_sub,2);

pgl_match1_early_sub = pgl_match1_ret_norm_sub(:,early);
pgl_match1_early = nanmean(pgl_match1_early_sub,2);

pgl_match2_early_sub = pgl_match2_ret_norm_sub(:,early);
pgl_match2_early = nanmean(pgl_match2_early_sub,2);

%now late
pal_match2_late_sub = pal_match2_ret_norm_sub(:,late);
pal_match2_late = nanmean(pal_match2_late_sub,2);

pas_match2_late_sub = pas_match2_ret_norm_sub(:,late);
pas_match2_late = nanmean(pas_match2_late_sub,2);

pgl_match1_late_sub = pgl_match1_ret_norm_sub(:,late);
pgl_match1_late = nanmean(pgl_match1_late_sub,2);

pgl_match2_late_sub = pgl_match2_ret_norm_sub(:,late);
pgl_match2_late = nanmean(pgl_match2_late_sub,2);

%prepare for plots
p_algl_early_ave = [[nan,nan]',[nanmean(pal_match2_early), nanmean(pgl_match1_early)]'];
p_algl_early_se = [[nan,nan]',[std(pal_match2_early) * length(al_match2)^-0.5, nanstd(pgl_match1_early) * length(gl_match1)^-0.5]'];

p_algl_late_ave = [[nan,nan]',[nanmean(pal_match2_late), nanmean(pgl_match1_late)]'];
p_algl_late_se = [[nan,nan]',[std(pal_match2_late) * length(al_match2)^-0.5, nanstd(pgl_match1_late) * length(gl_match1)^-0.5]'];

%GL vs AS
p_asgl_early_ave = flipud( [[nan,nan]',[nanmean(pas_match2_early), nanmean(pgl_match2_early)]'] );
p_asgl_early_se = flipud( [[nan,nan]',[nanstd(pas_match2_early) * length(as_match2)^-0.5, nanstd(pgl_match2_early) * length(gl_match2)^-0.5]'] );

p_asgl_late_ave = flipud( [[nan,nan]',[nanmean(pas_match2_late), nanmean(pgl_match2_late)]'] );
p_asgl_late_se = flipud( [[nan,nan]',[nanstd(pas_match2_late) * length(as_match2)^-0.5, nanstd(pgl_match2_late) * length(gl_match2)^-0.5]'] );


%learning, AS vs AL
figure; subplot(311);
h_dummy=zeros(2,2);
y=0:0.2:1;

pfl_ave=[[nan,nan]',[nanmean(al_match),nanmean(as_match)]'];
pfl_se=[[nan,nan]',[ nanstd(al_match), nanstd(as_match)]' * nq^-0.5];
x=[.75 1.25;.75 1.25];
Training_sequence={'abrupt long','abrupt short'};
Training_color_seq=[abrupt_long_adapt_color;abrupt_short_adapt_color];
plot_bar_with_error_27_01_15(x',pfl_ave',pfl_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);

set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('pFF: learning, AL vs AS','Fontsize',12);
ylabel('AC');

%early
subplot(312);
plot_bar_with_error_27_01_15(x',p_early_ave',p_early_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('pFF: early, AL vs AS','Fontsize',12);
ylabel('% retention');

%late
subplot(313);
plot_bar_with_error_27_01_15(x',p_late_ave',p_late_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('pFF: late, AL vs AS','Fontsize',12);
ylabel('% retention');

%AL vs GL
figure; subplot(311);
pfl_ave=[[nan,nan]',[nanmean(al_match2),nanmean(gl_match1)]'];
pfl_se=[[nan,nan]',[ nanstd(al_match2) * length(al_match2)^-0.5, nanstd(gl_match1) * length(gl_match1)^-0.5]'];
Training_sequence={'abrupt long','gradual long'};
Training_color_seq=[abrupt_long_adapt_color;gradual_adapt_color];
plot_bar_with_error_27_01_15(x',pfl_ave',pfl_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('pFF: learning, AL vs GL','Fontsize',12);
ylabel('AC');

%early
subplot(312);
plot_bar_with_error_27_01_15(x',p_algl_early_ave',p_algl_early_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('pFF: early, AL vs GL','Fontsize',12);
ylabel('% retention');

%late
subplot(313);
plot_bar_with_error_27_01_15(x',p_algl_late_ave',p_algl_late_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('pFF: late, AL vs GL','Fontsize',12);
ylabel('% retention');

%GL vs AS
figure; subplot(311);
pfl_ave=[[nan,nan]',[nanmean(gl_match2),nanmean(as_match2)]'];
pfl_se=[[nan,nan]',[ nanstd(gl_match2) * length(gl_match2)^-0.5, nanstd(as_match2) * length(as_match2)^-0.5]'];
Training_sequence={'gradual long','abrupt short'};
Training_color_seq=[gradual_adapt_color; abrupt_short_adapt_color];
plot_bar_with_error_27_01_15(x',pfl_ave',pfl_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('pFF: learning, GL vs AS','Fontsize',12);
ylabel('AC');

%early
subplot(312);
plot_bar_with_error_27_01_15(x',p_asgl_early_ave',p_asgl_early_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('pFF: early, GL vs AS','Fontsize',12);
ylabel('% retention');

%late
subplot(313);
plot_bar_with_error_27_01_15(x',p_asgl_late_ave',p_asgl_late_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,1],'layer','top','box','off');
title('pFF: late, GL vs AS','Fontsize',12);
ylabel('% retention');

%time constants here

%startpoints from cftool:
%AL vs AS - > AL = [0.205, 10.7], AS = [0.068, 5.9]
%AL vs GL -> AL = [0.2086, 11.1], GL = [0.215, 10.3]
%GL vs AS -> GL = [0.205, 10.7], AS = [0.076, 6.7]

s1a = [0.205, 10.7]; s1b = [0.068, 5.9];
s2a = [0.2086, 11.1]; s2b = [0.215, 10.3];
s3a = [0.205, 12]; s3b =[0.076, 5];

%AL vs AS
for i=1:length(al_match)
    ptau_AL1(i) = calculate_exp_fit_for_data_3_31_2017(trials',pal_ret_norm_sub(i,:)', s1a);
    
end
for i=1:length(as_match)
ptau_AS1(i) = calculate_exp_fit_for_data_3_31_2017(trials',pas_ret_norm_sub(i,:)', s1b);
end
%AL vs GL
for i=1:length(al_match2)
    ptau_AL2(i) = calculate_exp_fit_for_data_3_31_2017(trials',pal_match2_ret_norm_sub(i,:)', s2a);
end

for i=1:length(pgl_match1_late)
    ptau_GL1(i) = calculate_exp_fit_for_data_3_31_2017(trials',pgl_match1_ret_norm_sub(i,:)', s2b);
end

%GL vs AS
%retention_pgl_match2_sub
for i=1:length(pgl_match2_late)
    ptau_GL2(i) = calculate_exp_fit_for_data_3_31_2017(trials',pgl_match2_ret_norm_sub(i,:)', s3a);
end

%pas_match2_ret_norm_sub22 = pas_match2_ret_norm_sub(1:9, :);
%pas_match2_ret_norm_sub22(10,:) = pas_match2_ret_norm_sub(11,:);
for i=1:length(pas_match2_late)
    ptau_AS2(i) = calculate_exp_fit_for_data_3_31_2017(trials',pas_match2_ret_norm_sub(i,:)', s3b);
end

%ptau_AS2 = [ptau_AS2(1:8), ptau_AS2(10:11)];

y=0:2:20;
figure; subplot(311);
match_tau=[[nan,nan]',[mean(ptau_AL1), mean(ptau_AS1)]'];
match_tau_se=[[nan,nan]',[std(ptau_AL1), std(ptau_AS1)]' * length(ptau_AS1)^-0.5];
x=[.75 1.25;.75 1.25];
Training_sequence={'abrupt long', 'abrupt short'};
Training_color_seq=[abrupt_long_adapt_color; abrupt_short_adapt_color];
plot_bar_with_error_27_01_15(x',match_tau',match_tau_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,20],'layer','top','box','off');
title('pFF: tau, AL vs AS','Fontsize',12);
ylabel('# trials');

subplot(312);
match_tau=[[nan,nan]',[mean(ptau_AL2), mean(ptau_GL1)]'];
match_tau_se=[[nan,nan]',[std(ptau_AL2), std(ptau_GL1)]' * length(ptau_GL1)^-0.5];
x=[.75 1.25;.75 1.25];
Training_sequence={'abrupt long', 'gradual long'};
Training_color_seq=[abrupt_long_adapt_color; gradual_adapt_color];
plot_bar_with_error_27_01_15(x',match_tau',match_tau_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,20],'layer','top','box','off');
title('pFF: tau, AL vs GL','Fontsize',12);
ylabel('# trials');

subplot(313);
match_tau=[[nan,nan]',[mean(ptau_GL2), mean(ptau_AS2)]'];
match_tau_se=[[nan,nan]',[std(ptau_GL2), std(ptau_AS2)]' * length(ptau_AS2)^-0.5];
x=[.75 1.25;.75 1.25];
Training_sequence={'gradual long', 'abrupt short'};
Training_color_seq=[gradual_adapt_color; abrupt_short_adapt_color];
plot_bar_with_error_27_01_15(x',match_tau',match_tau_se',Training_sequence,Training_color_seq,zeros(3),h_dummy);
set(gca,'FontSize',8,'ytick',y,'xtick',[0.25,1.25],'xticklabel','','xlim',[1,1.5],'ylim',[0,20],'layer','top','box','off');
title('pFF: tau, GL vs AS','Fontsize',12);
ylabel('# trials');

%%%% p values
[~,p_ptau_algl,~,stats] = ttest2(ptau_AL2, ptau_GL1)
[~,p_ptau_asal,~,stats] = ttest2(ptau_AS1, ptau_AL1)
[~,p_ptau_glas,~,stats] = ttest2(ptau_AS2, ptau_GL2)


[~,p_pearly_algl,~,stats] = ttest2(pal_match2_early,pgl_match1_early)
[~,p_pearly_alas,~,stats] = ttest2(pal_early,pas_early)
[~,p_pearly_glas,~,stats] = ttest2(pgl_match2_early,pas_match2_early)

[~,p_plate_alas,~,stats] = ttest2(pal_late,pas_late)
[~,p_plate_algl,~,stats] = ttest2(pal_match2_late,pgl_match1_late)
[~,p_plate_glas,~,stats] = ttest2(pgl_match2_late,pas_match2_late)


[~,p_plearning_alas,~,stats] = ttest2(al_match, as_match)
[~,p_plearning_algl,~,stats] = ttest2(al_match2, gl_match1)
[~,p_plearning_glas,~,stats] = ttest2(gl_match2, as_match2)


Rownames = {'AL (n=12) vs AS (n=12)', 'AL (n=14) vs GL (n=10)', 'GL (n=13) vs AS (n=12)'};
Varnames = {'Final_Learning', 'Early', 'Late', 'Tau'};

learning_p = [p_plearning_alas; p_plearning_algl; p_plearning_glas];
early_p = [p_pearly_alas; p_pearly_algl; p_pearly_glas];
late_p = [p_plate_alas; p_plate_algl; p_plate_glas];
%tau_p= zeros(3,1);
tau_p = [p_ptau_asal; p_ptau_algl; p_ptau_glas];

position_Pvalues = table(learning_p, early_p, late_p, tau_p, 'VariableNames',Varnames, 'Rownames',Rownames);



xx = as_match; yy= al_match;

diff_ = (nanmean(xx) - nanmean(yy) ) / ( (nanmean(xx) + nanmean(yy))/2) * 100




%try bootstrapping for GL vs AS
% as2_tau_boot = bootstrp(1000,@calculate_exp_fit_for_data_boot,trials',nanmean(pas_match2_ret_norm_sub)');
% 
% gl2_tau_boot = bootstrp(1000,@calculate_exp_fit_for_data_boot,trials',nanmean(pgl_match2_ret_norm_sub)');
% 
% 
% 
% [~,p,~,stat] = ttest2(as2_tau_boot(1:length(pas_match2_late)-5),gl2_tau_boot(1:length(pgl_match2_late)-5))




%%
flearn_all = [al_srt,gl_srt,as_srt];
late_ret_all = [];


%% go through and make sure that the data are normally distributed

%check final adaptation values, early period, late period, for all schedules
%may need to do the same for adaptation matched subgroups

%use the kstest() function

[~, p_early_algl,~,stats] = ttest2(al_match1_early, gl_match1_early)
[~, p_early_glas,~,stats] = ttest2(as_match1_early, gl_match2_early)

[~, p_late_algl,~,stats] = ttest2(al_match1_late, gl_match1_late)
[~, p_late_glas,~,stats] = ttest2(as_match1_late, gl_match2_late)

[~, p_learning_algl,~,stats] = ttest2(alf_match1, glf_match1)
[~, p_learning_glas,~,stats] = ttest2(asf_match1, glf_match2)

%p values comparing final adaptation between AL and AS
[~, p_learning_alas,~,stats] = ttest2(al_large, as_small)

%p values for early period
[~, p_early_alas,~,stats] = ttest2(early_retention_ave_sub_al, early_retention_ave_sub_as)

%p-values for late
[~, p_late_alas,~,stats] = ttest2(late_retention_ave_sub_al, late_retention_ave_sub_as)


















