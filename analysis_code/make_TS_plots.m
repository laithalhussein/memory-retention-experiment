close all;
clear all;

F_abrupt_short=[zeros(15,1);ones(15,1)];
F_gradual=[zeros(15,1);min([1/15*(1:160).^(log(15)/log(145));ones(1,160)])'];
F_abrupt_long=[zeros(15,1);ones(160,1)];




figure(1); hold on;
plot([-14:160],F_abrupt_long,'r','linewidth',2);
set(gca,'FontSize',12,'xtick',[0,160,220],'ylim',[-0.05,1.05],'xlim',[-20,221],'layer','top');


figure(2); hold on;
plot([-14:160],F_gradual,'g','linewidth',2);
set(gca,'FontSize',12,'xtick',[0,160,220],'ylim',[-0.05,1.05],'xlim',[-20,221],'layer','top');

figure(3); hold on;
plot([-14:15],F_abrupt_short,'b','linewidth',2);
set(gca,'FontSize',12,'xtick',[0,15,75],'ylim',[-0.05,1.05],'xlim',[-20,75],'layer','top');

figure(4); hold on;
plot([-14:15],F_abrupt_short,'b','linewidth',2);
set(gca,'FontSize',12,'xtick',[0,15,160,220],'ylim',[-0.05,1.05],'xlim',[-20,221],'layer','top');