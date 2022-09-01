%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Average Subject Data,
% Copyright (C) 2014 Eghbal Hosseini and Katrina Nguyen
% Not for commmercial use.
% Redistribution and/or modification of code should be validated by authors
% under the terms of the Sensorimotor Integration Laboratory code of
% ethics.
% All violators will be prosecuted by law.
% All correspondance shoud be addressed to the authors.
% Authors are not held responsible for code malfunction.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [dat_all,info_all]=average_sub_data_position_velocity_revision_14_04_2015_LA(Cdr,sym_window,test_window,washout_window,force_source,condition)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Maximum_allowable_force=7;
% search folder for all crunched data files.
if ispc
    d=dir([Cdr,'\S*.mat']);
else
    d=dir([Cdr,'/S*.mat']);
end
num_of_subjects=length(d);

velexp_base_EC_NDX=[];  velexp_test_EC_NDX=[];  velexp_wash_EC_NDX=[];
posexp_base_EC_NDX=[];  posexp_test_EC_NDX=[];  posexp_wash_EC_NDX=[];

 velexp_test_EC_Nums=[];  velexp_wash_EC_Nums=[];
 posexp_test_EC_Nums=[];  posexp_wash_EC_Nums=[];

force_velexp_base_all=[];velocity_velexp_base_all=[];position_velexp_base_all=[];
force_velexp_test_all=[];velocity_velexp_test_all=[];position_velexp_test_all=[];
force_velexp_wash_all=[];velocity_velexp_wash_all=[];position_velexp_wash_all=[];
force_velexp_1st_wash_all=[];   velocity_velexp_1st_wash_all=[];    position_velexp_1st_wash_all=[];

force_posexp_base_all=[];velocity_posexp_base_all=[];position_posexp_base_all=[];
force_posexp_test_all=[];velocity_posexp_test_all=[];position_posexp_test_all=[];
force_posexp_wash_all=[];velocity_posexp_wash_all=[];position_posexp_wash_all=[];
force_posexp_1st_wash_all=[];   velocity_posexp_1st_wash_all=[];    position_posexp_1st_wash_all=[];

% temporary cells for storing the data
% velocity test
Force_velexp_window_base=cell(100,1);   Velocity_velexp_window_base=cell(100,1);    Position_velexp_window_base=cell(100,1);
Force_velexp_window_test=cell(100,1);   Velocity_velexp_window_test=cell(100,1);    Position_velexp_window_test=cell(100,1);
Force_velexp_window_wash=cell(100,1);   Velocity_velexp_window_wash=cell(100,1);    Position_velexp_window_wash=cell(100,1);
Force_velexp_1st_wash=cell(100,1);      Velocity_velexp_1st_wash=cell(100,1);       Position_velexp_1st_wash=cell(100,1);

% position test
Force_posexp_window_base=cell(100,1);   Velocity_posexp_window_base=cell(100,1);    Position_posexp_window_base=cell(100,1);
Force_posexp_window_test=cell(100,1);   Velocity_posexp_window_test=cell(100,1);    Position_posexp_window_test=cell(100,1);
Force_posexp_window_wash=cell(100,1);   Velocity_posexp_window_wash=cell(100,1);    Position_posexp_window_wash=cell(100,1);
Force_posexp_1st_wash=cell(100,1);      Velocity_posexp_1st_wash=cell(100,1);       Position_posexp_1st_wash=cell(100,1);

