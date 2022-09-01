close all;
grey=[.35,0.35,.35];

vFF_GL_pv_learning=[gradual_test_misaligned_comp_ave,gradual_test_aligned_comp_ave];
vFF_AL_pv_learning=[abrupt_long_test_misaligned_comp_ave,abrupt_long_test_aligned_comp_ave];
vFF_AS_pv_learning=[abrupt_short_test_misaligned_comp_ave,abrupt_short_test_aligned_comp_ave];

vFF_GL_pv_decay=[gradual_wash_misaligned_comp_ave,gradual_wash_aligned_comp_ave];
vFF_AL_pv_decay=[abrupt_long_wash_misaligned_comp_ave,abrupt_long_wash_aligned_comp_ave];
vFF_AS_pv_decay=[abrupt_short_wash_misaligned_comp_ave,abrupt_short_wash_aligned_comp_ave];


% for i=1:length(vFF_AL_pv_decay)
% %     vFF_alpharad_AL_decay(i)=acos(dot([0,1],vFF_AL_pv_decay(i,:))/sqrt(dot([0,1],[0,1])*dot(vFF_AL_pv_decay(i,:),vFF_AL_pv_decay(i,:))));
%     vFF_alpharad_AL_decay(i)=atan2(vFF_AL_pv_decay(i,1),vFF_AL_pv_decay(i,2));
% end
% 
% for i=1:length(vFF_GL_pv_decay)
% %     vFF_alpharad_GL_decay(i)=acos(dot([0,1],vFF_GL_pv_decay(i,:))/sqrt(dot([0,1],[0,1])*dot(vFF_GL_pv_decay(i,:),vFF_GL_pv_decay(i,:))));
%       vFF_alpharad_GL_decay(i)=atan2(vFF_GL_pv_decay(i,1),vFF_GL_pv_decay(i,2));
% end
% 
% for i=1:length(vFF_AS_pv_decay)
% %     vFF_alpharad_AS_decay(i) = acos(dot([0,1],vFF_AS_pv_decay(i,:))/sqrt( dot([0,1],[0,1])*dot(vFF_AS_pv_decay(i,:),vFF_AS_pv_decay(i,:))));
%       vFF_alpharad_AS_decay(i)=atan2(vFF_AS_pv_decay(i,1),vFF_AS_pv_decay(i,2));
% end
% 
% for i=1:length(vFF_AL_pv_learning)
% %     vFF_alpharad_AL_learning(i)=acos(dot([0,1],vFF_AL_pv_learning(i,:))/sqrt(dot([0,1],[0,1])*dot(vFF_AL_pv_learning(i,:),vFF_AL_pv_learning(i,:))));
%     vFF_alpharad_AL_learning(i)=atan2(vFF_AL_pv_learning(i,1),vFF_AL_pv_learning(i,2));
% end
% 
% for i=1:length(vFF_GL_pv_learning)
%     %vFF_alpharad_GL_learning(i)=acos(dot([0,1],vFF_GL_pv_learning(i,:))/sqrt(dot([0,1],[0,1])*dot(vFF_GL_pv_learning(i,:),vFF_GL_pv_learning(i,:))));
%     vFF_alpharad_GL_learning(i)=atan2(vFF_GL_pv_learning(i,1),vFF_GL_pv_learning(i,2));
% end
% 
% for i=1:length(vFF_AS_pv_learning)
% %     vFF_alpharad_AS_learning(i)=acos(dot([0,1],vFF_AS_pv_learning(i,:))/sqrt(dot([0,1],[0,1])*dot(vFF_AS_pv_learning(i,:),vFF_AS_pv_learning(i,:))));
%       vFF_alpharad_AS_learning(i)=atan2(vFF_AS_pv_learning(i,1),vFF_AS_pv_learning(i,2));
% end


% vFF_angles_AL_learning=vFF_alpharad_AL_learning.*180/pi;
% vFF_angles_GL_learning=vFF_alpharad_GL_learning.*180/pi;
% vFF_angles_AS_learning=vFF_alpharad_AS_learning.*180/pi;
% 
% vFF_angles_AL_decay=vFF_alpharad_AL_decay.*180/pi;
% vFF_angles_GL_decay=vFF_alpharad_GL_decay.*180/pi;
% vFF_angles_AS_decay=vFF_alpharad_AS_decay.*180/pi;


