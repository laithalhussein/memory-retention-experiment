function [AL_output,G_output,AL_ratio_norm,G_ratio_norm,pval_coef,hval_coef,pval_trials,hval_trials]=training_schedule_map

close all 
%clear all 
home
%%

iteration=66;

N=5000;

ff_sudden = ones(N,1);
ff_gradual = [1:N]'/N;
ff_log=[min([1/15*(1:N).^(log(15)/log(N));ones(1,N)])'];



Abrupt_long_output=zeros(iteration,N);
Abrupt_long_slow=Abrupt_long_output*0;
Abrupt_long_fast=Abrupt_long_output*0;

Gradual_output=zeros(iteration,N);
Gradual_slow=Gradual_output*0;
Gradual_fast=Gradual_output*0;


%Smith 2006
% As=.992;
% Af=.59;
% Bf =.21;
% Bs=.02;

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
% Joiner&Smith 2008
% As=.998;
% Af=.85;
% Bf =.11;
% Bs=.021;

% Reza
% As=.988;
% Af=.85;
% Bf =.08;
% Bs=.04;


As=0.9836;
Af=0.8192;
Bf=0.2103;
Bs=0.0348;

A=[As 0;0, Af];
B=[Bs;Bf];

 %R=(1/2)*10^-3;
R=0;
%R=0.1229*10^-3;
% Q=(sqrt(3)/2)*10^-4;
Q=0;
%Q=0.1229;

for nn=1:iteration;
    %
    [two_state_model_output_AL,slow_state_AL,fast_state_AL]=two_state_model_simulation_15_10_14(A,B,Q,R,ff_sudden);
    Abrupt_long_output(nn,:)=two_state_model_output_AL;
    Abrupt_long_slow(nn,:)=slow_state_AL;
    Abrupt_long_fast(nn,:)=fast_state_AL;
    % 
    [two_state_model_output_G,slow_state_G,fast_state_G]=two_state_model_simulation_15_10_14(A,B,Q,R,ff_gradual);
    Gradual_output(nn,:)=two_state_model_output_G;
    Gradual_slow(nn,:)=slow_state_G;
    Gradual_fast(nn,:)=fast_state_G;
end

AL_output=[Abrupt_long_output];
G_output=[Gradual_output];

J=(sqrt(3)/2)*10^-2;
%J=0.1229*10^-2;


AL_slow_ratio=(Abrupt_long_slow./Abrupt_long_output)+normrnd(0,J,iteration,N);
G_slow_ratio=Gradual_slow./Gradual_output+normrnd(0,J,iteration,N);

AL_ratio_norm=AL_slow_ratio./AL_slow_ratio;
G_ratio_norm=G_slow_ratio./AL_slow_ratio;


pval_trials=zeros(1,N); pval_coef=zeros(iteration,1);
hval_trials=pval_trials*0; hval_coef=pval_coef*0;
for kk=1:N
    
    [h1,p1]=ttest2(AL_slow_ratio(:,kk),G_slow_ratio(:,kk),0.05);
    pval_trials(kk)=p1;
    hval_trials(kk)=h1;
end
    
for j=1:iteration
    %[h,p]=ttest2(AL_ratio_norm(:,kk),G_ratio_norm(:,kk),0.05);
    [h2,p2]=ttest2(AL_slow_ratio(j,:),G_slow_ratio(j,:),0.05);
    
    pval_coef(j)=p2;
    hval_coef(j)=h2;
end


figure; hold on;
plot(nanmean(AL_slow_ratio),'linewidth',2);
plot(nanmean(G_slow_ratio),'linewidth',2);
set(gca,'xscale','log');
hold off;

figure; plot(nanmean(G_ratio_norm),'linewidth',2)
set(gca,'xscale','log');
end


function [two_state_model_output,slow_state,fast_state]=two_state_model_simulation_15_10_14(A,B,Q,R,F)
two_state_model_output=zeros(length(F),1);
slow_state=0*two_state_model_output;
fast_state=0*two_state_model_output;
% adaptation
for nn=1:length(F)-1
    current_output=slow_state(nn)+fast_state(nn);
    two_state_model_output(nn)=current_output;
    current_error=F(nn)-current_output;
    next_state=A*[slow_state(nn);fast_state(nn)]+B*current_error+normrnd(0,Q,2,1);
    slow_state(nn+1)=next_state(1,1);
    fast_state(nn+1)=next_state(2,1);
    two_state_model_output(nn+1)=sum(next_state)+normrnd(0,R,1,1);
end

end
























