for nn=1:num_of_subjects
    clear velocity_window_NDX;
    clear position_window_NDX;
    
    % load data for each subject
    data_subject=load(d(nn).name);
    dat=data_subject.dat;
    info=data_subject.info;
    
    % find the indices for velocity and position trials
    % force channel trials index
    force_channel_trials_NDX=regexpi(info.trial_type,'force_channel');
    force_channel_trials_NDX=(1-cellfun(@isempty,force_channel_trials_NDX));
    
    % force field trials index
    force_field_trials_NDX=regexpi(info.trial_type,'force_field');
    force_field_trials_NDX=(1-cellfun(@isempty,force_field_trials_NDX));
    
    % velocity_trials_index
    velocity_trials_NDX=regexpi(info.field_name,'velocity');
    velocity_trials_NDX=(1-cellfun(@isempty,velocity_trials_NDX));
    
    % position_trials_index
    position_trials_NDX=regexpi(info.field_name,'position');
    position_trials_NDX=(1-cellfun(@isempty,position_trials_NDX));
    
    % null_trials_index
    null_trials_NDX=regexpi(info.task_name,'null');
    null_trials_NDX=(1-cellfun(@isempty,null_trials_NDX));
    
    % test_trials_index
    test_trials_NDX=regexpi(info.task_name,'test');
    test_trials_NDX=(1-cellfun(@isempty,test_trials_NDX));
    
    % hybrid_trials_index
    hybrid_trials_NDX=regexpi(info.task_name,'hybrid');
    hybrid_trials_NDX=(1-cellfun(@isempty,hybrid_trials_NDX));
    
    % washout_trials_index
    washout_trials_NDX=regexpi(info.task_name,'washout');
    washout_trials_NDX=(1-cellfun(@isempty,washout_trials_NDX));
    
    % if the dummy variable for the test is wrong:

    %test direction_index
    test_direction_NDX=info.task_direction-info.trial_direction;
    test_direction_NDX=(test_direction_NDX==0);
    
    % field directions
    %position
    position_field_direction_sign=regexpi(info.field_direction,'cc');
    position_field_direction_sign=2*(1-cellfun(@isempty,position_field_direction_sign))-1;
    
    %velocity
    velocity_field_direction_sign=regexpi(info.field_direction,'cc');
    velocity_field_direction_sign=2*(1-cellfun(@isempty,velocity_field_direction_sign))-1;
    
    %trial direction
    trial_direction=info.trial_direction;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% VELOCITY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % combine the data for velocity trials
    
    %baseline

    velocity_baseline_NDX=find(test_direction_NDX.*force_channel_trials_NDX.*null_trials_NDX.*velocity_trials_NDX);
    velocity_baseline_NDX_null=find(test_direction_NDX.*null_trials_NDX.*velocity_trials_NDX);
    if ~isempty(velocity_baseline_NDX)
        fake_baseline_force=zeros(2*sym_window+1,1);
        [sub_force_velexp_base,sub_velocity_velexp_base,sub_position_velexp_base,sub_EC_NDX_velexp_base]=group_data_for_baseline...
            (dat,info,velocity_baseline_NDX,sym_window,force_source,trial_direction,velocity_field_direction_sign,fake_baseline_force);
        
        force_baseline_velexp=nanmean(sub_force_velexp_base,2);
        
        
        Force_velexp_window_base=add_subject_to_all_data(Force_velexp_window_base,sub_force_velexp_base);
        Velocity_velexp_window_base=add_subject_to_all_data(Velocity_velexp_window_base,sub_velocity_velexp_base);
        Position_velexp_window_base=add_subject_to_all_data(Position_velexp_window_base,sub_position_velexp_base);
        
        velexp_base_EC_NDX=[velexp_base_EC_NDX,sub_EC_NDX_velexp_base];
        
        %test
        
        velocity_test_NDX=find(test_direction_NDX.*force_channel_trials_NDX.*velocity_trials_NDX.*test_trials_NDX);
        velocity_hybrid_NDX=find(test_direction_NDX.*force_channel_trials_NDX.*velocity_trials_NDX.*hybrid_trials_NDX);
        % first 4 trials of hybrid is still test
        velocity_test_NDX=[velocity_test_NDX; [velocity_hybrid_NDX(1:5)]];
        velocity_hybrid_NDX=velocity_hybrid_NDX(5:end);
        [sub_force_velexp_init_test,sub_velocity_velexp_init_test,sub_position_velexp_init_test,sub_EC_NDX_velexp_init_test,sub_EC_Nums_velexp_init_test]=group_data_for_baseline(dat,info,...
            velocity_test_NDX(1:3),sym_window,force_source,trial_direction,velocity_field_direction_sign,force_baseline_velexp);
        

%       [sub_force_abrupt_long_init_test,sub_velocity_abrupt_long_init_test,sub_position_abrupt_long_init_test,sub_EC_NDX_abrupt_long_init_test]=group_data_for_baseline...
%         (dat,info,abrupt_long_test_NDX(1:3),sym_window,force_source,trial_direction,field_direction_sign,force_abrupt_long_base,vel_range);
%     
%     sub_EC_NDX_abrupt_long_init_test=sub_EC_NDX_abrupt_long_init_test+(abrupt_long_test_NDX(1)-abrupt_long_baseline_NDX(end));
   sub_EC_NDX_velexp_init_test=sub_EC_NDX_velexp_init_test+(velocity_test_NDX(1)-velocity_baseline_NDX(end));
        
        [sub_force_velexp_test,sub_velocity_velexp_test,sub_position_velexp_test,sub_EC_NDX_velexp_test,sub_EC_Nums_velexp_test]=group_data_with_window_13_04_15(dat,info,...
            velocity_test_NDX(3:end),test_window,sym_window,force_source,trial_direction,velocity_field_direction_sign,force_baseline_velexp);
        
        sub_force_velexp_test=[sub_force_velexp_init_test,sub_force_velexp_test];
        sub_velocity_velexp_test=[sub_velocity_velexp_init_test,sub_velocity_velexp_test];
        sub_position_velexp_test=[sub_position_velexp_init_test,sub_position_velexp_test];
        ssub_EC_NDX_velexp_test=[sub_EC_NDX_velexp_init_test;sub_EC_NDX_velexp_test+ceil(mean(sub_EC_NDX_velexp_init_test))];
        
        Force_velexp_window_test=add_subject_to_all_data(Force_velexp_window_test,sub_force_velexp_test);
        Velocity_velexp_window_test=add_subject_to_all_data(Velocity_velexp_window_test,sub_velocity_velexp_test);
        Position_velexp_window_test=add_subject_to_all_data(Position_velexp_window_test,sub_position_velexp_test);
        
        velexp_test_EC_NDX=[velexp_test_EC_NDX,sub_EC_NDX_velexp_test];
        velexp_test_EC_Nums=[velexp_test_EC_Nums,sub_EC_Nums_velexp_test];
        
        if washout_window~=1
            
            [sub_force_velexp_wash,sub_velocity_velexp_wash,sub_position_velexp_wash,sub_EC_NDX_velexp_wash,sub_EC_Nums_velexp_wash]=group_data_with_window_13_04_15(dat,info,...
                velocity_hybrid_NDX,washout_window,sym_window,force_source,trial_direction,velocity_field_direction_sign,force_baseline_velexp);
            velexp_wash_EC_Nums=[velexp_wash_EC_Nums,sub_EC_Nums_velexp_wash];
        elseif washout_window==1
            
            [sub_force_velexp_wash,sub_velocity_velexp_wash,sub_position_velexp_wash,sub_EC_NDX_velexp_wash]=group_data_for_baseline...
                (dat,info,velocity_hybrid_NDX,sym_window,force_source,trial_direction,velocity_field_direction_sign,force_baseline_velexp);
            velexp_wash_EC_Nums=[velexp_wash_EC_Nums,1];
        end
        



        Force_velexp_window_wash=add_subject_to_all_data(Force_velexp_window_wash,sub_force_velexp_wash);
        Velocity_velexp_window_wash=add_subject_to_all_data(Velocity_velexp_window_wash,sub_velocity_velexp_wash);
        Position_velexp_window_wash=add_subject_to_all_data(Position_velexp_window_wash,sub_position_velexp_wash);
        velexp_wash_EC_NDX=[velexp_wash_EC_NDX,sub_EC_NDX_velexp_wash];
        
                        % first wash 
        [sub_force_velexp_1st_wash,sub_velocity_velexp_1st_wash,sub_position_velexp_1st_wash,~]=group_data_for_baseline...
                (dat,info,velocity_hybrid_NDX(1),sym_window,force_source,trial_direction,velocity_field_direction_sign,force_baseline_velexp);
        Force_velexp_1st_wash=add_subject_to_all_data(Force_velexp_1st_wash,sub_force_velexp_1st_wash);
        Velocity_velexp_1st_wash=add_subject_to_all_data(Velocity_velexp_1st_wash,sub_velocity_velexp_1st_wash);
        Position_velexp_1st_wash=add_subject_to_all_data(Position_velexp_1st_wash,sub_position_velexp_1st_wash);
        
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% POSITION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % the logic is similar to the velocity case.
    %baseline
    