vFF_angles_AL_learning=90-atan2d(vFF_AL_pv_learning(1:end,2),vFF_AL_pv_learning(1:end,1));
vFF_angles_GL_learning=90-atan2d(vFF_GL_pv_learning(1:end,2),vFF_GL_pv_learning(1:end,1));
vFF_angles_AS_learning=90-atan2d(vFF_AS_pv_learning(1:end,2),vFF_AS_pv_learning(1:end,1));

vFF_angles_AL_decay=90-atan2d(vFF_AL_pv_decay(1:end,2),vFF_AL_pv_decay(1:end,1));
vFF_angles_GL_decay=90-atan2d(vFF_GL_pv_decay(1:end,2),vFF_GL_pv_decay(1:end,1));
vFF_angles_AS_decay=90-atan2d(vFF_AS_pv_decay(1:end,2),vFF_AS_pv_decay(1:end,1));



pFF_angles_AL_learning=cell2mat(struct2cell(load('pos_angles_AL_learning1.mat')));
pFF_angles_AL_decay=cell2mat(struct2cell(load('pos_angles_AL_decay1.mat')));

pFF_angles_GL_learning=cell2mat(struct2cell(load('pos_angles_GL_learning1.mat')));
pFF_angles_GL_decay=cell2mat(struct2cell(load('pos_angles_GL_decay1.mat')));

pFF_angles_AS_learning=cell2mat(struct2cell(load('pos_angles_AS_learning1.mat')));
pFF_angles_AS_decay=cell2mat(struct2cell(load('pos_angles_AS_decay1.mat')));

AL_learning_trials=cell2mat(struct2cell(load('angle_trials.mat')));
%plot([-.2,0.4],[.5134,.5134],'k.-','lineWidth',.5,'color',[.5,.5,.5]);
%trials_decay=[160:2:221];
%trials_decay=abrupt_long_EC_wash_NDX;

%LEARNING FIGURE

 AL_learning_trials(5)=17;

AS_lr=[2,11,15];
AS_lr_vff=[3,12,15];


