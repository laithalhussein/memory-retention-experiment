%AS_R_vff=cell2mat(struct2cell(load('AS_R_vff1.mat')));
AS_W_R_vff_FINAL=cell2mat(struct2cell(load('AS_W_R_vff_FINAL.mat')));
AL_R_vff=cell2mat(struct2cell(load('AL_R_vff1.mat')));
AL_W_R_vff=cell2mat(struct2cell(load('AL_W_R_vff1.mat')));
GL_R_vff=cell2mat(struct2cell(load('GL_R_vff1.mat')));
GL_W_R_vff=cell2mat(struct2cell(load('GL_W_R_vff1.mat')));


% AL_R_vff=ave_r2_test_AL;
% AL_W_R_vff=ave_r2_wash_AL;
% GL_R_vff=ave_r2_test_GL;
% GL_W_R_vff=ave_r2_wash_GL;



early_wash_shade=2.1*[100,100,100]/256;

AL_learning_trials=cell2mat(struct2cell(load('angle_trials.mat')));

AL_learning_trials(5)=17;

AS_lr=[2,11,15];

decay_trials=[161:2:220];
figure; hold on;
AS_R_vff=[.8862,.9298,.908];
%%%learning
plot(AS_lr,AS_R_vff,'s-','Linewidth',2,'markersize',3)
% plot([abrupt_short_EC_test_NDX(end):decay_trials(1)],[repmat(ave_r2_test_AS(end),decay_trials(1)-abrupt_short_EC_test_NDX(end)+1,1)],'--','Linewidth',2)
plot(decay_trials,AS_W_R_vff_FINAL,'.-','Linewidth',2,'markersize',15)

plot(AL_learning_trials(3:end)-2,AL_R_vff,'rs-','Linewidth',2,'markersize',3)
plot([AL_learning_trials(end)-2,decay_trials(1)],[AL_R_vff(end),AL_W_R_vff(1)],'r-','Linewidth',2)
plot(decay_trials,AL_W_R_vff,'r.-','Linewidth',2,'markersize',15)

plot(AL_learning_trials(3:end)-2,GL_R_vff,'gs-','Linewidth',2,'markersize',3)
plot([AL_learning_trials(end)-2,decay_trials(1)],[GL_R_vff(end),GL_W_R_vff(1)],'g-','Linewidth',2)
plot(decay_trials,GL_W_R_vff,'g.-','Linewidth',2,'markersize',15)

title('R-squared progession','Fontsize',14);
set(gca,'Fontsize',12);
ylabel('R-squared value','Fontsize',12)
xlabel('Trial after learning onset','Fontsize',12);
ylim([0 1])
xlim([0,220])

% AL_R_vff=AL_R_vff+.005;
% AL_W_R_vff=AL_W_R_vff+.005;
% GL_R_vff=GL_R_vff+.005;
% GL_W_R_vff=GL_W_R_vff+.005;
% 
% 
% 
% save('AS_R_vff1.mat','AS_R_pff')
% save('AS_W_R_vff1.mat','ave_r2_wash_AS')
% save('AL_R_vff1.mat','AL_R_vff')
% save('AL_W_R_vff1.mat','AL_W_R_vff')
% save('GL_R_vff1.mat','GL_R_vff')
% save('GL_W_R_vff1.mat','GL_W_R_vff')




AS_R_pff=cell2mat(struct2cell(load('AS_R_pff.mat')));
AS_R_W_pff=cell2mat(struct2cell(load('AS_R_W_pff.mat')));
AL_R_pff=cell2mat(struct2cell(load('AL_R_pff.mat')));
AL_W_R_pff=cell2mat(struct2cell(load('AL_W_R_pff.mat')));
GL_R_pff=cell2mat(struct2cell(load('GL_R_pff.mat')));
GL_R_W_pff=cell2mat(struct2cell(load('GL_R_W_pff.mat')));

plot(AS_lr,AS_R_pff,'s--','Linewidth',2,'markersize',3)
% plot([posexp_AS_EC_test_NDX2(end):decay_trials(1)],[repmat(AS_R_pff(end),decay_trials(1)-posexp_AS_EC_test_NDX2(end)+1,1)],'--','Linewidth',2)
plot(decay_trials,AS_R_W_pff-.02,'.--','Linewidth',2,'markersize',15)

plot(AL_learning_trials(3:end)-2,AL_R_pff(1:end-1),'rs--','Linewidth',2,'markersize',3)
plot([AL_learning_trials(end)-2,decay_trials(1)],[AL_R_pff(end-1),AL_W_R_pff(1)-.02],'r--','Linewidth',2)
plot(decay_trials,AL_W_R_pff-.02,'r.--','Linewidth',2,'markersize',15)

plot(AL_learning_trials(3:end)-2,GL_R_pff(1:end-1),'gs--','Linewidth',2,'markersize',3)
plot([AL_learning_trials(end)-2,decay_trials(1)],[GL_R_pff(end-1),GL_R_W_pff(1)-.02],'g--','Linewidth',2)
plot(decay_trials,GL_R_W_pff-.02,'g.--','Linewidth',2,'markersize',15)






hh=area([160,221],[1,1],'linestyle','none','facecolor',early_wash_shade,'basevalue',0);
hh1=get(hh,'Annotation');hLegendEntry = get(hh1,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(hh,'bottom');


y=[0:.2:1];
set(gca,'FontSize',12,'ytick',y,'ylim',[0,1],'layer','top','box','off');

% set(gcf, 'PaperUnits', 'inches');
% set(gcf, 'PaperSize', [6.25 7.5]);
% set(gcf, 'PaperPositionMode', 'manual');
% 
% set(gcf, 'PaperPosition', [.5 .5 5.5 6.5]);
print -dpdf -cmyk -painters r_squared_try_3.pdf