%      velexp_base_EC_NDX=[velexp_base_EC_NDX,sub_EC_NDX_velexp_base];
%         
%         %test
%         
%         velocity_test_NDX=find(test_direction_NDX.*force_channel_trials_NDX.*velocity_trials_NDX.*test_trials_NDX);
%         velocity_hybrid_NDX=find(test_direction_NDX.*force_channel_trials_NDX.*velocity_trials_NDX.*hybrid_trials_NDX);
%         % first 4 trials of hybrid is still test
%         velocity_test_NDX=[velocity_test_NDX; [velocity_hybrid_NDX(1:5)]];
%         velocity_hybrid_NDX=velocity_hybrid_NDX(5:end);
%         [sub_force_velexp_init_test,sub_velocity_velexp_init_test,sub_position_velexp_init_test,sub_EC_NDX_velexp_init_test,sub_EC_Nums_velexp_init_test]=group_data_for_baseline(dat,info,...
%             velocity_test_NDX(1:3),sym_window,force_source,trial_direction,velocity_field_direction_sign,force_baseline_velexp);
%         
% 
% %       [sub_force_abrupt_long_init_test,sub_velocity_abrupt_long_init_test,sub_position_abrupt_long_init_test,sub_EC_NDX_abrupt_long_init_test]=group_data_for_baseline...
% %         (dat,info,abrupt_long_test_NDX(1:3),sym_window,force_source,trial_direction,field_direction_sign,force_abrupt_long_base,vel_range);
% %     
% %     sub_EC_NDX_abrupt_long_init_test=sub_EC_NDX_abrupt_long_init_test+(abrupt_long_test_NDX(1)-abrupt_long_baseline_NDX(end));
%    sub_EC_NDX_velexp_init_test=sub_EC_NDX_velexp_init_test+(velocity_test_NDX(1)-velocity_baseline_NDX(end));
%         
%         [sub_force_velexp_test,sub_velocity_velexp_test,sub_position_velexp_test,sub_EC_NDX_velexp_test,sub_EC_Nums_velexp_test]=group_data_with_window_13_04_15(dat,info,...
%             velocity_test_NDX(3:end),test_window,sym_window,force_source,trial_direction,velocity_field_direction_sign,force_baseline_velexp);
%         
%         sub_force_velexp_test=[sub_force_velexp_init_test,sub_force_velexp_test];
%         sub_velocity_velexp_test=[sub_velocity_velexp_init_test,sub_velocity_velexp_test];
%         sub_position_velexp_test=[sub_position_velexp_init_test,sub_position_velexp_test];
%         ssub_EC_NDX_velexp_test=[sub_EC_NDX_velexp_init_test;sub_EC_NDX_velexp_test+ceil(mean(sub_EC_NDX_velexp_init_test))];
%         
%         Force_velexp_window_test=add_subject_to_all_data(Force_velexp_window_test,sub_force_velexp_test);
%         Velocity_velexp_window_test=add_subject_to_all_data(Velocity_velexp_window_test,sub_velocity_velexp_test);
%         Position_velexp_window_test=add_subject_to_all_data(Position_velexp_window_test,sub_position_velexp_test);
%         
%         velexp_test_EC_NDX=[velexp_test_EC_NDX,sub_EC_NDX_velexp_test];
%         velexp_test_EC_Nums=[velexp_test_EC_Nums,sub_EC_Nums_velexp_test];
%         
    position_baseline_NDX=find(test_direction_NDX.*force_channel_trials_NDX.*null_trials_NDX.*position_trials_NDX);
    position_baseline_NDX_null=find(test_direction_NDX.*null_trials_NDX.*position_trials_NDX);
    
    if ~isempty(position_baseline_NDX)
        [sub_force_posexp_base,sub_velocity_posexp_base,sub_position_posexp_base,sub_EC_NDX_posexp_base]=group_data_for_baseline...
            (dat,info,position_baseline_NDX,sym_window,force_source,trial_direction,position_field_direction_sign,fake_baseline_force);
        
        force_baseline_posexp=nanmean(sub_force_posexp_base,2);
        
        
        
        Force_posexp_window_base=add_subject_to_all_data(Force_posexp_window_base,sub_force_posexp_base);
        Velocity_posexp_window_base=add_subject_to_all_data(Velocity_posexp_window_base,sub_velocity_posexp_base);
        Position_posexp_window_base=add_subject_to_all_data(Position_posexp_window_base,sub_position_posexp_base);
        
        posexp_base_EC_NDX=[posexp_base_EC_NDX,sub_EC_NDX_posexp_base];
        
        
        % position test
        position_test_NDX=find(test_direction_NDX.*force_channel_trials_NDX.*position_trials_NDX.*test_trials_NDX);
        position_hybrid_NDX=find(test_direction_NDX.*force_channel_trials_NDX.*position_trials_NDX.*hybrid_trials_NDX);
        
        position_test_NDX=[position_test_NDX;[position_hybrid_NDX(1:5)]];
        position_hybrid_NDX=position_hybrid_NDX(5:end);
