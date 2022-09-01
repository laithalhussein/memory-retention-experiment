function run_2_state_model_gs_V7


%NOTE: V7 is an iteration of V5, V6 is unique

close all;
clear all;
%IMPORTANT: normalize first plot by end training amount

shade_region=[210,210,210]/256;
purple_=[0.5 0 0.5];
magenta=[0.5,0.5,1]; 
gold_=[0.9 0.75 0];

% Reza
% As=.988;
% Af=.85;
% Bf =.08;
% Bs=.04;

%Smith 2006
% As=.992;
% Af=.59;
% Bf =.21;
% Bs=.02;

% As=0.9836;
% Af=0.8192;
% Bf=0.2216;
% Bs=0.0348;

% Joiner&Smith 2008
% As=.998;
% Af=.85;
% Bf =.11;
% Bs=.021;

%run 2 state model gradual vs abrupt training
% if nargin == 0, N=160; end
N=5000; %this is the point at which gradual (linear) and sudden are equal at the end
ff_sudden = ones(N,1);
ff_gradual = [1:N]'/N;
% ff_log=[min([1/15*(1:N).^(log(15)/log(N));ones(1,N)])'];
ff_log=[1/15*(1:N).^(log(15)/log(N))];

[p1.Bf, p1.Bs, p1.Af, p1.As] = deal(0.21, 0.02, 0.59, 0.992); %2006
[p2.Bf, p2.Bs, p2.Af, p2.As] = deal(0.08, 0.04, 0.85, 0.988); %Reza
%[p3.Bf, p3.Bs, p3.Af, p3.As] = deal(0.2103, 0.0348, 0.8192, 0.9836); %determined from overall fits
[p4.Bf, p4.Bs, p4.Af, p4.As] = deal(0.11, 0.021, 0.85, 0.998); %Joiner and Smith 2008

  [p3.Bf, p3.Bs, p3.Af, p3.As] = deal(0.2322, 0.0287, 0.7905, 0.9919); %determined from overall velocity fits
 %[p3.Bf, p3.Bs, p3.Af, p3.As] = deal(0.2825, 0.0199, 0.8337, 0.9886); %determined from overall position fits
 
pff_params.al = [0.9853, 0.8389, 0.0223, 0.2531];
pff_params.gl = [0.999, 0.6126, 0.0185, 0.2292];
pff_params.al_as = [0.9843, 0.9247, 0.0112, 0.1832 ];

vff_params.al_as = [0.9963, 0.7649, 0.0187, 0.2323 ];
vff_params.as = [0.9925,0.5989,0.0476,0.2370];
vff_params.al = [0.9965,0.8007,0.0182,0.1993];
vff_params.gl = [0.9926, 0.7513, 0.0292, 0.2239];

pff_params.avg = ( [0.9853, 0.8389, 0.0223, 0.2531] + [0.999, 0.6126, 0.0185, 0.2292] ) / 2;
vff_params.avg = ( [0.9926, 0.7513, 0.0292, 0.2239] + [0.9965,0.8007,0.0182,0.1993]) / 2;


[ptmp.Bf, ptmp.Bs, ptmp.Af, ptmp.As]= deal(vff_params.gl(4), vff_params.gl(3), vff_params.gl(2), vff_params.gl(1)); 
%[ptmp.Bf, ptmp.Bs, ptmp.Af, ptmp.As]= deal(pff_params.al(4), pff_params.al(3), pff_params.al(2), pff_params.al(1));

%[ptmp.Bf, ptmp.Bs, ptmp.Af, ptmp.As]= deal(vff_params.al(4), vff_params.al(3), vff_params.al(2), vff_params.al(1)); 
%[ptmp.Bf, ptmp.Bs, ptmp.Af, ptmp.As]= deal(pff_params.gl(4), pff_params.gl(3), pff_params.gl(2), pff_params.gl(1)); 

%[ptmp.Bf, ptmp.Bs, ptmp.Af, ptmp.As]= deal(vff_params.avg(4), vff_params.avg(3), vff_params.avg(2), vff_params.avg(1)); 
%[ptmp.Bf, ptmp.Bs, ptmp.Af, ptmp.As]= deal(pff_params.avg(4), pff_params.avg(3), pff_params.avg(2), pff_params.avg(1)); 

p3 = ptmp;
 
%qq2=[0.9886,0.8337 ,0.0199,0.2825];

%p_vel = [0.9919,0.7905,0.0287,0.2322]; %velocity fits
%p_pos = [0.9958,0.8653,0.0217,0.2457]; %position fits

% zs1 = sim_2state(ff_sudden, p1);
% zg1 = sim_2state(ff_gradual, p1);
% zlog1 = sim_2state(ff_log, p1);
% 
% zs2 = sim_2state(ff_sudden, p2);
% zg2 = sim_2state(ff_gradual, p2);
% zlog2 = sim_2state(ff_log, p2);

% p3 = p2;

zs3 = sim_2state(ff_sudden, p3);
zg3 = sim_2state(ff_gradual, p3);
zlog3 = sim_2state(ff_log, p3);

%%
ztmp = sim_2state([zeros(10,1);ones(160,1)], p3);
ftmp2=[zeros(10,1);min([1/15*(1:160).^(log(15)/log(145));ones(1,160)])'];
ztmp2 = sim_2state(ftmp2, p3);


figure; hold on;
plot(ztmp.xs);
plot(ztmp.xf);
plot(ztmp.x);
plot(ztmp.f,'k');

st = [5,25,50,100,150]+10;
plot(st,[ztmp.xs(st)],'.','markersize',20);
plot(st,[ztmp.x(st)],'.','markersize',20);
ax = gca;
ax.XTick = st;
ax.XTickLabel = mat2cell(st-10,1,5);

title('AL');


figure; hold on;
plot(ztmp2.xs);
plot(ztmp2.xf);
plot(ztmp2.x);
plot(ztmp2.f,'k');
plot(st,[ztmp2.xs(st)],'.','markersize',20);
plot(st,[ztmp2.x(st)],'.','markersize',20);
ax = gca;
ax.XTick = st;
ax.XTickLabel = mat2cell(st-10,1,5);
title('GL');


fr1 = ztmp.xs(st) ./ ztmp.x(st);
fr2 = ztmp2.xs(st) ./ ztmp2.x(st);

figure; hold on;
plot(st,fr1,'.','markersize',20);
%plot(st,fr2,'.','markersize',20);
plot(st(end),fr1(end),'o','markersize',20,'linewidth',1.5);
ax = gca;
ax.XTick = st;
ax.XTickLabel = mat2cell(st-10,1,5);
xlim([0 180]);
ylim([0,1]);

nf1 = fr1(end);

figure; hold on;
plot(st, fr1 ./ nf1 * 100, '.','markersize',20);
%plot(st, fr2 ./ nf1 * 100, '.','markersize',20);
ax = gca;
ax.XTick = st;
ax.XTickLabel = mat2cell(st-10,1,5);
xlim([0 180]);
ylim([0,105]);

%%


% zs4 = sim_2state(ff_sudden, p4);
% zg4 = sim_2state(ff_gradual, p4);
% zlog4 = sim_2state(ff_log, p4);

% figure; 
% plot([zs1.xs./zs1.x, zg1.xs./zg1.x],'linewidth',2);
% % plot([zs2.xs./zs2.x, zg2.xs./zg2.x],'linewidth',2);
% % plot([zs3.xs./zs3.x, zg3.xs./zg3.x],'linewidth',2);
% set(gca,'xscale','log')
% lg1=legend({'Sudden ramp','Linear ramp'});
% set(lg1,'Location','Best');
% ylabel('x_S / x_T_O_T')
% xlabel('Amount of training')
% grid on; grid minor;
% ylim([0 0.9])

norm_factor1=zs3.xs(end)/zs3.x(end); %Amount at end of sudden condition
norm_factor2=zg3.xs(end)/zs3.x(end);
norm_factor3=zlog3.xs(end)/zs3.x(end);

% norm_factor1=1; %Amount at end of sudden condition
% norm_factor2=1;
% norm_factor3=1;

% figure;
% plot([zs1.xs./zs1.x, zg1.xs./zg1.x]/(zs1.xs(end)/zs1.x(end)),'linewidth',2); hold on;
% %plot([zlog1.xs./zlog1.x],'linewidth',2);
% % plot([zs2.xs./zs2.x, zg2.xs./zg2.x],'linewidth',2);
% % plot([zs3.xs./zs3.x, zg3.xs./zg3.x],'linewidth',2);
% set(gca,'xscale','log')
% lg2=legend('Sudden ramp','linear ramp','log ramp');
% set(lg2,'Location','Best');
% ylabel('x_S / x_T_O_T')
% xlabel('Amount of training')
% grid on; grid minor;
% title('Smith et al. 2006 parameters, normalized')
% %ylim([0 0.9])

%% unnormalized
% sudden_cond=[zs3.xs./zs3.x];
% linear_cond=[zg3.xs./zg3.x];
% log_cond=[zlog3.xs./zlog3.x];
% 
% figure(10); hold on;
% plot(sudden_cond,'color','r','linewidth',2);
% plot(linear_cond,'color',purple_,'linewidth',2);
% plot(log_cond,'color','g','linewidth',2);
% plot([20,50],[sudden_cond(20),linear_cond(50)],'p--','linewidth',1,'color',magenta,'markersize',14);
% plot([165,165],[sudden_cond(165),log_cond(165)],'p--','linewidth',1,'color',gold_,'markersize',14);
% % plot([zs2.xs./zs2.x, zg2.xs./zg2.x],'linewidth',2);
% % plot([zs3.xs./zs3.x, zg3.xs./zg3.x],'linewidth',2);
% set(gca,'xscale','log')
% lg2=legend('Sudden ramp','Linear ramp','Logarithmic ramp', 'Huang and Shadmehr 2009 Comparison','Joiner et al. 2013 comparison');
% plot([20,50],[sudden_cond(20),linear_cond(50)],'p','linewidth',1.7,'color',magenta,'markersize',14);
% plot([165,165],[sudden_cond(165),log_cond(165)],'p','linewidth',1.7,'color',gold_,'markersize',14);
% set(lg2,'Location','Best');
% ylabel('x_S / x_T_O_T','Fontsize',14)
% xlabel('Amount of training','Fontsize',14)
% %grid on;
% title('Fraction of Slow State to Net Motor Output')
% set(gca,'Fontsize',14);
% % ylim([0.1 1.1]);

%% normalized
sudden_cond_norm=[zs3.xs./zs3.x]/norm_factor1;
linear_cond_norm=[zg3.xs./zg3.x]/norm_factor1;
log_cond_norm=[zlog3.xs./zlog3.x]/norm_factor1;

figure(11); hold on;
plot(sudden_cond_norm,'color','r','linewidth',2);
plot(linear_cond_norm,'linestyle','-','color',purple_,'linewidth',2);
plot(log_cond_norm,'color','g','linewidth',2);
% plot([20,50],[sudden_cond_norm(20),linear_cond_norm(50)],'o','linewidth',1,'color',magenta,'markersize',11);
% plot([165,165],[sudden_cond_norm(165),log_cond_norm(165)],'x','linewidth',1,'color',gold_,'markersize',11);
% plot([20],[sudden_cond_norm(20)],'o','linewidth',1,'color',magenta,'markersize',11);
plot([160],[sudden_cond_norm(160)],'x','linewidth',1,'color',gold_,'markersize',11);

% plot([45,50],[linear_cond_norm(45),temp_cond_norm(end)],'k--','linewidth',1,'markersize',11);
% plot([145,160],[log_cond_norm(145),temp_cond_normjs(end)],'k--','linewidth',1,'markersize',11);

% plot([50],[temp_cond_norm(end)],'o','linewidth',1,'color',magenta,'markersize',11);
plot([160],[log_cond_norm(160)],'x','linewidth',1,'color',gold_,'markersize',11);

% plot([zs2.xs./zs2.x, zg2.xs./zg2.x],'linewidth',2);
% plot([zs3.xs./zs3.x, zg3.xs./zg3.x],'linewidth',2);
set(gca,'xscale','log')
lg2=legend('Sudden Introduction','Linear Ramp','Logarithmic Ramp','Current Study');
% plot([50],[sudden_cond_norm(50)],'o','linewidth',1,'color',magenta,'markersize',11);
plot([15],[sudden_cond_norm(15)],'x','linewidth',1,'color',gold_,'markersize',11);
set(lg2,'Location','Best');
ylabel('x_S / x_T_O_T','Fontsize',14)
xlabel('Amount of training','Fontsize',14)
%grid on;
title('Fraction of Slow State to Net Motor Output')
set(gca,'Fontsize',14);
if norm_factor1 ~=1, ylim([0.1 1.1]), end


%% plot as a function of % perturbation strength

x_linear = ff_gradual / 1 * 100;
x_log = ff_log / 1 * 100;
x_sudden = ff_sudden / 1 *100;

figure(55); hold on;
plot(x_sudden, sudden_cond_norm,'color','r','linewidth',2);
plot(x_linear, linear_cond_norm,'linestyle','-','color',purple_,'linewidth',2);
plot(x_log, log_cond_norm,'color','g','linewidth',2);


set(gca,'xscale','log')
lg2=legend('Sudden Introduction','Linear Ramp','Logarithmic Ramp');

set(lg2,'Location','Best');
ylabel('x_S / x_T_O_T','Fontsize',14)
xlabel('Percent of perturbation','Fontsize',14)
%grid on;
title('Fraction of Slow State to Net Motor Output')
set(gca,'Fontsize',14);
if norm_factor1 ~=1, ylim([0.1 1.1]), end




%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%Now we will do this including hold periods
% F_gradual=[zeros(15,1);min([1/15*(1:160).^(log(15)/log(145));ones(1,160)])'];
%keyboard;
hold_per = 15;

%first create the logarithmic force profiles
kk = hold_per;
log_all = zeros(1,N - kk);
linear_all = zeros(1,N - kk);
new_log_all = zeros(1,N);
new_sudden_all = zeros(1,N);
new_linear_all = zeros(1,N);
cnt = 1;
%ff_log=[1/15*(1:N).^(log(15)/log(N))];
%figure(100); hold on;
%figure(101); hold on;

rate_f = 1/hold_per;

for k=1:N
    
    new_log = [1/15*(1:k).^(log(15)/log(k))];
    znew_log = sim_2state(new_log, p3);
    new_log_all(k) = znew_log.xs(end)/znew_log.x(end);
    
    new_sudden = ones(k,1); 
    znew_sudden = sim_2state(new_sudden,p3);
    new_sudden_all(k) = znew_sudden.xs(end) / znew_sudden.x(end);
    
    new_linear = [1:k]'/k;
    znew_linear = sim_2state(new_linear,p3);
    new_linear_all(k) = znew_linear.xs(end) / znew_linear.x(end);
    
    if k> kk
        num_trials = k;
        ramp = num_trials - hold_per;

        %first do log
%         temp_log = [(1/hold_per)*(1:ramp).^(log((hold_per))/log(ramp))];
%         temp_log = [temp_log'; ones(hold_per,1)];
        
        %for the log case, we will geometrically stretch/squeeze the
        %regular case to fit the number of trials that we want
        stretch_f = ramp / 145;
        new_N = round(145*stretch_f);
        ff_log = rate_f*([0:new_N]/stretch_f).^-(log(rate_f)/ log(145));
        
        temp_log = [ff_log'; ones(hold_per,1)];

        %now linear
        temp_linear = [0:ramp]'/ramp;
        temp_linear = [temp_linear; ones(hold_per,1)];

    %      if num_trials<31
    %         figure(100);
    %         plot(temp_log);
    %         figure(101);
    %         plot(temp_linear,'--');
    %     end

        %do the simulation
        zlinear4 = sim_2state(temp_linear, p3);
        zlog4 = sim_2state(temp_log, p3);

    %     norm_factor_linear=zlinear4.xs(end)/zlinear4.x(end); 
    %     norm_factor_log=zlog4.xs(end)/zlog4.x(end);

        %get slow state fraction
        linear_all(cnt) = zlinear4.xs(end)/zlinear4.x(end);
        log_all(cnt) = zlog4.xs(end)/zlog4.x(end);

        cnt=cnt+1;
    end
end


linear_all_norm = linear_all ./ new_sudden_all(end);
log_all_norm = log_all ./ new_sudden_all(end);

%new_log_all_norm = new_log_all ./ new_log_all(end);
new_sudden_all_norm = new_sudden_all ./ new_sudden_all(end);
%new_linear_all_norm = new_linear_all ./ new_linear_all(end);

%normalize by last trial
figure(12); hold on;
trials = [kk+1 : N];
plot([1:N], new_sudden_all_norm,'color','r','linewidth',2);
plot(trials,[linear_all_norm],'color',purple_,'linewidth',2);
plot(trials,[log_all_norm],'color','g','linewidth',2);
ylabel('x_S / x_T_O_T','Fontsize',14)
xlabel('Amount of training','Fontsize',14)
title('Fraction of slow state to net motor output (with holds)');
ylim([-0.23 1.05])
plot(trials,linear_all_norm-new_sudden_all_norm(trials),'color',purple_,'linewidth',2,'linestyle','--');
plot(trials,log_all_norm-new_sudden_all_norm(trials),'color','g','linewidth',2,'linestyle','--');

% plot(trials,new_linear_all_norm(hold_per:end),'linestyle','--','color',purple_,'linewidth',2);
% plot(trials,new_log_all_norm(hold_per:end),'linestyle','--','color','g','linewidth',2);

legend({'Abrupt', 'Linear','Logarithmic','Logarithmic - Abrupt','Linear - Abrupt'});
legx = legend('show');
set(legx,'Location','SouthEast');

y=-0.2:.2:1.01;
set(gca,'ytick',y,'layer','top');
%grid on;

plot([160],[sudden_cond_norm(160)],'o','linewidth',1,'color',gold_,'markersize',11);
plot([15],[sudden_cond_norm(15)],'o','linewidth',1,'color',gold_,'markersize',11);
plot([160],[log_all_norm(145)],'o','linewidth',1,'color',gold_,'markersize',11);
set(gca,'xscale','log')

% 
% xx = sudden_cond_norm(trials(1):end)';
% zz = log_cond_norm(trials(1):end)';
% figure; hold on;
% title('difference between sudden and logarithmic');
% plot( trials, xx - log_all_norm,'k' ,'displayname','with hold');
% plot(trials, xx - zz ,'k--','displayname','no hold')
% legend('show');
% ylabel('x_S / x_T_O_T','Fontsize',14)
% xlabel('Amount of training','Fontsize',14)
% set(gca,'xscale','log')

% figure; hold on; plot(log_all_norm); plot(log_cond_norm); set(gca,'xscale','log'); title('gradual');
% 
% figure; hold on; plot(); plot(linear_all_norm); set(gca,'xscale','log'); title('linear');


keyboard;

end

function z=sim_2state(ff_input, params)

N = length(ff_input);
ec=isnan(ff_input);
f = ff_input(:);
p = params;
[xf,xs,e]=deal(zeros(N+1,1));
for k=1:N,
    if ~ec(k), e(k) = f(k) - [ xf(k) + xs(k) ]; else e(k) = 0; end
    xf(k+1) = p.Af*xf(k) + p.Bf*e(k);
    xs(k+1) = p.As*xs(k) + p.Bs*e(k);
end
z.xf = xf(2:end);
z.xs = xs(2:end);
z.x = z.xf + z.xs;
z.e = e(1:end-1);
z.f = f;
z.all = [z.xf, z.xs, z.x, z.e, z.f];

end






































    
    