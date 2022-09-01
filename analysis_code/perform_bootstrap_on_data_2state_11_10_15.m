function [As_boot,Af_boot,Bs_boot,Bf_boot]=perform_bootstrap_on_data_2state_11_10_15(input,subject_data,iteration)
%NOTE: Add option for parametric bootstrap: shuffle residuals within each subject (for a better estimate of that subject's parameters) and then shuffle across subjects 

[~,num_trials]=size(subject_data);
trials=[1:num_trials]';

model_est_boot=[];
boot_strap_data=[];             boot_strap_ndx=[];
As_boot=zeros(iteration,1);      Af_boot=zeros(iteration,1);      Bs_boot=zeros(iteration,1);      Bf_boot=zeros(iteration,1);
warning('off','all');
for nn=1:iteration 
    boot_strap_sample=nan;
    while sum(isnan(boot_strap_sample))
        b=randsample(size(subject_data,1),size(subject_data,2),'true'); %randomly sampling, w/ replacement, the subjects that will determine the bootstrap sample
        boot_strap_sample=diag(subject_data(b,:)); %obtaining the bootsrap sample from the data. Diag works since we arranged it so that we want the first data point 
                                                   %from the 1st subject, the second point from the second subject, etc...
    end
    boot_strap_data=[boot_strap_data,boot_strap_sample];
    boot_strap_ndx=[boot_strap_ndx,b]; %the subject, not the data, indeces
    %[Af,Bf,As,Bs,~]=calculate_2state_fit_for_data_11_04_15(input,boot_strap_sample,[]);
    %[Af,Bf,As,Bs,~]=calculate_2state_fit_for_data_11_04_15(input,boot_strap_sample,[0 0.2 0 0.02]); %for decay only
    
    [Af,Bf,As,Bs,~]=calculate_2state_fit_for_data_2_25_2016(input,boot_strap_sample,[]);
    
%     try 
%         [Af,Bf,As,Bs,~]=calculate_2state_fit_for_data_2_25_2016(input,boot_strap_sample,[]);
%     catch
%         keyboard;
%     end
    
    As_boot(nn,1)=As;
    Af_boot(nn,1)=Af;
    Bs_boot(nn,1)=Bs;
    Bf_boot(nn,1)=Bf;
    b=[Af,Bf,As,Bs];
    %model_est_boot=[model_est_boot,twostatesimfit_V2(b,input)];
end
%model_est=mean(model_est_boot,2);
%figure; plot(model_est)
% mean(As_boot)
% mean(Af_boot)
% mean(Bs_boot)
% mean(Bf_boot)
end