[sub_force_posexp_init_test,sub_velocity_posexp_init_test,sub_position_posexp_init_test,sub_EC_NDX_posexp_init_test,sub_EC_Nums_posexp_init_test]=group_data_for_baseline(dat,info,...
             position_test_NDX(1:3),sym_window,force_source,trial_direction,position_field_direction_sign,force_baseline_posexp);
%      
   sub_EC_NDX_posexp_init_test=sub_EC_NDX_posexp_init_test+(position_test_NDX(1)-position_baseline_NDX(end));
        
        [sub_force_posexp_test,sub_velocity_posexp_test,sub_position_posexp_test,sub_EC_NDX_posexp_test,sub_EC_Nums_posexp_test]=group_data_with_window_13_04_15(dat,info,...
            position_test_NDX(3:end),test_window,sym_window,force_source,trial_direction,position_field_direction_sign,force_baseline_posexp);
        
        
        sub_force_posexp_test=[sub_force_posexp_init_test,sub_force_posexp_test];
        sub_velocity_posexp_test=[sub_velocity_posexp_init_test,sub_velocity_posexp_test];
        sub_position_posexp_test=[sub_position_posexp_init_test,sub_position_posexp_test];
        sub_EC_NDX_posexp_test=[sub_EC_NDX_posexp_init_test;sub_EC_NDX_posexp_test+ceil(mean(sub_EC_NDX_posexp_init_test))];
        
        Force_posexp_window_test=add_subject_to_all_data(Force_posexp_window_test,sub_force_posexp_test);
        Velocity_posexp_window_test=add_subject_to_all_data(Velocity_posexp_window_test,sub_velocity_posexp_test);
        Position_posexp_window_test=add_subject_to_all_data(Position_posexp_window_test,sub_position_posexp_test);
        try 
        posexp_test_EC_NDX=[posexp_test_EC_NDX,sub_EC_NDX_posexp_test];
        posexp_test_EC_Nums=[posexp_test_EC_Nums,sub_EC_Nums_posexp_test];
        catch err
            keyboard
        end
        if washout_window~=1
            [sub_force_posexp_wash,sub_velocity_posexp_wash,sub_position_posexp_wash,sub_EC_NDX_posexp_wash,sub_EC_Nums_posexp_wash]=group_data_with_window_13_04_15(dat,info,...
                position_hybrid_NDX,washout_window,sym_window,force_source,trial_direction,position_field_direction_sign,force_baseline_posexp);
             posexp_wash_EC_Nums=[posexp_wash_EC_Nums,sub_EC_Nums_posexp_wash];
        elseif washout_window==1
            [sub_force_posexp_wash,sub_velocity_posexp_wash,sub_position_posexp_wash,sub_EC_NDX_posexp_wash]=group_data_for_baseline...
                (dat,info,position_hybrid_NDX,sym_window,force_source,trial_direction,position_field_direction_sign,force_baseline_posexp);
            posexp_wash_EC_Nums=[posexp_wash_EC_Nums,1];
        end
        
        
        Force_posexp_window_wash=add_subject_to_all_data(Force_posexp_window_wash,sub_force_posexp_wash);
        Velocity_posexp_window_wash=add_subject_to_all_data(Velocity_posexp_window_wash,sub_velocity_posexp_wash);
        Position_posexp_window_wash=add_subject_to_all_data(Position_posexp_window_wash,sub_position_posexp_wash);
        posexp_wash_EC_NDX=[posexp_wash_EC_NDX,sub_EC_NDX_posexp_wash];
        
        % first wash:        
        [sub_force_posexp_1st_wash,sub_velocity_posexp_1st_wash,sub_position_posexp_1st_wash,~]=group_data_for_baseline...
        (dat,info,position_hybrid_NDX(1),sym_window,force_source,trial_direction,position_field_direction_sign,force_baseline_posexp);
        Force_posexp_1st_wash=add_subject_to_all_data(Force_posexp_1st_wash,sub_force_posexp_1st_wash);
        Velocity_posexp_1st_wash=add_subject_to_all_data(Velocity_posexp_1st_wash,sub_velocity_posexp_1st_wash);
        Position_posexp_1st_wash=add_subject_to_all_data(Position_posexp_1st_wash,sub_position_posexp_1st_wash);    
       
    end
