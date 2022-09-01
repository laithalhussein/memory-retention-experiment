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
idx1 = 11;
idx2 = 2;
AL_learn = AL_all(:, 1:idx1);
GL_learn = GL_all(:, 1:idx1);
AS_learn = AS_all(:, 1:idx2);

%get the EC indices
load('vff_ndx.mat');
% val_ndx = [val_ndx(1); floor(val_ndx(2:end)/2)];
% vgl_ndx = [vgl_ndx(1); floor(vgl_ndx(2:end)/2)];

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

%now do the bootrapping
iter_ = 1000;
data_all  = {AL_learn, GL_learn, AS_learn};
%data_all  = {AL_learn, GL_learn};

ts_num = 2;
params_vff = nan(iter_,4,ts_num);

input{1}.EC = TS{1}.EC;
input{1}.FF = TS{1}.FF;

input{2}.EC = TS{2}.EC;
input{2}.FF = TS{2}.FF;

input{3}.EC = TS{3}.EC;
input{3}.FF = TS{3}.FF;

subject_data = data_all;
for k=1:ts_num
%     input{1}.EC = TS{k}.EC;
%     input{1}.FF = TS{k}.FF;
%     subject_data = data_all{k};
    
    %try fits
    [As_boot,Af_boot,Bs_boot,Bf_boot]=perform_bootstrap_on_data_2state_5_22_17(input,subject_data,iter_);
    params_vff(:,:,k) = [As_boot,Af_boot,Bs_boot,Bf_boot];
end

save('params_vff2.mat','params_vff');


%% pFF fits
load('pff_al_all_new.mat');
load('pff_as_all_new.mat');
load('pff_gl_all_new.mat');

%load indices
load('pff_ndx.mat');
idx1 = 12;
idx2 = 3;

%get the learning parts
pAL_learn = pff_al_all_new(:,2:idx1);
pGL_learn = pff_gl_all_new(:,2:idx1);
pAS_learn = pff_as_all_new(:,2:idx2);

%fix AL and Gl indices
xx = pal_ndx(idx1);
pal_ndx = pal_ndx(2:find(pal_ndx==xx));

yy = pgl_ndx(idx1);
pgl_ndx = pgl_ndx(2:find(pgl_ndx==yy));

%make the schedules
%AL
temp_FF1= ones(xx,1);
FF_al = temp_FF1;
FF_al(pal_ndx) = 0;
EC_al = ~FF_al;

TS{1}.FF = FF_al;
TS{1}.EC = EC_al;

%GL
FF_gl = min([1/15*(1:yy).^(log(15)/log(145));ones(1,yy)]);
FF_gl(pgl_ndx) = 0;
EC_gl = ~FF_gl;

TS{2}.FF = FF_gl;
TS{2}.EC = EC_gl;

input = TS;

subject_data = {pAL_learn, pGL_learn};
iter_ = 1000;
ts_num = 2;
params_pff = nan(iter_,4,2);

for k=1:ts_num
%     input{1}.EC = TS{k}.EC;
%     input{1}.FF = TS{k}.FF;
%     subject_data = data_all{k};
    
    %try fits
    [As_boot,Af_boot,Bs_boot,Bf_boot]=perform_bootstrap_on_data_2state_5_22_17(input,subject_data,iter_);
    params_pff(:,:,k) = [As_boot,Af_boot,Bs_boot,Bf_boot];
end

save('params_pff2.mat','params_pff');

































