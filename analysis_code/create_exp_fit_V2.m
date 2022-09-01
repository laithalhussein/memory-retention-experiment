function create_exp_fit_V2
close all;

%Tau for vFF:  (AL, GL, AS)
%Tau for pFF:  (AL, GL, AS)

%% setup
abrupt_short_adapt_color=[0,0,256]/256;
abrupt_long_adapt_color=[256,0,0]/256;
gradual_adapt_color=[0,256,0]/256;
curve_width=1.5;
yy=-0.2:.2:1.01;

load AL_all.mat;
load GL_all.mat;
load AS_all.mat;

load pFF_AL_unlearning.mat;
load pFF_GL_unlearning.mat;
load pFF_AS_unlearning.mat;

load abrupt_long_wash_EC_NDX_corrected.mat
load abrupt_short_wash_EC_NDX_corrected.mat
load gradual_wash_EC_NDX_corrected.mat

% load pff_AL_EC_wash_NDX.mat;
% load pff_gradual_EC_wash_NDX.mat;

%% 
x=nanmean(AL_all);
y=nanmean(GL_all);
z=nanmean(AS_all);

Lx=x(end-29:end);
Ly=y(end-29:end);
Lz=z(end-29:end);

Lpx=pFF_AL_unlearning;
Lpy=pFF_GL_unlearning;
Lpz=pFF_AS_unlearning;

T_AL=abrupt_long_wash_EC_NDX_corrected;
T_GL=gradual_wash_EC_NDX_corrected;
T_AS=abrupt_short_wash_EC_NDX_corrected;

% Tp_AL=pff_AL_EC_wash_NDX;
% Tp_GL=pff_gradual_EC_wash_NDX;
% Tp_AS=pff_AL_EC_wash_NDX;

offset_x=0;

Tp=[2:2:60,61]-offset_x;

Tp2=[1:length(Lpx)];

AL=make_exp(0.5585,0.1085,0.1556,T_AL);
GL=make_exp(0.5797,0.08708,0.1478,T_GL);
AS=make_exp(0.5856,0.1751,0.03564,T_AS);

ALp=make_exp(0.7014,0.08801,0.142,Tp);
GLp=make_exp(0.7929,0.1117,0.1765,Tp);
ASp=make_exp(0.9916,0.1552,0.0453,Tp);

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
h2=plot(Tp,ALp,'color',abrupt_long_adapt_color,'LineWidth',curve_width);
plot(Tp,GLp,'color',gradual_adapt_color,'LineWidth',curve_width);
plot(Tp,ASp,'color',abrupt_short_adapt_color,'LineWidth',curve_width);

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