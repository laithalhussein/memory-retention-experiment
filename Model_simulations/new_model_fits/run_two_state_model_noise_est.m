function [slow,fast,overall] = run_two_state_model_noise_est(params, F_flag)


%close all 
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
curve_width=2;
iteration=2;
%
 wash_period_abrupt_long=[176,235];
%wash_period_abrupt_long=[61,180];
F_abrupt_long=[zeros(15,1);ones(160,1)];
% F_abrupt_long=[zeros(10,1);ones(50,1)];
Abrupt_long_output=zeros(iteration,wash_period_abrupt_long(end));
Abrupt_long_slow=Abrupt_long_output*0;
Abrupt_long_fast=Abrupt_long_output*0;

F_abrupt_short=[zeros(15,1);ones(15,1)];
wash_period_abrupt_short=[31,90];
Abrupt_short_output=zeros(iteration,wash_period_abrupt_short(end));
Abrupt_short_slow=Abrupt_short_output*0;
Abrupt_short_fast=Abrupt_short_output*0;

if F_flag
    F_gradual=[zeros(15,1);min([1/15*(1:160).^(log(15)/log(145));ones(1,160)])'];
else
    F_gradual=[zeros(15,1);min([1/45*(1:160).^(log(45)/log(145));ones(1,160)])'];
end

%F_gradual=[zeros(9,1);linspace(0,1,16)';ones(5,1)];
 wash_period_gradual=[176,235]; %should end at 235
%wash_period_gradual=[31,90];
Gradual_output=zeros(iteration,wash_period_gradual(end));
Gradual_slow=Gradual_output*0;
Gradual_fast=Gradual_output*0;


% simulate abrupt long 
R_ratio=0.1:0.03:.6;

As = params(1); Af = params(2); Bs = params(3); Bf = params(4);

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

%PREVIOUS GOOD PARAMETER BOOTSTRAP RESULTS
% As=0.9836;
% Af=0.8192;
% Bf=0.2216;
% Bs=0.0248;

% tt2 = [0.9876, 0.7624, 0.034, 0.2095];


%NEW BOOTSTRAP RESULTS
% As=0.9847;
% Af=0.8013;
% Bf=0.1177;
% Bs=0.0399;

A=[As 0;0, Af];
B=[Bs;Bf];

% R=1e-2;
%  Q=sqrt(3)*10^-2;
R=0;
Q=0;

for nn=1:iteration;
    %
    [two_state_model_output_AL,slow_state_AL,fast_state_AL]=two_state_model_simulation_15_10_14(A,B,Q,R,F_abrupt_long,wash_period_abrupt_long);
    Abrupt_long_output(nn,:)=two_state_model_output_AL;
    Abrupt_long_slow(nn,:)=slow_state_AL;
    Abrupt_long_fast(nn,:)=fast_state_AL;
    % 
    [two_state_model_output_AS,slow_state_AS,fast_state_AS]=two_state_model_simulation_15_10_14(A,B,Q,R,F_abrupt_short,wash_period_abrupt_short);
    Abrupt_short_output(nn,:)=two_state_model_output_AS;
    Abrupt_short_slow(nn,:)=slow_state_AS;
    Abrupt_short_fast(nn,:)=fast_state_AS;
    % 
    [two_state_model_output_G,slow_state_G,fast_state_G]=two_state_model_simulation_15_10_14(A,B,Q,R,F_gradual,wash_period_gradual);
    Gradual_output(nn,:)=two_state_model_output_G;
    Gradual_slow(nn,:)=slow_state_G;
    Gradual_fast(nn,:)=fast_state_G;
end

overall.al  = two_state_model_output_AL;
slow.al = slow_state_AL;
fast.al= fast_state_AL;

overall.gl  = two_state_model_output_G;
slow.gl = slow_state_G;
fast.gl= fast_state_G;

overall.as  = two_state_model_output_AS;
slow.as = slow_state_AS;
fast.as= fast_state_AS;


% run comparision between cases
% idx_comp = 19;
% %%%%late
% Abrupt_short_late_wash=Abrupt_short_output(:,end-idx_comp:end);
% Abrupt_long_late_wash=Abrupt_long_output(:,end-idx_comp:end);
% Gradual_late_wash=Gradual_output(:,end-idx_comp:end);

%%%%early
% ret_idx = 175;
% Abrupt_short_late_wash=Abrupt_short_output(:,31:31 + 20);
% Abrupt_long_late_wash=Abrupt_long_output(:,ret_idx:ret_idx + 20);
% Gradual_late_wash=Gradual_output(:,ret_idx:ret_idx + 20);
% 
% %
% data_late_wash_all={Abrupt_short_late_wash(:),Abrupt_long_late_wash(:),Gradual_late_wash(:)};
% %
% fit_data_late_wash_ave_all=cellfun(@nanmean,data_late_wash_all);
% %
% fit_data_late_wash_sd_all=cellfun(@nanstd,data_late_wash_all);
% %
% [h_matrix_fit_late_wash_all,p_matrix_fit_late_wash_all]=calculate_t_test_for_subject_data_13_07_14(data_late_wash_all);
% %% Normalized%%
% %%late
% % Abrupt_short_late_wash_norm=Abrupt_short_output(:,end-idx_comp:end)'/diag(Abrupt_short_output(:,end-59));
% % Abrupt_long_late_wash_norm=Abrupt_long_output(:,end-idx_comp:end)'/diag(Abrupt_long_output(:,end-59));
% % Gradual_late_wash_norm=Gradual_output(:,end-idx_comp:end)'/diag(Gradual_output(:,end-59));
% 
% %early
% Abrupt_short_late_wash_norm=Abrupt_short_output(:,end-59:end-59 + 20)'/diag(Abrupt_short_output(:,end-59));
% Abrupt_long_late_wash_norm=Abrupt_long_output(:,end-59:end-59 + 20)'/diag(Abrupt_long_output(:,end-59));
% Gradual_late_wash_norm=Gradual_output(:,end-59:end-59 + 20)'/diag(Gradual_output(:,end-59));
% 
% %
% data_late_wash_all_norm={Abrupt_long_late_wash_norm(:),Gradual_late_wash_norm(:),Abrupt_short_late_wash_norm(:)};
% %
% fit_data_late_wash_ave_all_norm=cellfun(@nanmean,data_late_wash_all_norm);
% %
% fit_data_late_wash_sd_all_norm=cellfun(@nanstd,data_late_wash_all_norm);
% %
% [h_matrix_fit_late_wash_all_norm,p_matrix_fit_late_wash_all_norm]=calculate_t_test_for_subject_data_13_07_14(data_late_wash_all_norm);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%close all;

end