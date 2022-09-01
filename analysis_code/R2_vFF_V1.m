FF_K=PV_coefficient(1);
FF_B=PV_coefficient(2);
num_of_windows=size(Force_data,2);
num_of_subjects=info.num_of_subjects;
pv_gains_subjects=cell(num_of_windows,1);
if regexpi('add_initial_zero',add_initial_zero)
    start_of_fit=1;
    pv_gains_subjects=cell(num_of_windows+start_of_fit,1);
    if regexpi('offset_on',offset_condition)
        pv_gains_subjects{1}=ones(num_of_subjects,3)*0;
        
    else
        pv_gains_subjects{1}=ones(num_of_subjects,2)*0;
       
    end
    start_of_fit=1;
else
    start_of_fit=0;
end

r_squared_subjects=pv_gains_subjects;

for i=1:num_of_windows
    Force_window_subject=Force_data{i};
    Velocity_window_subject=Velocity_data{i};
    Position_window_subject=Position_data{i};
    num_of_sub=size(Force_window_subject,2);
    for nn=1:length(subject_vector)
        jj=subject_vector(nn);
        F_sub = Force_window_subject(:,jj);
        V_sub = FF_B*Velocity_window_subject(:,jj);
        P_sub = FF_K*Position_window_subject(:,jj);
        
        if regexpi('offset_on',offset_condition)
            p_v_input_sub=[P_sub,V_sub,0*V_sub+1];
        else
            p_v_input_sub=[P_sub,V_sub];
        end
        
        if ~isnan(F_sub)
            [p_v_regression_sub,~,~,~,STATS_sub]=regress(F_sub,p_v_input_sub);
            pv_gains_subjects{i+start_of_fit}=[pv_gains_subjects{i+start_of_fit};p_v_regression_sub'];
            r_squared_subjects{i+start_of_fit}=[r_squared_subjects{i+start_of_fit};STATS_sub(1)'];
        else 
            p_v_regression_sub=nan*ones(size(p_v_input_sub,2),1);
            pv_gains_subjects{i+start_of_fit}=[pv_gains_subjects{i+start_of_fit};p_v_regression_sub'];
        end
        %clear F_sub V_sub P_sub
    end
end

ave_r2=cellfun(@(x) nanmean(x),r_squared_subjects);





















