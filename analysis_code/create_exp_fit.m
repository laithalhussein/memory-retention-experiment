function create_exp_fit
close all;

%Tau for vFF:  (AL, GL, AS)
%Tau for pFF:  (AL, GL, AS)

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

load pff_AL_EC_wash_NDX.mat;



x=nanmean(AL_all);
y=nanmean(GL_all);
z=nanmean(AS_all);

px=nanmean(pff_al_all);
py=nanmean(pff_gl_all);
pz=nanmean(pff_as_all);

Lx=x(end-30:end);
Ly=y(end-30:end);
Lz=z(end-30:end);

Lpx=px(end-30:end);
Lpy=py(end-30:end);
Lpz=pz(end-30:end);

T=[1:2:2*length(Lx)];
Tp=[1:2:2*length(Lpx)];

AL=make_exp(0.6659,0.2079,0.154,T);
GL=make_exp(0.6965,0.1763,0.1485,T);
AS=make_exp(0.7346,0.3148,0.03338,T);

ALp=make_exp(0.7014,0.176,0.142,Tp);
GLp=make_exp(0.7929,0.2234,0.1765,Tp);
ASp=make_exp(0.9916,0.3103,0.0453,Tp);

%% vFF

figure(10); hold on;
title('vFF exp fits');
h1=plot(T,AL,'color',abrupt_long_adapt_color,'LineWidth',curve_width);
plot(T,GL,'color',gradual_adapt_color,'LineWidth',curve_width);
plot(T,AS,'color',abrupt_short_adapt_color,'LineWidth',curve_width);

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