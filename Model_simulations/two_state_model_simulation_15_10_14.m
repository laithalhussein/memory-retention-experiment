function [two_state_model_output,slow_state,fast_state]=two_state_model_simulation_15_10_14(A,B,Q,R,F,wash_period)

two_state_model_output=zeros(length(F)+wash_period(2)-wash_period(1),1);
slow_state=0*two_state_model_output;
fast_state=0*two_state_model_output;
% adaptation
for nn=1:length(F)
    current_output=slow_state(nn)+fast_state(nn);
    two_state_model_output(nn)=current_output;
    current_error=F(nn)-current_output;
    next_state=A*[slow_state(nn);fast_state(nn)]+B*current_error+normrnd(0,Q,2,1);
    slow_state(nn+1)=next_state(1,1);
    fast_state(nn+1)=next_state(2,1);
    two_state_model_output(nn+1)=sum(next_state)+normrnd(0,R,1,1);
end

% unlearning
for mm=wash_period(1):wash_period(2)-1
    current_output=slow_state(mm)+fast_state(mm);
    current_error=0*current_output;
    next_state=A*[slow_state(mm);fast_state(mm)]+B*current_error+normrnd(0,Q,2,1);
    slow_state(mm+1)=next_state(1,1);
    fast_state(mm+1)=next_state(2,1);
    two_state_model_output(mm+1)=sum(next_state)+normrnd(0,R,1,1);
end

end