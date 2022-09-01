function [t_boot,a_boot,b_boot,unlearning_est]=perform_bootstrap_on_data_30_07_14_v2(subject_data,iteration)
decay_trials=[1:60]';
boot_strap_data=[];             boot_strap_ndx=[];
t_boot=zeros(iteration,1);      a_boot=zeros(iteration,1);      b_boot=zeros(iteration,1);
warning('off','all');
for nn=1:iteration

    for mm=1:length(decay_trials);
            boot_strap_val=[nan];
        while sum(isnan(boot_strap_val))
            b=randi(size(subject_data,1));
            boot_strap_val=subject_data(b,mm);
        end
        boot_strap_sample(mm,1)=boot_strap_val;
        ndx(mm,1)=b;
    end
    boot_strap_data=[boot_strap_data,boot_strap_sample];
    boot_strap_ndx=[boot_strap_ndx,ndx];
    [fit_to_decay_boot,~,~]=calculate_exp_fit_for_data_30_07_14(decay_trials,boot_strap_sample);
    t_boot(nn,1)=fit_to_decay_boot.t;
    a_boot(nn,1)=fit_to_decay_boot.a;
    b_boot(nn,1)=fit_to_decay_boot.b;
end
unlearning_est=(mean(a_boot)-mean(b_boot))*exp(-decay_trials/mean(t_boot))+mean(b_boot)*(decay_trials*0+1);
end