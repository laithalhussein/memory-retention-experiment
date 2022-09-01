%Equating durations and training
close all 
clear all 
home
%%

abrupt_short_adapt_color=[0,0,256]/256;
abrupt_long_adapt_color=[256,0,0]/256;
gradual_adapt_color=[0,256,0]/256;

abrupt_short_adapt_shade=[120,120,256]/256;
abrupt_long_adapt_shade=[256,120,120]/256;
gradual_adapt_shade=[120,256,120]/256;

early_wash_shade=[230,230,230]/256;
mid_wash_shade=[210,210,210]/256;
late_wash_shade=[190,190,190]/256;

washout_color_abrupt_short=[0,0,256]/256;
washout_color_abrupt_long=[256,0,0]/256;
washout_color_gradual=[0,256,0]/256;
adaptation_color=[256,256,256]/256;
Field_ref_shade=[175,175,175]/256;
%
y=-0.2:.2:1.01;
early_wash_st=10;
mid_wash_st=30;
window_length=10;
curve_width=1.5;
iteration=1;
decay_trials=60; %number of decay trials
%

%parameters-Smith et al. 2006 (which to use?)
% As=.992;
% Af=.59;
% Bf =.21;
% Bs=.02;

% Reza
% As=.988;
% Af=.85;
% Bf =.08;
% Bs=.04;

%bootstrapped, w/ decay
As=0.9797;
Af=0.6798;
Bf=0.5562;
Bs=0.0225;

durations=[10:10:200];

% Abrupt_long_output=cell(length(durations),1);   Abrupt_long_slow=cell(length(durations),1);   Abrupt_long_fast=cell(length(durations),1);
% Gradual_long_output=cell(length(durations),1);  Gradual_long_slow=cell(length(durations),1);  Gradual_long_fast=cell(length(durations),1);

%Using Reza's long training schedules
for i=1:length(durations)
    F_AL=[zeros(10,1);ones(durations(i),1)];
    F_GL_linear=[zeros(9,1);linspace(0,1,durations(i)-5+1)';ones(5,1)];
    %put log case
    AL_training{i}=F_AL;
    GL_training{i}=F_GL_linear;
    decay_onset(i)=durations(i)+11;
    decay_period(i,:)=[decay_onset(i),decay_onset(i)+decay_trials-1];
    
%     Abrupt_long_output{i,1}=zeros(iteration,decay_period(i,end));
%     Abrupt_long_slow{i,1}=zeros(iteration,decay_period(i,end));
%     Abrupt_long_fast{i,1}=zeros(iteration,decay_period(i,end));
%     
%     Gradual_long_output{i,1}=zeros(iteration,decay_period(i,end));
%     Gradual_long_slow{i,1}=zeros(iteration,decay_period(i,end));
%     Gradual_long_fast{i,1}=zeros(iteration,decay_period(i,end));
    
end

A=[As 0;0, Af];
B=[Bs;Bf];

R=0;
%R=0;
% Q=sqrt(3)*10^-2*0;
Q=0;

for k=1:length(durations)
    for nn=1:iteration;
        %
        [two_state_model_output_AL,slow_state_AL,fast_state_AL]=two_state_model_simulation_15_10_14(A,B,Q,R,AL_training{k},decay_period(k,:));
        Abrupt_long_output{k,nn}=two_state_model_output_AL;
        Abrupt_long_slow{k,nn}=slow_state_AL;
        Abrupt_long_fast{k,nn}=fast_state_AL;
        
        %
        [two_state_model_output_G,slow_state_G,fast_state_G]=two_state_model_simulation_15_10_14(A,B,Q,R,GL_training{k},decay_period(k,:));
        Gradual_long_output{k,nn}=two_state_model_output_G;
        Gradual_long_slow{k,nn}=slow_state_G;
        Gradual_long_fast{k,nn}=fast_state_G;
    end
end


%check
% dat=cell2mat(Gradual_long_output(5,:));
% d=nanmean(dat,2);
% plot(d)

for j=1:length(durations)
    AL_output_all{j}=cell2mat(Abrupt_long_output(j,:));
    AL_slow_all{j}=cell2mat(Abrupt_long_slow(j,:));
    AL_fast_all{j}=cell2mat(Abrupt_long_fast(j,:));
    
    AL_output_avg{j}=nanmean(AL_output_all{j},2);
    AL_slow_avg{j}=nanmean(AL_slow_all{j},2);
    AL_fast_avg{j}=nanmean(AL_fast_all{j},2);
    
    GL_output_all{j}=cell2mat(Gradual_long_output(j,:));
    GL_slow_all{j}=cell2mat(Gradual_long_slow(j,:));
    GL_fast_all{j}=cell2mat(Gradual_long_fast(j,:));
    
    GL_output_avg{j}=nanmean(GL_output_all{j},2);
    GL_slow_avg{j}=nanmean(GL_slow_all{j},2);
    GL_fast_avg{j}=nanmean(GL_fast_all{j},2);
    
    %ratios
    AL_slow_rat{j}=AL_slow_avg{j}./AL_output_avg{j};
    GL_slow_rat{j}=GL_slow_avg{j}./GL_output_avg{j};
   
%     x(j)=trapz(AL_slow_avg{j})/trapz(AL_output_avg{j});
%     g(j)=trapz(GL_slow_avg{j})/trapz(GL_output_avg{j});
end
    
    percent_trials=[0.2:-0.0025:0.005];
    
group_i_output_AL=AL_output_avg{2}; %20 training trials
% group_i_slow_AL=AL_output_avg{2};

group_ii_output_GL=GL_output_avg{5}; %50 training trials
% group_ii_slow_GL=GL_slow_avg{5};

figure; 
plot(group_i_output_AL,'linewidth',3);
hold on;
plot(group_ii_output_GL,'linewidth',3,'color','r');

figure; hold on;
plot(AL_slow_rat{2},'b.')
plot(GL_slow_rat{5},'r.');

figure; hold on;
plot(AL_slow_rat{end},'b.')
plot(GL_slow_rat{end},'r.');