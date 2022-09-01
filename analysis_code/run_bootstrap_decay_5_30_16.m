
iter_=5000;
[tau_boot_al,const_boot_al]=perform_bootstrap_on_data_timeconst_5_30_16(d_al,iter_);
[tau_boot_gl,const_boot_gl]=perform_bootstrap_on_data_timeconst_5_30_16(d_gl,iter_);
[tau_boot_as,const_boot_as]=perform_bootstrap_on_data_timeconst_5_30_16(d_as,iter_);

[tau_boot_alp,const_boot_alp]=perform_bootstrap_on_data_timeconst_5_30_16(d_al_pff,iter_);
[tau_boot_glp,const_boot_glp]=perform_bootstrap_on_data_timeconst_5_30_16(d_gl_pff,iter_);
[tau_boot_asp,const_boot_asp]=perform_bootstrap_on_data_timeconst_5_30_16(d_as_pff,iter_);


%save('scale_boot_al.mat','scale_boot_al');
save('tau_boot_al.mat','tau_boot_al');
save('const_boot_al.mat','const_boot_al');

%save('scale_boot_gl.mat','scale_boot_gl');
save('tau_boot_gl.mat','tau_boot_gl');
save('const_boot_gl.mat','const_boot_gl');

%save('scale_boot_as.mat','scale_boot_as');
save('tau_boot_as.mat','tau_boot_as');
save('const_boot_as.mat','const_boot_as');

%save('scale_boot_alp.mat','scale_boot_alp');
save('tau_boot_alp.mat','tau_boot_alp');
save('const_boot_alp.mat','const_boot_alp');

%save('scale_boot_glp.mat','scale_boot_glp');
save('tau_boot_glp.mat','tau_boot_glp');
save('const_boot_glp.mat','const_boot_glp');

%save('scale_boot_asp.mat','scale_boot_asp');
save('tau_boot_asp.mat','tau_boot_asp');
save('const_boot_asp.mat','const_boot_asp');




