function [As_boot,Af_boot,Bs_boot,Bf_boot]=perform_bootstrap_on_data_2state_5_22_17(input,subject_data,iteration)
%changed to accomodate fitting on all datasets at once

AL = subject_data{1};

if length(subject_data)>1
    GL = subject_data{2};
    AS = subject_data{3};
else
    GL = [];
    AS = [];
end

%model_est_boot=[];
boot_strap_data1=[];             boot_strap_ndx1=[];
boot_strap_data2=[];             boot_strap_ndx2=[];
boot_strap_data3 = [];

As_boot=zeros(iteration,1);      Af_boot=zeros(iteration,1);      Bs_boot=zeros(iteration,1);      Bf_boot=zeros(iteration,1);

warning('off','all');
for nn=1:iteration 

    %AL
    [boot_strap_sample1,b1] = shuffle_data(AL);
    boot_strap_data1=[boot_strap_data1,boot_strap_sample1];
    %boot_strap_ndx1=[boot_strap_ndx1,b1]; %the subject, not the data, indeces
    
    %GL
    if length(subject_data)>1
        [boot_strap_sample2,b2] = shuffle_data(GL);
        boot_strap_data2=[boot_strap_data2,boot_strap_sample2];
        %boot_strap_ndx2=[boot_strap_ndx2,b2]; %the subject, not the data, indeces
        
        [boot_strap_sample3,b3] = shuffle_data(AS);
        boot_strap_data3=[boot_strap_data3,boot_strap_sample3];
    else
        boot_strap_sample2 = [];
        boot_strap_sample3 = [];
    end
    
    final_sample = [boot_strap_sample1; boot_strap_sample2; boot_strap_sample3];
    
    [Af,Bf,As,Bs,~]=calculate_2state_fit_for_data_5_22_2017(input,final_sample,[]);
    
%     try 
%         [Af,Bf,As,Bs,~]=calculate_2state_fit_for_data_2_25_2016(input,boot_strap_sample,[]);
%     catch
%         keyboard;
%     end
    
    As_boot(nn,1)=As;
    Af_boot(nn,1)=Af;
    Bs_boot(nn,1)=Bs;
    Bf_boot(nn,1)=Bf;
    
    %bb=[Af,Bf,As,Bs];
    %model_est_boot=[model_est_boot,twostatesimfit_V2(bb,input)];
end

end
