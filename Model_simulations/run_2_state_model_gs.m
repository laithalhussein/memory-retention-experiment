function [model_AL_iter,model_GL_iter,h_mat,p_mat,min_ind,max_ind]=run_2_state_model_gs
close all;

%IMPORTANT: normalize first plot by end training amount

shade_region=[210,210,210]/256;

%run 2 state model gradual vs abrupt training
if nargin == 0, N=160; end
N=5000; %this is the point at which gradual (linear) and sudden are equal at the end
ff_sudden = ones(N,1);
ff_gradual = [1:N]'/N;
ff_log=[min([1/15*(1:N).^(log(15)/log(N));ones(1,N)])'];

[p1.Bf, p1.Bs, p1.Af, p1.As] = deal(0.21, 0.02, 0.59, 0.992); %2006
[p2.Bf, p2.Bs, p2.Af, p2.As] = deal(0.08, 0.04, 0.85, 0.988); %Reza
[p3.Bf, p3.Bs, p3.Af, p3.As] = deal(0.2103, 0.0348, 0.8192, 0.9836); %bootstrapped
[p4.Bf, p4.Bs, p4.Af, p4.As] = deal(0.11, 0.021, 0.85, 0.998); %Joiner and Smith 2008

zs1 = sim_2state(ff_sudden, p1);
zg1 = sim_2state(ff_gradual, p1);
zlog1 = sim_2state(ff_log, p1);

zs2 = sim_2state(ff_sudden, p2);
zg2 = sim_2state(ff_gradual, p2);
zlog2 = sim_2state(ff_log, p2);

zs3 = sim_2state(ff_sudden, p3);
zg3 = sim_2state(ff_gradual, p3);
zlog3 = sim_2state(ff_log, p3);

zs4 = sim_2state(ff_sudden, p4);
zg4 = sim_2state(ff_gradual, p4);
zlog4 = sim_2state(ff_log, p4);

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

norm_factor=zs3.xs(end)/zs3.x(end);

figure;
plot([zs1.xs./zs1.x, zg1.xs./zg1.x]/(zs1.xs(end)/zs1.x(end)),'linewidth',2); hold on;
%plot([zlog1.xs./zlog1.x],'linewidth',2);
% plot([zs2.xs./zs2.x, zg2.xs./zg2.x],'linewidth',2);
% plot([zs3.xs./zs3.x, zg3.xs./zg3.x],'linewidth',2);
set(gca,'xscale','log')
lg2=legend({'Sudden ramp','linear ramp','log ramp'});
set(lg2,'Location','Best');
ylabel('x_S / x_T_O_T')
xlabel('Amount of training')
grid on; grid minor;
title('Smith et al. 2006 parameters, normalized')
%ylim([0 0.9])

figure;
plot([zs3.xs./zs3.x, zg3.xs./zg3.x]/norm_factor,'linewidth',2); hold on;
%plot([zlog3.xs./zlog3.x],'linewidth',2);
% plot([zs2.xs./zs2.x, zg2.xs./zg2.x],'linewidth',2);
% plot([zs3.xs./zs3.x, zg3.xs./zg3.x],'linewidth',2);
set(gca,'xscale','log')
lg2=legend({'Sudden ramp','linear ramp','log ramp'});
set(lg2,'Location','Best');
ylabel('x_S / x_T_O_T')
xlabel('Amount of training')
grid on; grid minor;
title('Bootstrapped parameters, normalized')
%ylim([0 0.9])


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

%figure; plot(zs3.x)

figure; hold on;
title('Linear Ramps with varying parameters','Fontsize',12);
plot([ (zs1.xs./zs1.x)./(zs1.xs./zs1.x), (zg1.xs./zg1.x)./(zs1.xs./zs1.x)], 'linewidth',2);
plot([(zg2.xs./zg2.x)./(zs2.xs./zs2.x)], 'linewidth',2); 
plot([ (zg3.xs./zg3.x)./(zs3.xs./zs3.x)], 'linewidth',2);
plot([ (zg4.xs./zg4.x)./(zs4.xs./zs4.x)], 'linewidth',2); 
set(gca,'xscale','log')
lg3=legend({'Sudden (reference)','Smith et al. 2006','Huang and Shadmehr 2009','Current study','Joiner and Smith 2008'});
set(lg3,'Location','Best')
ylabel('Referenced to sudden')
xlabel('Amount of training')
grid on; grid minor;
ylim([0 1.1])

R=1e-2;
Q=sqrt(3)*10^-2;
% R=0;
% Q=0;

iter=100;

model_AL_iter=zeros(N,iter);
model_GL_iter=zeros(N,iter);

min_ind=zeros(iter,1);
max_ind=min_ind;

h_mat=zeros(N,iter);
p_mat=h_mat;

for q=1:iter
    
    %     Af_est=p2.Af+normrnd(0,0.01141);
    %     As_est=p2.As+normrnd(0,0.0046);
    %     Bf_est=p2.Bf+normrnd(0,0.0548);
    %     Bs_est=p2.Bs+normrnd(0,0.0043);
    
    Af_est=p1.Af+normrnd(0,0.2511);
    As_est=p1.As+normrnd(0,0.0038); %FINAL
    Bf_est=p1.Bf+normrnd(0,0.2293);
    Bs_est=p1.Bs+normrnd(0,0.0095); %FINAL
    
    while Af_est < 0 | As_est < 0 | Bf_est < 0 | Bs_est<0
        Af_est=p1.Af+normrnd(0,0.2511);
        As_est=p1.As+normrnd(0,0.0038); %FINAL
        Bf_est=p1.Bf+normrnd(0,0.2293);
        Bs_est=p1.Bs+normrnd(0,0.0095); %FINAL
    end
    
    if Af_est>1, Af_est=0.99;
    elseif As_est>1, As_est=0.99;
    elseif Bs_est>1, Bs_est=0.99;
    else Bf_est>1, Bf_est=0.99;
    end
    
    
    [p5.Bf, p5.Bs, p5.Af, p5.As] = deal(Bf_est, Bs_est, Af_est, As_est);
    
    temp_AL=sim_2state_with_error(ff_sudden,p5,Q,R);
    temp_GL=sim_2state_with_error(ff_gradual,p5,Q,R);
    
    %     model_AL_iter(:,k)=(temp_AL.xs./temp_AL.x)/(temp_AL.xs(end)/temp_AL.x(end));
    %     model_GL_iter(:,k)=(temp_GL.xs./temp_GL.x)/(temp_AL.xs(end)/temp_AL.x(end));
    model_AL_iter(:,q)=(temp_AL.xs./temp_AL.x);
    model_GL_iter(:,q)=(temp_GL.xs./temp_GL.x);
    
    
end

for q=1:iter
    for jj=1:N
        [h,p]=ttest2(model_AL_iter(jj,:),model_GL_iter(jj,:),'alpha',0.05);
        
        h_mat(jj,q)=h;
        p_mat(jj,q)=p;
        
    end
end

% for qr=1:iter
%     min_ind(qr)=find(h_mat(:,qr)==1,1,'first');
%     max_ind(qr)=find(h_mat(:,qr)==1,1,'last');
% end

% first_ind=find(h_mat==1,1,'first');
% last_ind=find(h_mat==1,1,'last');
% figure(2)
% h=area([first_ind,last_ind],[1.01,1.01],'linestyle','none','facecolor',shade_region,'basevalue',.2);
% hg=get(h,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');uistack(h,'bottom');


close all;

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

function z=sim_2state_with_error(input,params,Q,R)
p=params;
F=input(:);
A=[p.As 0;0, p.Af];
B=[p.Bs;p.Bf];

two_state_model_output=zeros(length(F),1);
slow_state=0*two_state_model_output;
fast_state=0*two_state_model_output;

for nn=1:length(F)
    current_output=slow_state(nn)+fast_state(nn);
    two_state_model_output(nn)=current_output;
    current_error=F(nn)-current_output;
    next_state=A*[slow_state(nn);fast_state(nn)]+B*current_error+normrnd(0,Q,2,1);
    slow_state(nn+1)=next_state(1,1);
    fast_state(nn+1)=next_state(2,1);
    two_state_model_output(nn+1)=sum(next_state)+normrnd(0,R,1,1);
end

z.xs=slow_state(2:end);
z.xf=fast_state(2:end);
z.x=two_state_model_output(2:end);
z.all = [z.xf, z.xs, z.x];

end
    
    
    