end

% velocity
if ~isempty(velocity_baseline_NDX)
    [force_velexp_base_all,velocity_velexp_base_all,position_velexp_base_all]=...
        find_average_profile_for_FVP_data(Force_velexp_window_base,Velocity_velexp_window_base,Position_velexp_window_base,Maximum_allowable_force);
    
    
    [force_velexp_test_all,velocity_velexp_test_all,position_velexp_test_all]=...
        find_average_profile_for_FVP_data(Force_velexp_window_test,Velocity_velexp_window_test,Position_velexp_window_test,Maximum_allowable_force);
    
    [force_velexp_wash_all,velocity_velexp_wash_all,position_velexp_wash_all]=...
        find_average_profile_for_FVP_data(Force_velexp_window_wash,Velocity_velexp_window_wash,Position_velexp_window_wash,Maximum_allowable_force);
    
    [force_velexp_1st_wash_all,velocity_velexp_1st_wash_all,position_velexp_1st_wash_all]=...
        find_average_profile_for_FVP_data(Force_velexp_1st_wash,Velocity_velexp_1st_wash,Position_velexp_1st_wash,Maximum_allowable_force);    
end

% position
if ~isempty(position_baseline_NDX)
    [force_posexp_base_all,velocity_posexp_base_all,position_posexp_base_all]=...
        find_average_profile_for_FVP_data(Force_posexp_window_base,Velocity_posexp_window_base,Position_posexp_window_base,Maximum_allowable_force);
    
    
    [force_posexp_test_all,velocity_posexp_test_all,position_posexp_test_all]=...
        find_average_profile_for_FVP_data(Force_posexp_window_test,Velocity_posexp_window_test,Position_posexp_window_test,Maximum_allowable_force);
    
    [force_posexp_wash_all,velocity_posexp_wash_all,position_posexp_wash_all]=...
        find_average_profile_for_FVP_data(Force_posexp_window_wash,Velocity_posexp_window_wash,Position_posexp_window_wash,Maximum_allowable_force);
    
    [force_posexp_1st_wash_all,velocity_posexp_1st_wash_all,position_posexp_1st_wash_all]=...
        find_average_profile_for_FVP_data(Force_posexp_1st_wash,Velocity_posexp_1st_wash,Position_posexp_1st_wash,Maximum_allowable_force); 
end

% save data
% all position
dat_all.Force_posexp_base_all=force_posexp_base_all;
dat_all.Velocity_posexp_base_all=velocity_posexp_base_all;
dat_all.Position_posexp_base_all=position_posexp_base_all;
dat_all.Force_posexp_test_all=force_posexp_test_all;
dat_all.Velocity_posexp_test_all=velocity_posexp_test_all;
dat_all.Position_posexp_test_all=position_posexp_test_all;
dat_all.Force_posexp_wash_all=force_posexp_wash_all;
dat_all.Velocity_posexp_wash_all=velocity_posexp_wash_all;
dat_all.Position_posexp_wash_all=position_posexp_wash_all;
dat_all.Force_posexp_1st_wash_all=force_posexp_1st_wash_all;
dat_all.Velocity_posexp_1st_wash_all=velocity_posexp_1st_wash_all;
dat_all.Position_posexp_1st_wash_all=position_posexp_1st_wash_all;

% all velocity
dat_all.Force_velexp_base_all=force_velexp_base_all;
dat_all.Velocity_velexp_base_all=velocity_velexp_base_all;
dat_all.Position_velexp_base_all=position_velexp_base_all;

dat_all.Force_velexp_test_all=force_velexp_test_all;
dat_all.Velocity_velexp_test_all=velocity_velexp_test_all;
dat_all.Position_velexp_test_all=position_velexp_test_all;
dat_all.Force_velexp_wash_all=force_velexp_wash_all;
dat_all.Velocity_velexp_wash_all=velocity_velexp_wash_all;
dat_all.Position_velexp_wash_all=position_velexp_wash_all;
dat_all.Force_velexp_1st_wash_all=force_velexp_wash_all;
dat_all.Velocity_velexp_1st_wash_all=velocity_velexp_1st_wash_all;
dat_all.Position_velexp_1st_wash_all=position_velexp_1st_wash_all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% subject position
nonempty_posexp_base_window=find((1-cellfun(@isempty,Force_posexp_window_base)));
dat_all.Force_posexp_base_sub={Force_posexp_window_base{nonempty_posexp_base_window}};
dat_all.Velocity_posexp_base_sub={Velocity_posexp_window_base{nonempty_posexp_base_window}};
dat_all.Position_posexp_base_sub={Position_posexp_window_base{nonempty_posexp_base_window}};

nonempty_posexp_test_window=find((1-cellfun(@isempty,Force_posexp_window_test)));
dat_all.Force_posexp_test_sub={Force_posexp_window_test{nonempty_posexp_test_window}};
dat_all.Velocity_posexp_test_sub={Velocity_posexp_window_test{nonempty_posexp_test_window}};
dat_all.Position_posexp_test_sub={Position_posexp_window_test{nonempty_posexp_test_window}};

