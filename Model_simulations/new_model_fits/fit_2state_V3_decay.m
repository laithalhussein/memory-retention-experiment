%get 2-state fits using ALL the data for pff and vff
close all;
clear all;

%start with vFF
load GL_all;
load AL_all;
load AS_all;

AL_all = window_as(AL_all);
AS_all = window_as(AS_all);
GL_all = window_as(GL_all);

%get the learning parts
idx_long = [11,12];
idx_short = [2,2];

%bootstrap
iter_ = 20000;
ts_num = 2;
params_vff = nan(iter_,4,ts_num);

for k=1:ts_num
    %get the EC indices
    load('vff_ndx.mat');
    idx1 = idx_long(k);
    idx2 = idx_short(k);
    
%     input{1}.EC = TS{k}.EC;
%     input{1}.FF = TS{k}.FF;
%     subject_data = data_all{k};

    AL_learn = AL_all(:, 1:idx1);
    GL_learn = GL_all(:, 1:idx1);
    AS_learn = AS_all(:, 1:idx2);
    
    % data_all  = {AL_learn, GL_learn, AS_learn};
    data_all  = {AL_learn, GL_learn};
    
    subject_data = data_all;

    %create struct that contains each training schedule's info
    %e.g.
    % learning_ndx=zeros(80,1);
    % learning_ndx(NDX)=1;
    % input{1}.EC=learning_ndx;
    % % nff=ones(80,1);
    % % nff(indc)=0;
    % input{1}.FF = ~learning_ndx;

    %AL
    xx = val_ndx(idx1);
    val_ndx = val_ndx(1:find(val_ndx==xx));
    temp_FF1= ones(xx,1);

    FF_al = temp_FF1;
    FF_al(val_ndx) = 0;
    EC_al = ~FF_al;

    TS{1}.FF = FF_al;
    TS{1}.EC = EC_al;

    %GL
    yy = vgl_ndx(idx1);
    vgl_ndx = vgl_ndx(1:find(vgl_ndx==yy));

    FF_gl = min([1/15*(1:yy).^(log(15)/log(145));ones(1,yy)]);
    FF_gl(vgl_ndx) = 0;
    EC_gl = ~FF_gl;
    %pert_gl = ff_log(1:2:end);

    TS{2}.FF = FF_gl;
    TS{2}.EC = EC_gl;

    %AS
    temp_FF3 = ones(15,1);
    FF_as = temp_FF3;
    FF_as(vas_ndx) = 0;
    EC_as = ~FF_as;

    TS{3}.FF = FF_as;
    TS{3}.EC = EC_as;

    input{1}.EC = TS{1}.EC;
    input{1}.FF = TS{1}.FF;

    input{2}.EC = TS{2}.EC;
    input{2}.FF = TS{2}.FF;

    %try fits
    [As_boot,Af_boot,Bs_boot,Bf_boot]=perform_bootstrap_on_data_2state_5_22_17(input,subject_data,iter_);
    params_vff(:,:,k) = [As_boot,Af_boot,Bs_boot,Bf_boot];
end

save('params_vff.mat','params_vff');


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
temp_FF1= [ones(xx-30,1);zeros(30,1)];
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


% [v_slow,v_fast,v_overall] = run_two_state_model_simulation_5_23_2017(tt2);


























