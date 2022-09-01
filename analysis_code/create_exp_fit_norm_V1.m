function create_exp_fit_norm_V1
close all;

%Tau for vFF:  (AL, GL, AS)
%Tau for pFF:  (AL, GL, AS)

%% setup
abrupt_short_adapt_color=[0,0,256]/256;
abrupt_long_adapt_color=[256,0,0]/256;
gradual_adapt_color=[0,256,0]/256;
curve_width=1.5;
yy=-0.2:.2:1.01;

load vff_wash_norm_data.mat;
load pff_wash_norm_data.mat;

%% 
Lx=ave_velocity_fit_abrupt_long_sub_wash_norm; %vff
Ly=ave_velocity_fit_gradual_sub_wash_norm;
Lz=ave_velocity_fit_abrupt_short_sub_wash_norm;

T_AL=abrupt_long_wash_EC_NDX_corrected;
T_GL=gradual_wash_EC_NDX_corrected;
T_AS=abrupt_short_wash_EC_NDX_corrected;

Lpx=ave_position_fit_posexp_sub_wash_norm;
Lpy=ave_position_fit_gradual_sub_wash_norm;
Lpz=ave_position_fit_posexp_AS_sub_wash_norm;

Tp_AL=posexp_EC_wash_NDX_corrected;
Tp_GL=gradual_EC_wash_NDX_corrected;
Tp_AS=posexp_AS_EC_wash_NDX_corrected;

offset_x=0;
% Tp=[2:2:60,61]-offset_x;
% Tp2=[1:length(Lpx)];

AL=make_exp(0.9293,0.1085,0.259,T_AL);
GL=make_exp(0.9176,0.08708,0.2339,T_GL);
AS=make_exp(1.259,0.1752,0.07663,T_AS);

ALp=make_exp(0.8019,0.09176,0.2105,Tp_AL);
GLp=make_exp(0.8513,0.1286,0.2484,Tp_GL);
ASp=make_exp(1.078,0.1819,0.07652,Tp_AS);

% AL=make_exp(1,0.1182,0.2617,T_AL);
% GL=make_exp(1,0.09707,0.2387,T_GL);
% AS=make_exp(1,0.1357,0.0697,T_AS);
% 
% ALp=make_exp(1,0.1248,0.2222,Tp_AL);
% GLp=make_exp(1,0.1554,0.2516,Tp_GL);
% ASp=make_exp(1,0.1676,0.07578,Tp_AS);


%% vFF
figure(10); hold on;
title('vFF exp fits');

h1=plot(T_AL-offset_x,AL,'color',abrupt_long_adapt_color,'LineWidth',curve_width);
plot(T_GL-offset_x,GL,'color',gradual_adapt_color,'LineWidth',curve_width);
plot(T_AS-offset_x,AS,'color',abrupt_short_adapt_color,'LineWidth',curve_width);

o1=plot([0,61],[0,0],'k--','lineWidth',.5);
hg=get(o1,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');

h1Annotation = get(h1,'Annotation');
h1LegendEntry = get(h1Annotation','LegendInformation');
set(h1LegendEntry,'IconDisplayStyle','off');

set(gca,'FontSize',8,'xtick',[0,10:10:60],'ytick',yy,'xlim',[0,61],'ylim',[-0.2,1.01],'layer','top');
% set(gca,'FontSize',8,'xtick',[0,10:10:60],'ytick',yy,'yticklabel',sprintf('%1.1f|',yy),'xlim',[0,61],'ylim',[-0.2,1.01],'layer','top');
xlabel('Trial Number (Unlearing Period)','FontSize',8,'FontWeight','normal','Color','k');
ylabel('Normalized Adaptation Coefficient','FontSize',8,'FontWeight','normal','Color','k');

%% pFF
figure(11); hold on;
title('pFF exp fits');
h2=plot(Tp_AL,ALp,'color',abrupt_long_adapt_color,'LineWidth',curve_width);
plot(Tp_GL,GLp,'color',gradual_adapt_color,'LineWidth',curve_width);
plot(Tp_AS,ASp,'color',abrupt_short_adapt_color,'LineWidth',curve_width);

% h2=plot(Tp,GLp,'color',gradual_adapt_color,'LineWidth',curve_width);
% plot(Tp,Lpy,'.');

o1=plot([0,61],[0,0],'k--','lineWidth',.5);
hg=get(o1,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');

h2Annotation = get(h2,'Annotation');
h2LegendEntry = get(h2Annotation','LegendInformation');
set(h2LegendEntry,'IconDisplayStyle','off');

set(gca,'FontSize',8,'xtick',[0,10:10:60],'ytick',yy,'xlim',[0,61],'ylim',[-0.2,1.01],'layer','top');
% set(gca,'FontSize',8,'xtick',[0,10:10:60],'ytick',yy,'yticklabel',sprintf('%1.1f|',yy),'xlim',[0,61],'ylim',[-0.2,1.01],'layer','top');
xlabel('Trial Number (Unlearing Period)','FontSize',8,'FontWeight','normal','Color','k');
ylabel('Normalized Adaptation Coefficient','FontSize',8,'FontWeight','normal','Color','k');



end


function eq=make_exp(a,b,c,x)

eq=a*exp(-b*x)+c;
end