nonempty_posexp_wash_window=find((1-cellfun(@isempty,Force_posexp_window_wash)));
dat_all.Force_posexp_wash_sub={Force_posexp_window_wash{nonempty_posexp_wash_window}};
dat_all.Velocity_posexp_wash_sub={Velocity_posexp_window_wash{nonempty_posexp_wash_window}};
dat_all.Position_posexp_wash_sub={Position_posexp_window_wash{nonempty_posexp_wash_window}};

dat_all.Force_posexp_1st_wash_sub={Force_posexp_1st_wash{1}};
dat_all.Position_posexp_1st_wash_sub={Position_posexp_1st_wash{1}};
dat_all.Velocity_posexp_1st_wash_sub={Velocity_posexp_1st_wash{1}};

% subject velocity
nonempty_velexp_base_window=find((1-cellfun(@isempty,Force_velexp_window_base)));
dat_all.Force_velexp_base_sub={Force_velexp_window_base{nonempty_velexp_base_window}};
dat_all.Velocity_velexp_base_sub={Velocity_velexp_window_base{nonempty_velexp_base_window}};
dat_all.Position_velexp_base_sub={Position_velexp_window_base{nonempty_velexp_base_window}};

nonempty_velexp_test_window=find((1-cellfun(@isempty,Force_velexp_window_test)));
dat_all.Force_velexp_test_sub={Force_velexp_window_test{nonempty_velexp_test_window}};
dat_all.Velocity_velexp_test_sub={Velocity_velexp_window_test{nonempty_velexp_test_window}};
dat_all.Position_velexp_test_sub={Position_velexp_window_test{nonempty_velexp_test_window}};

nonempty_velexp_wash_window=find((1-cellfun(@isempty,Force_velexp_window_wash)));
dat_all.Force_velexp_wash_sub={Force_velexp_window_wash{nonempty_velexp_wash_window}};
dat_all.Velocity_velexp_wash_sub={Velocity_velexp_window_wash{nonempty_velexp_wash_window}};
dat_all.Position_velexp_wash_sub={Position_velexp_window_wash{nonempty_velexp_wash_window}};

dat_all.Force_velexp_1st_wash_sub={Force_velexp_1st_wash{1}};
dat_all.Position_velexp_1st_wash_sub={Position_velexp_1st_wash{1}};
dat_all.Velocity_velexp_1st_wash_sub={Velocity_velexp_1st_wash{1}};

% save indices
info_all.num_of_subjects=num_of_subjects;
info_all.FF_K=45;
info_all.FF_B=15;

info_all.posexp_base_EC_NDX_sub=posexp_base_EC_NDX;
info_all.posexp_test_EC_NDX_sub=posexp_test_EC_NDX;   
info_all.posexp_wash_EC_NDX_sub=posexp_wash_EC_NDX;
info_all.posexp_test_EC_Nums_sub=posexp_test_EC_Nums;   
info_all.posexp_wash_EC_Nums_sub=posexp_wash_EC_Nums;


info_all.velexp_base_EC_NDX_sub=velexp_base_EC_NDX;
info_all.velexp_test_EC_NDX_sub=velexp_test_EC_NDX;   
info_all.velexp_wash_EC_NDX_sub=velexp_wash_EC_NDX;
info_all.velexp_test_EC_Nums_sub=velexp_test_EC_Nums;   
info_all.velexp_wash_EC_Nums_sub=velexp_wash_EC_Nums;

info_all.posexp_base_EC_NDX=floor(nanmean(posexp_base_EC_NDX,2)); 
info_all.posexp_test_EC_NDX=floor(nanmean(posexp_test_EC_NDX,2));   
info_all.posexp_wash_EC_NDX=floor(nanmean(posexp_wash_EC_NDX,2));
info_all.posexp_test_EC_Nums=floor(nanmean(posexp_test_EC_Nums,2));   
info_all.posexp_wash_EC_Nums=floor(nanmean(posexp_wash_EC_Nums,2));


info_all.velexp_base_EC_NDX=floor(nanmean(velexp_base_EC_NDX,2)); 
info_all.velexp_test_EC_NDX=floor(nanmean(velexp_test_EC_NDX,2));   
info_all.velexp_wash_EC_NDX=floor(nanmean(velexp_wash_EC_NDX,2)); 
info_all.velexp_test_EC_Nums=floor(nanmean(velexp_test_EC_Nums,2));   
info_all.velexp_wash_EC_Nums=floor(nanmean(velexp_wash_EC_Nums,2)); 

save(['dat_all_',num2str(num_of_subjects),'_subjects','_testwin_',num2str(test_window),'_washwin_',num2str(washout_window)],'dat_all','info_all');

save(['PV_exp_',condition,'_dat_all_',num2str(num_of_subjects),'_subjects','_testwin_',num2str(test_window),'_washwin_',num2str(washout_window)],'dat_all','info_all');


end

function [force_window,velocity_window,position_window,EC_NDX,EC_NUMS]=group_data_with_window_13_04_15(dat,info,NDXs,window,sym_window,force_source,trial_direction,field_direction_sign,Force_Baseline)

Force_window=cell(100,1);
Velocity_window=cell(100,1);
Position_window=cell(100,1);

num_of_windows=ceil((NDXs(end)-NDXs(1))/(2*window));

