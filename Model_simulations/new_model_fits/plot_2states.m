function [fig] = plot_2states(slow, fast,overall,ts)

%generates a plot of slow, fast, and overall motor output for different
%training schedules
%will handle multiple simulations (e.g. position and velocity)

[~,num_sim] = size(slow);
h = figure; hold on;
y=-0.2:.2:1.01;

if strcmp(ts,'AS')
    color1 = [0,0,256]/256;

elseif strcmp(ts,'AL')
    color1=[256,0,0]/256;

else strcmp(ts,'GL')
    color1=[0,256,0]/256;
end

asw = 2;

for k=1:num_sim
    
    if strcmp(ts,'AS')
        xf1 = fast(1:31,k); xf2 = fast(31:end,k);
        xs1 = slow(1:31,k); xs2 = slow(31:end,k);
        xtot1 = overall(1:31,k); xtot2 = overall(31:end,k);
    else
        xs = slow(:,k);
        xf = fast(:,k);
        xtot = overall(:,k);
    end
    
%     if k==1,
%         Ls = '--';
%     elseif k==2,
%         Ls = ':';
%     end
    
    if strcmp(ts,'AS')
        plot([1-15:length(xtot1)-15],xtot1','color',color1,'Displayname','Net Motor Output','Linewidth',asw);
        plot([1-15:length(xs1)-15],xs1','color',color1,'Displayname','Slow State','Linewidth',asw ,'Linestyle','--');
        plot([1-15:length(xf1)-15],xf1','color',color1,'Displayname','Fast State','Linewidth',asw ,'Linestyle',':');


        o1=plot([31-15,161],[xtot1(end),xtot1(end)],'--','color',[0.5,0.5,0.5],'lineWidth',.5);
        o1=plot([31-15,161],[xs1(end),xs1(end)],'--','color',[0.5,0.5,0.5],'lineWidth',.5);
        o1=plot([31-15,161],[xf1(end),xf1(end)],'--','color',[0.5 0.5 0.5],'lineWidth',.5);

        plot([161:220],xtot2','color',color1,'Displayname','Net Motor Output','Linewidth',asw );
        plot([161:220],xs2','color',color1,'Displayname','Slow State','Linewidth',asw ,'Linestyle','--');
        plot([161:220],xf2','color',color1,'Displayname','Fast State','Linewidth',asw ,'Linestyle',':');         
        
    else
        plot([1-15:length(xtot)-15],xtot','color',color1,'Displayname','Net Motor Output','Linewidth',2);
        plot([1-15:length(xf)-15],xs','color',color1,'Displayname','Slow State','Linewidth',2,'Linestyle','--');
        plot([1-15:length(xf)-15],xf','color',color1,'Displayname','Fast State','Linewidth',2,'Linestyle',':');
               
    end

end

set(gca,'FontSize',12,'xtick',[-50,0:50:200],'ytick',y,'ylim',[-0.2,1.01],'xlim',[-50,221],'layer','top');
xlabel('Trial Number','FontSize',12,'FontWeight','normal','Color','k');
ylabel('Adaptation Coefficient','FontSize',12,'FontWeight','normal','Color','k');

% title(ts,'Fontsize',12);
o1=plot([-50,220],[0,0],'k--','lineWidth',.5);
hg=get(o1,'Annotation'); hLegendEntry = get(hg,'LegendInformation'); set(hLegendEntry,'IconDisplayStyle','off');

%legend('Show');

fig = h;
return