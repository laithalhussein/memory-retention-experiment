%% pFF fits

close all;
clear all;

load('pff_al_all_new.mat');
load('pff_as_all_new.mat');
load('pff_gl_all_new.mat');

iter_ = 2000;
ts_num = 2;
params_pff = nan(iter_,4,1);


%load indices
load('pff_ndx.mat');
% idx1 = idx_long(k);
% idx2 = idx_short(k);

pal_ndx = pal_ndx(2:end);
pgl_ndx = pgl_ndx(2:end);

%get the learning parts
pAL = pff_al_all_new(:,2:end);
pGL = pff_gl_all_new(:,2:end);
pAS = pff_as_all_new(:,2:end);

xx= 42;%number of trials

%make the schedules
%AL
temp_FF1= [ones(160,1);zeros(30,1)];
FF_al = temp_FF1;
FF_al(pal_ndx) = 0;
EC_al = ~FF_al;

TS{1}.FF = FF_al;
TS{1}.EC = EC_al;

%GL
FF_gl = min([1/15*(1:160).^(log(15)/log(145));ones(1,160)]);
FF_gl = [FF_gl'; zeros(30,1)];
FF_gl(pgl_ndx) = 0;
EC_gl = ~FF_gl;

TS{2}.FF = FF_gl;
TS{2}.EC = EC_gl;

% input = TS;
% subject_data = {pAL, pGL};

subject_data = {pAL};
input{1} = TS{1};

%try fits
[As_boot,Af_boot,Bs_boot,Bf_boot]=perform_bootstrap_on_data_2state_5_22_17(input,subject_data,iter_);
params_pff(:,:,1) = [As_boot,Af_boot,Bs_boot,Bf_boot];

%save('params_pff.mat','params_pff');


%%
clear all;
load('params_pff.mat');
load('params_vff.mat');

p_params = mean(params_pff(:,:,1));
v_params = mean(params_vff(:,:,1));

tt1 = [0.9839,0.7236,0.0364,0.2890];

tt2 = [0.9876, 0.7624, 0.034, 0.2095];

[p_slow,p_fast,p_overall] = run_two_state_model_simulation_5_23_2017(tt1);


[v_slow,v_fast,v_overall] = run_two_state_model_simulation_5_23_2017(tt2);


