window_NDX=[NDXs(1):2*window:NDXs(end),NDXs(end)+1];
row=1;
EC_NDX=0;
EC_NUMS=0;
for mm=1:(length(window_NDX)-1),
    Current_NDX=NDXs((NDXs-window_NDX(mm+1)<0)...
        & (NDXs-window_NDX(mm)>=0));
    Force_exp=[];
    Velocity_exp=[];
    Position_exp=[];
    
    if ~isempty(Current_NDX),
        EC_NDX(row,1)=[ceil(nanmean(Current_NDX)/2)];
        EC_NUMS(row,1)=length(Current_NDX);
        row=row+1;
        for ii=1:length(Current_NDX),
            trial_NDX=Current_NDX(ii);
            Tmax_YVel=dat{trial_NDX, 1}.Right_HandYVel_Tmax;
            theta=trial_direction(trial_NDX);
            flip_force_field=field_direction_sign(trial_NDX)*sind(theta);
            flip_movement=sind(theta);
            
            %force
            if regexpi('sensor',force_source)
                Force = dat{trial_NDX}.Right_FS_ForceX;
            elseif regexpi('compute',force_source)
                Force = dat{trial_NDX}.Right_Hand_FX;
            end
            % symmetrical force
            Force=Force(Tmax_YVel-sym_window:Tmax_YVel+sym_window);
            Force = (flip_force_field)*Force;
            Force_B=(flip_force_field)*Force_Baseline;
            
            
            %position
            position_y=dat{trial_NDX}.Right_HandY-(dat{trial_NDX}.Right_HandY*0+1e-2*info.start_target_pos(trial_NDX,2));
            %symmetrical position
            position_y=position_y(Tmax_YVel-sym_window:Tmax_YVel+sym_window);
            position_y = flip_movement*position_y;
            
            
            %velocity
            velocity_y=dat{trial_NDX}.Right_HandYVel;
            % symmetrical velocity
            velocity_y=velocity_y(Tmax_YVel-sym_window:Tmax_YVel+sym_window);
            velocity_y = flip_movement*velocity_y;
            
            velocity_max=max(velocity_y);
            if ((velocity_max<.4)& (velocity_max>.2))
                Force_exp=[Force_exp,(Force-Force_Baseline)];
                Velocity_exp=[Velocity_exp,velocity_y];
                Position_exp=[Position_exp,position_y];
            else
                Force_exp=[Force_exp,nan*(Force-Force_Baseline)];
                Position_exp=[Position_exp,nan*position_y];
                Velocity_exp=[Velocity_exp,nan*velocity_y];
            end
        end
    elseif isempty(Current_NDX)
        Force_exp=[Force_exp,nan*ones(sym_window*2+1,1)];
        Position_exp=[Position_exp,nan*ones(sym_window*2+1,1)];
        Velocity_exp=[Velocity_exp,nan*ones(sym_window*2+1,1)];
        EC_NDX(row,1)=nan;
        EC_NUMS(row,1)=0;
        row=row+1;
    end
    Force_window{mm}=[Force_window{mm},nanmean(Force_exp,2)];
    Velocity_window{mm}=[Velocity_window{mm},nanmean(Velocity_exp,2)];
    Position_window{mm}=[Position_window{mm},nanmean(Position_exp,2)];
        
end
force_window=[Force_window{:}];
position_window=[Position_window{:}];
velocity_window=[Velocity_window{:}];
EC_NDX=EC_NDX-floor(NDXs(1)/2);


end
function updated_all_data=add_subject_to_all_data(all_data,subject_data)
    for i=1:size(subject_data,2)
        all_data{i}=[all_data{i},subject_data(:,i)];
    end
    updated_all_data=all_data;
end
function [Force_all,Velocity_all,Position_all]=find_average_profile_for_FVP_data(Force_window,Velocity_window,Position_window,Maximum_allowable_force)
 Force_window_NDX=find((1-cellfun(@isempty,Force_window)));
    for p=1:length(Force_window_NDX)
        
        Force=Force_window{Force_window_NDX(p)};
        Velocity=Velocity_window{Force_window_NDX(p)};
        Position=Position_window{Force_window_NDX(p)};
        % the force that the subjects exert should not exceed 7N (ideal
        % compensatory force is between 3.5 and 4.5). If it exceeds threshold
        % then remove the force from data.
        Max_force=max(Force);
        Force(:,find(Max_force-Maximum_allowable_force>0))=[];
        Velocity(:,find(Max_force-Maximum_allowable_force>0))=[];
        Position(:,find(Max_force-Maximum_allowable_force>0))=[];
        %
        Force_all(:,p)=nanmean(Force,2);
        Velocity_all(:,p)=nanmean(Velocity,2);
        Position_all(:,p)=nanmean(Position,2);
 
    end
end

function [force_base,velocity_base,position_base,EC_NDX_base]=group_data_for_baseline(dat,info,NDXs,sym_window,force_source,trial_direction,field_direction_sign,Force_Baseline)
    Force_exp=[];
    Velocity_exp=[];
    Position_exp=[];