a5=figure(5); hold on;
% plot([0],[0],'k--','lineWidth',2);
plot(abrupt_long_EC_test_NDX,vFF_angles_AL_learning(2:end),'r','LineWidth',2,'Displayname','AL vFF')
plot(AL_learning_trials(3:end),pFF_angles_AL_learning(3:end),'r--','LineWidth',2,'Displayname','AL pFF')
plot(gradual_EC_test_NDX,vFF_angles_GL_learning(2:end),'g','LineWidth',2,'Displayname','GL vFF')
plot(AL_learning_trials(3:end),pFF_angles_GL_learning(3:end),'g--','LineWidth',2,'Displayname','GL pFF')
plot(AS_lr,[vFF_angles_AS_learning(2:end)',vFF_angles_AS_decay(2)],'LineWidth',2,'Displayname','AS vFF')
plot(AS_lr,pFF_angles_AS_learning(2:end),'b--','LineWidth',2,'Displayname','AS pFF')
legend('show');

plot(gradual_EC_test_NDX,vFF_angles_GL_learning(2:end),'.','color','g','markersize',15)
plot(AL_learning_trials(3:end),pFF_angles_GL_learning(3:end),'.','color','g','markersize',15)
plot(abrupt_long_EC_test_NDX,vFF_angles_AL_learning(2:end),'.','color','r','markersize',15)
plot(AL_learning_trials(3:end),pFF_angles_AL_learning(3:end),'.','color','r','markersize',15)
plot(AS_lr,[vFF_angles_AS_learning(2:end)',vFF_angles_AS_decay(2)],'.','color','b','markersize',15)
plot(AS_lr,pFF_angles_AS_learning(2:end),'.','color','b','markersize',15)

hline = refline([0 0]);
set(hline,'LineStyle','--','color','k','Linewidth',2)

title('Specificity during Learning','Fontsize',12)
ylabel('Degrees','Fontsize',12)
xlabel('Trials','Fontsize',12)
set(gca,'Fontsize',12)
ylim([-40 80])

% plot(abrupt_long_EC_test_NDX,vFF_angles_AL_learning(2:end),'k.','markersize',15)
% %plot(trials_decay,vFF_angles_AL_decay(2:end),'k.','markersize',15)
% plot(AL_learning_trials(3:end),pFF_angles_AL_learning(3:end),'k.','markersize',15)
% %plot(trials_decay,pFF_angles_AL_decay(2:end),'k.','markersize',15)
% 
% plot(abrupt_long_EC_test_NDX,vFF_angles_AL_learning(2:end),'r','LineWidth',2,'Displayname','AL vFF')
% %plot(trials_decay,vFF_angles_AL_decay(2:end),'r','LineWidth',2)
% plot(AL_learning_trials(3:end),pFF_angles_AL_learning(3:end),'r--','LineWidth',2,'Displayname','AL pFF')
% %plot(trials_decay,pFF_angles_AL_decay(2:end),'r--','LineWidth',2)
% 
% %fix here
% % plot([abrupt_long_EC_test_NDX(end),trials_decay(1)],[vFF_angles_AL_learning(end),vFF_angles_AL_decay(2)],'r','LineWidth',2);
% % plot([AL_learning_trials(end),trials_decay(1)],[pFF_angles_AL_learning(end),pFF_angles_AL_decay(2)],'r--','LineWidth',2);
% 
% %GL
% plot(gradual_EC_test_NDX,vFF_angles_GL_learning(2:end),'k.','markersize',15)
% %plot(trials_decay,vFF_angles_GL_decay(2:end),'k.','markersize',15)
% plot(AL_learning_trials(3:end),pFF_angles_GL_learning(3:end),'k.','markersize',15)
% %plot(trials_decay,pFF_angles_GL_decay(2:end),'k.','markersize',15)
% 
% plot(gradual_EC_test_NDX,vFF_angles_GL_learning(2:end),'g','LineWidth',2,'Displayname','GL vFF')
% %plot(trials_decay,vFF_angles_GL_decay(2:end),'g','LineWidth',2)
% plot(AL_learning_trials(3:end),pFF_angles_GL_learning(3:end),'g--','LineWidth',2,'Displayname','GL pFF')
% %plot(trials_decay,pFF_angles_GL_decay(2:end),'g--','LineWidth',2)
% 
% %fix here
% % plot([gradual_EC_test_NDX(end),trials_decay(1)],[vFF_angles_GL_learning(end),vFF_angles_GL_decay(2)],'g','LineWidth',2);
% % plot([AL_learning_trials(end),trials_decay(1)],[pFF_angles_GL_learning(end),pFF_angles_GL_decay(2)],'g--','LineWidth',2);
% 
% title('Specificity during Learning','Fontsize',12)
% ylabel('Degrees','Fontsize',12)
% xlabel('Trials','Fontsize',12)
% set(gca,'Fontsize',12)

% hh=area([160,220],[50,50],'linestyle','none','facecolor',early_wash_shade,'basevalue',-20);
% hh1=get(hh,'Annotation');hLegendEntry = get(hh1,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(hh,'bottom');

%DECAY FIGURE

%trials_decay_AS=abrupt_short_EC_wash_NDX+2;
a6=figure(6); hold on;


trials_decay=[1:2:59];
trials_decay_AS=trials_decay;


plot(trials_decay,[vFF_angles_AL_decay(2:end)'],'r','LineWidth',2,'Displayname','AL vFF')
plot(trials_decay,pFF_angles_AL_decay(2:end),'r--','LineWidth',2,'Displayname','AL pFF')
plot(trials_decay,[vFF_angles_GL_decay(2:end)'],'g','LineWidth',2,'Displayname','GL vFF')
plot(trials_decay,pFF_angles_GL_decay(2:end),'g--','LineWidth',2,'Displayname','GL pFF')
plot(trials_decay_AS,[vFF_angles_AS_decay(2:end)'],'LineWidth',2,'Displayname','AS vFF')
plot(trials_decay_AS,pFF_angles_AS_decay(1:end-1),'b--','LineWidth',2,'Displayname','AS pFF')

legend('show');
plot(trials_decay,[vFF_angles_AL_decay(2:end)'],'.','color','r','markersize',15)
plot(trials_decay,pFF_angles_AL_decay(2:end),'.','color','r','markersize',15)
plot(trials_decay,[vFF_angles_GL_decay(2:end)'],'.','color','g','markersize',15)
plot(trials_decay,pFF_angles_GL_decay(2:end),'.','color','g','markersize',15)
plot(trials_decay_AS,[vFF_angles_AS_decay(2:end)'],'.','color','b','markersize',15)
plot(trials_decay_AS,pFF_angles_AS_decay(1:end-1),'.','color','b','markersize',15)
% vFF_angles_AL_learning(end)
hline = refline([0 0]);
set(hline,'LineStyle','--','color','k','Linewidth',2)



%fix here
% plot([abrupt_long_EC_test_NDX(end),trials_decay(1)],[vFF_angles_AL_learning(end),vFF_angles_AL_decay(2)],'r','LineWidth',2);
% plot([AL_learning_trials(end),trials_decay(1)],[pFF_angles_AL_learning(end),pFF_angles_AL_decay(2)],'r--','LineWidth',2);
% plot([AS_lr_vff(end),trials_decay(1)],[vFF_angles_AS_learning(end),vFF_angles_AS_decay(2)],'LineWidth',2);
% plot([AS_lr(end),trials_decay(1)],[pFF_angles_AS_learning(end-1),pFF_angles_AS_decay(1)],'b--','LineWidth',2);


title('Specificity during Decay','Fontsize',14)
ylabel('Degrees','Fontsize',12)
xlabel('Trials','Fontsize',12)
set(gca,'Fontsize',12)


% hh=area([16,75],[80,80],'linestyle','none','facecolor',early_wash_shade,'basevalue',-40);
% hh1=get(hh,'Annotation');hLegendEntry = get(hh1,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(hh,'bottom');




% a7=figure(7); hold on;
% plot(1:length(vFF_angles_AS_decay),vFF_angles_AS_decay,'k.','markersize',20)
% plot(1:length(vFF_angles_AS_decay),vFF_angles_AS_decay)
% plot(1:length(pFF_angles_AS),pFF_angles_AS,'.','markersize',20,'color',[.5,.5,.5])
% plot(1:length(pFF_angles_AS),pFF_angles_AS)
% title('Abrupt Short')
% ylabel('Degrees')
% xlabel('Decay Period')









%%%%%%%%%%%%zoomed in version of the learning%%%%%%%%%%%%%
a7=figure; 
% subplot('position',[.36,.25,.12,.2]);
subplot('position',[.1,.1,.3,.5]);
hold on;


plot(AL_learning_trials(3:end)-2,vFF_angles_AL_learning(2:end),'r.-','LineWidth',2,'markersize',15,'Displayname','AL vFF')
plot(AL_learning_trials(3:end)-2,pFF_angles_AL_learning(3:end),'r.--','LineWidth',2,'markersize',15,'Displayname','AL pFF')
plot(AL_learning_trials(3:end)-2,vFF_angles_GL_learning(2:end),'g.-','LineWidth',2,'markersize',15,'Displayname','GL vFF')
plot(AL_learning_trials(3:end)-2,pFF_angles_GL_learning(3:end),'g.--','LineWidth',2,'markersize',15,'Displayname','GL pFF')
plot(AS_lr,[vFF_angles_AS_learning(2:end)',vFF_angles_AS_decay(2)],'.-','LineWidth',2,'markersize',15,'Displayname','AS vFF')
plot(AS_lr,pFF_angles_AS_learning(2:end),'b.--','LineWidth',2,'markersize',15,'Displayname','AS pFF')

hline = refline([0 0]);
set(hline,'LineStyle','--','color','k','Linewidth',2)

title('Specificity during Learning','Fontsize',12)
ylabel('Degrees','Fontsize',12)
xlabel('Trials','Fontsize',12)
set(gca,'Fontsize',12,'xtick',[0:40:160],'layer','top')
axis([0 160 -40 80])
 
 
 
subplot('position',[.6,.1,.3,.5]); hold on;
plot(AS_lr,vFF_angles_AL_learning(2:4),'r.-','LineWidth',2,'markersize',15,'Displayname','AL vFF')
plot(AS_lr,pFF_angles_AL_learning(3:5),'r.--','LineWidth',2,'markersize',15,'Displayname','AL pFF')
plot(AS_lr,vFF_angles_GL_learning(2:4),'g.-','LineWidth',2,'markersize',15,'Displayname','GL vFF')
plot(AS_lr,pFF_angles_GL_learning(3:5),'g.--','LineWidth',2,'markersize',15,'Displayname','GL pFF')
plot(AS_lr,[vFF_angles_AS_learning(2:end)',vFF_angles_AS_decay(2)],'.-','LineWidth',2,'markersize',15,'Displayname','AS vFF')
plot(AS_lr,pFF_angles_AS_learning(2:end),'b.--','LineWidth',2,'markersize',15,'Displayname','AS pFF')

ylabel('Degrees','Fontsize',12)
xlabel('Trials','Fontsize',12)
set(gca,'Fontsize',12,'xtick',[0:5:15],'layer','top')
axis([0 15 0 50])
 
 
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperSize', [6.25 7.5]);
set(gcf, 'PaperPositionMode', 'manual');



set(gcf, 'PaperPosition', [.5 .5 5.5 6.5]);
print -dpdf -cmyk -painters angles_try_3.pdf
 
 % axis tight;
% axis([0 15 0 50])





a8=figure; 
% subplot('position',[.36,.25,.12,.2]);
subplot('position',[.1,.1,.3,.5]);
hold on;

plot(trials_decay,[vFF_angles_AL_decay(2:end)'],'r.-','LineWidth',2,'markersize',10)
plot(trials_decay,pFF_angles_AL_decay(2:end),'r.--','LineWidth',2,'markersize',10)
plot(trials_decay,[vFF_angles_GL_decay(2:end)'],'g.-','LineWidth',2,'markersize',10)
plot(trials_decay,pFF_angles_GL_decay(2:end),'g.--','LineWidth',2,'markersize',10)
plot(trials_decay_AS,[vFF_angles_AS_decay(2:end)'],'b.-','LineWidth',2,'markersize',10)
plot(trials_decay_AS,pFF_angles_AS_decay(1:end-1),'b.--','LineWidth',2,'markersize',10)

%legend('show');
% plot(trials_decay,[vFF_angles_AL_decay(2:end)'],'.','color','r','markersize',15)
% plot(trials_decay,pFF_angles_AL_decay(2:end),'.','color','r','markersize',15)
% plot(trials_decay,[vFF_angles_GL_decay(2:end)'],'.','color','g','markersize',15)
% plot(trials_decay,pFF_angles_GL_decay(2:end),'.','color','g','markersize',15)
% plot(trials_decay_AS,[vFF_angles_AS_decay(2:end)'],'.','color','b','markersize',15)
% plot(trials_decay_AS,pFF_angles_AS_decay(1:end-1),'.','color','b','markersize',15)
% vFF_angles_AL_learning(end)
hline = refline([0 0]);
set(hline,'LineStyle','--','color','k','Linewidth',2)
axis([0 60 -40 80])
title('Specificity during Decay','Fontsize',14)
ylabel('Degrees','Fontsize',12)
xlabel('Trials','Fontsize',12)
set(gca,'Fontsize',12,'xtick',[0:10:60],'layer','top');

set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperSize', [6.25 7.5]);
set(gcf, 'PaperPositionMode', 'manual');



set(gcf, 'PaperPosition', [.5 .5 5.5 6.5]);
print -dpdf -cmyk -painters angles_decay_try_1.pdf







