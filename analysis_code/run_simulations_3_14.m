close all;
clear all;

[AL_model,GL_model,h_v2,p_v2,m1_v2,m2_v2,Ar_v2,Br_v2]=run_2_state_model_gs_V2;
save('AL_model_v2.mat','AL_model');
save('GL_model_v2.mat','GL_model');
save('h_v2.mat','h_v2');
save('p_v2.mat','p_v2');
save('m1_v2.mat','m1_v2');
save('m2_v2.mat','m2_v2');
save('Ar_v2.mat','Ar_v2');
save('Br_v2.mat','Br_v2');

% [Am,Gm,h_v1,p_v1,m1,m2]=run_2_state_model_gs;
% 
% save('Am.mat','Am');
% save('Gm.mat','Gm');
% save('h_v1.mat','h_v1');
% save('p_v1.mat','p_v1');
% save('m1.mat','m1');
% save('m2.mat','m2');


%%
load('AL_model_v2.mat')
load('GL_model_v2.mat')
load('h_v2.mat');
load('p_v2.mat');
load('m1_v2.mat');
load('m2_v2.mat');
load('Ar_v2.mat');
load('Br_v2.mat');

% [~,num_iter]=size(h_v2);
% min_diff=find(sum(h_v2,2)==num_iter,1,'first');