for mm=1:(length(NDXs)),

            trial_NDX=NDXs(mm);
            Tmax_YVel=dat{trial_NDX, 1}.Right_HandYVel_Tmax;
            theta=trial_direction(trial_NDX);
            flip_force_field=field_direction_sign(trial_NDX)*sind(theta);
            flip_movement=sind(theta);
            
            %force
            if regexpi('sensor',force_source)
                Force = dat{trial_NDX}.Right_FS_ForceX;
            elseif regexpi('compute',force_source)
                Force = dat{trial_NDX}.Right_Hand_FX;
            end
            % symmetrical force
            Force=Force(Tmax_YVel-sym_window:Tmax_YVel+sym_window);
            Force = (flip_force_field)*Force;
            Force_B=(flip_force_field)*Force_Baseline;
            
            
            %position
            position_y=dat{trial_NDX}.Right_HandY-(dat{trial_NDX}.Right_HandY*0+1e-2*info.start_target_pos(trial_NDX,2));
            %symmetrical position
            position_y=position_y(Tmax_YVel-sym_window:Tmax_YVel+sym_window);
            position_y = flip_movement*position_y;
            
            
            %velocity
            velocity_y=dat{trial_NDX}.Right_HandYVel;
            % symmetrical velocity
            velocity_y=velocity_y(Tmax_YVel-sym_window:Tmax_YVel+sym_window);
            velocity_y = flip_movement*velocity_y;
            velocity_max=max(velocity_y);
            if ((velocity_max<.4)& (velocity_max>.2))
                Force_exp=[Force_exp,(Force-Force_Baseline)];
                Position_exp=[Position_exp,position_y];
                Velocity_exp=[Velocity_exp,velocity_y];
            else
                
                Force_exp=[Force_exp,nan*(Force-Force_Baseline)];
                Position_exp=[Position_exp,nan*position_y];
                Velocity_exp=[Velocity_exp,nan*velocity_y];
            end
end
    force_base=Force_exp;
    velocity_base=Velocity_exp;
    position_base=Position_exp;
    EC_NDX_base=ceil(NDXs/2)-floor(NDXs(1)/2);
end

function [force_window,velocity_window,position_window,EC_NDX,EC_NUMS]=group_data_with_window_for_wash_17_07_14(dat,info,NDXs,window,sym_window,force_source,trial_direction,field_direction_sign,Force_Baseline)

Force_window=cell(100,1);
Velocity_window=cell(100,1);
Position_window=cell(100,1);

num_of_windows=ceil((NDXs(end)-NDXs(1))/(2*window));

window_NDX=[NDXs(1),NDXs(2):2*window:NDXs(end),NDXs(end)+1];
row=1;
EC_NDX=0;
EC_NUMS=0;
for mm=1:(length(window_NDX)-1),
    Current_NDX=NDXs((NDXs-window_NDX(mm+1)<0)...
        & (NDXs-window_NDX(mm)>=0));
    Force_exp=[];
    Velocity_exp=[];
    Position_exp=[];
    
    if ~isempty(Current_NDX),
        EC_NDX(row,1)=[ceil(nanmean(Current_NDX)/2)];
        EC_NUMS(row,1)=length(Current_NDX);
        row=row+1;
        for ii=1:length(Current_NDX),
            trial_NDX=Current_NDX(ii);
            Tmax_YVel=dat{trial_NDX, 1}.Right_HandYVel_Tmax;
            theta=trial_direction(trial_NDX);
            flip_force_field=field_direction_sign(trial_NDX)*sind(theta);
            flip_movement=sind(theta);
            
            %force
            if regexpi('sensor',force_source)
                Force = dat{trial_NDX}.Right_FS_ForceX;
            elseif regexpi('compute',force_source)
                Force = dat{trial_NDX}.Right_Hand_FX;
            end
            % symmetrical force
            Force=Force(Tmax_YVel-sym_window:Tmax_YVel+sym_window);
            Force = (flip_force_field)*Force;
            Force_B=(flip_force_field)*Force_Baseline;
            
            
            %position
            position_y=dat{trial_NDX}.Right_HandY-(dat{trial_NDX}.Right_HandY*0+1e-2*info.start_target_pos(trial_NDX,2));
            %symmetrical position
            position_y=position_y(Tmax_YVel-sym_window:Tmax_YVel+sym_window);
            position_y = flip_movement*position_y;
            
            
            %velocity
            velocity_y=dat{trial_NDX}.Right_HandYVel;
            % symmetrical velocity
            velocity_y=velocity_y(Tmax_YVel-sym_window:Tmax_YVel+sym_window);
            velocity_y = flip_movement*velocity_y;
            
            velocity_max=max(velocity_y);
            if ((velocity_max<.4)& (velocity_max>.2))
                Force_exp=[Force_exp,(Force-Force_Baseline)];
                Velocity_exp=[Velocity_exp,velocity_y];
                Position_exp=[Position_exp,position_y];
            else
                Force_exp=[Force_exp,nan*(Force-Force_Baseline)];
                Position_exp=[Position_exp,nan*position_y];
                Velocity_exp=[Velocity_exp,nan*velocity_y];
            end
        end
    elseif isempty(Current_NDX)
        EC_NDX(row,1)=nan;
        EC_NUMS(row,1)=0;
        row=row+1;
    end
    Force_window{mm}=[Force_window{mm},nanmean(Force_exp,2)];
    Velocity_window{mm}=[Velocity_window{mm},nanmean(Velocity_exp,2)];
    Position_window{mm}=[Position_window{mm},nanmean(Position_exp,2)];
        
end
force_window=[Force_window{:}];
position_window=[Position_window{:}];
velocity_window=[Velocity_window{:}];
EC_NDX=EC_NDX-floor(NDXs(1)/2);


end