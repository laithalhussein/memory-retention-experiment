function res = model_sim_2state_0102_2019(params)

%IMPORTANT: this code is set up to return residuals!!!

%% velocity
load GL_all;
load AL_all;
load AS_all;

AL_all = window_as(AL_all);
AS_all = window_as(AS_all);
GL_all = window_as(GL_all);

%get the learning parts
idx_long = 11;
idx_short = 2;


%get the EC indices
load('vff_ndx.mat');
idx1 = idx_long;
idx2 = idx_short;

AL_learn = AL_all(:, 1:idx1);
GL_learn = GL_all(:, 1:idx1);
AS_learn = AS_all(:, 1:idx2);

overall_AL = nanmean(AL_learn);
overall_GL = nanmean(GL_learn);
overall_AS = nanmean(AS_learn);

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

%as_learn = AL_learn(:,1:4);
%subject_data = {as_learn};

TS{3}.FF = FF_as;
TS{3}.EC = EC_as;

input{1}.EC = TS{1}.EC;
input{1}.FF = TS{1}.FF;

input{2}.EC = TS{2}.EC;
input{2}.FF = TS{2}.FF;

% input{3}.EC = TS{3}.EC;
% input{3}.FF = TS{3}.FF;

% data1 = [overall_AL';overall_GL';overall_AS'];
data1 = [overall_AL';overall_GL'];
%data1 = [overall_AL'];


%% position

%NOTE: tried to access the below on 1/12/2018, but couldnt find the "new" version...?
% load('pff_al_all_new.mat');
% load('pff_as_all_new.mat');
% load('pff_gl_all_new.mat');
% 
% idx_long = 13;
% idx_short = 4;
% 
% %load indices
% load('pff_ndx.mat');
% idx1 = idx_long;
% idx2 = idx_short;
% 
% % pal_ndx = [2,16,31,46,62,76,91,105,121,136,152,160];
% % pgl_ndx = pal_ndx;
% 
% % pal_ndx =pal_ndx+2;
% % pgl_ndx = pgl_ndx+2;
% 
% start_ = 1;
% 
% if start_==1. pal_ndx = pal_ndx+2; pgl_ndx=pgl_ndx+2; end
% 
% %get the learning parts
% pAL_learn = pff_al_all_new(:,start_:idx1);
% pGL_learn = pff_gl_all_new(:,start_:idx1);
% pAS_learn = pff_as_all_new(:,2:idx2);
% 
% overall_pal = nanmean(pAL_learn);
% overall_pgl = nanmean(pGL_learn);
% overall_pas = nanmean(pAS_learn);
% 
% %fix AL and Gl indices
% xx = pal_ndx(idx1);
% pal_ndx = pal_ndx(start_:find(pal_ndx==xx));
% 
% yy = pgl_ndx(idx1);
% pgl_ndx = pgl_ndx(start_:find(pgl_ndx==yy));
% 
% %make the schedules
% %AL
% temp_FF1= ones(xx,1);
% FF_al = temp_FF1;
% FF_al(pal_ndx) = 0;
% EC_al = ~FF_al;
% 
% TS{1}.FF = FF_al;
% TS{1}.EC = EC_al;
% 
% %GL
% FF_gl = min([1/15*(1:yy).^(log(15)/log(145));ones(1,yy)]);
% FF_gl(pgl_ndx) = 0;
% EC_gl = ~FF_gl;
% 
% TS{2}.FF = FF_gl;
% TS{2}.EC = EC_gl;
% 
% %AS
% pas_ndx = pas_ndx(2:end);
% 
% temp_FF3 = ones(15,1);
% FF_as = temp_FF3;
% FF_as(pas_ndx) = 0;
% EC_as = ~FF_as;
% 
% TS{3}.FF = FF_as;
% TS{3}.EC = EC_as;
% 
% %save input
% input{1}.EC = TS{1}.EC;
% input{1}.FF = TS{1}.FF;
% 
% input{2}.EC = TS{3}.EC;
% input{2}.FF = TS{3}.FF;
% % 
% % input{3}.EC = TS{3}.EC;
% % input{3}.FF = TS{3}.FF;
% 
% % input{2}.EC = TS{2}.EC;
% % input{2}.FF = TS{2}.FF;
% 
% % input{1}.EC = TS{2}.EC;
% % input{1}.FF = TS{2}.FF;
% 
% %collect the data
% %data1 = [overall_pal'; overall_pgl'; overall_pas'];
% % data1 = [overall_pas'];
%  data1 = [overall_pal'; overall_pas'];

%% do the fit

%Smith 2006
% As=.992;
% Af=.59;
% Bf =.21;
% Bs=.02;

dat = input;

Af=params(1); Bf=params(2); As=params(3); Bs=params(4);

[xslow,xfast,xtot] = deal([]);

for k1 = 1 : length(dat),
    
%     if k1==3, keyboard; end
    
    EC = dat{k1}.EC;
    FF = dat{k1}.FF;
    ii = find(EC);
    
    N = length(FF);
    [xf,xs,e] = deal(zeros(N,1));
    
    for k = 1:N-1,
        if EC(k)
            e(k) = 0;
        else
            e(k) = FF(k)-xf(k)-xs(k);
        end
        xf(k+1) = Af*xf(k)+Bf*e(k);
        xs(k+1) = As*xs(k)+Bs*e(k);
    end
    
    e(N) = 1-xf(N)-xs(N);
    
    xtot = [xtot;xs(ii)+xf(ii)];
    xslow = [xs;xs(ii)];
    xfast = [xf;xf(ii)];
    
    %save('xf_error','xf')
end

x1 = [xtot];% xfast xslow];

res = x1 - data1;

return