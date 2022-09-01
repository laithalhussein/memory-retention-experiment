function [fit_to_decay,gof_decay,y_est]=calculate_2state_fit_for_data_31_07_14(x_data,y_data)
fit_opt=fitoptions('method','nonlinearleastsquares','lower',[0,0,-inf,-inf],'upper',[1,1,inf,inf],'display','off');
fit_type=fittype('b*As^(k-1)-c*Af^(k-1)','independent','k','coefficients',{'As','Af','b','c'},'options',fit_opt);
[fit_to_decay,gof_decay]=fit(x_data,y_data,fit_type);
y_est=fit_to_decay(x_data);
end