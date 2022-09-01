%%
clear all;
%v_params = mean(params_vff(:,:,1));

%AL, GL, and AS fits

tt = [0.9876, 0.7624, 0.034, 0.2095]; %all schedules

old_tt = [0.9836, 0.8192, 0.0248, 0.2216]; %old AL only
gl_tt = [0.8803,0.7280, 0.1679,0.6957]; %gl_tt

al_gl_tt = [0.9861,0.7722,0.0330,0.2130];

as_tt = [0.9425,0.3878,0.0682 ,0.1504];

as_al_tt = [0.965, 0.503, .046, 0.18];

as_gl_tt = [0.9114, 0.5579, 0.118, 0.42];

al_tt = [0.9816,0.5862,0.0288,0.1867];

alnew_tt = [0.9926    0.5880    0.0286    0.1916]

% As = params(1); Af = params(2); Bs = params(3); Bf = params(4);
% As=.992;
% Af=.59;
% Bf =.21;
% Bs=.02;

q = lsqnonlin(@twostatesimfit_V4, [0.6 0.2 0.992 0.02]);
qq = [q(3), q(1), q(4), q(2)];


% [v_slow_old,v_fast_old,v_overall_old] = run_two_state_model_simulation_5_23_2017(old_tt);
% [v_slow_new,v_fast_new,v_overall_new] = run_two_state_model_simulation_5_23_2017(tt);
% 
% 
% [v_slow2,v_fast2,v_overall2] = run_two_state_model_simulation_5_23_2017(gl_tt);
% gl_frac = v_slow2.al(160) / v_overall2.al(160)
% 
% [v_slow3,v_fast3,v_overall3] = run_two_state_model_simulation_5_23_2017(al_gl_tt);
% al_gl_frac = v_slow3.al(160) / v_overall3.al(160)
% 
% [v_slow4,v_fast4,v_overall4] = run_two_state_model_simulation_5_23_2017(as_tt);
% as_frac = v_slow4.al(160) / v_overall4.al(160)
% 
% [v_slow5,v_fast5,v_overall5] = run_two_state_model_simulation_5_23_2017(as_al_tt);
% as_al_frac = v_slow5.al(160) / v_overall5.al(160)
% 
% [v_slow6,v_fast6,v_overall6] = run_two_state_model_simulation_5_23_2017(as_gl_tt);
% as_gl_frac = v_slow6.al(160) / v_overall6.al(160)
% 
% [v_slow7,v_fast7,v_overall7] = run_two_state_model_simulation_5_23_2017(al_tt);
% al_frac = v_slow7.al(160) / v_overall7.al(160)
% 
% [v_slow8,v_fast8,v_overall8] = run_two_state_model_simulation_5_23_2017(alnew_tt);
% al_frac2 = v_slow8.al(160) / v_overall8.al(160)


[v_slowq,v_fastq,v_overallq] = run_two_state_model_simulation_5_23_2017(qq);
al_frac2 = v_slowq.al(160) / v_overallq.al(160)

figure; hold on;
plot(v_slow7.al,'linestyle','-','color',[0.5,0.5,0.5]);
plot(v_fast7.al,'linestyle','-','color','k');
plot(v_overall7.al,'linestyle','-','color','r');


% close all; figure; hold on;
% 
% plot(v_slow_old.al,'linestyle','--','color',[0.5,0.5,0.5]);
% plot(v_fast_old.al,'linestyle','--','color','k');
% plot(v_overall_old.al,'linestyle','--','color','r');
% 
% plot(v_slow_new.al,'linestyle','-','color',[0.5,0.5,0.5]);
% plot(v_fast_new.al,'linestyle','-','color','k');
% plot(v_overall_new.al,'linestyle','-','color','r');
% 
% corr1=corrcoef(v_overall_old.al,v_overall_new.al);
% Rsq = corr1(1,2)^2
% 
% corr2=corrcoef(v_slow_old.al,v_slow_new.al);
% Rsq2 = corr2(1,2)^2
% 
% corr3=corrcoef(v_fast_old.al,v_fast_new.al);
% Rsq3 = corr3(1,2)^2