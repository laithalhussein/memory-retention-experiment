function b=plot_bar_with_error_27_01_15(x_data,Training_mat,error_mat,Training_seq,Color_seq,h_matrix_early,h_matrix_late)
% this really needs to get cleaned up...

A=ver('matlab');
ver_matlab=A.Version;

b=bar(x_data,Training_mat,1);

X_mid_bar=[];
hold on
for i=1:size(Training_mat,2)
    if ver_matlab<8.4
        edge_positions=get(get(b(i),'children'), 'xdata');
        x_middle_of_bar= mean(edge_positions([1 3],:));
        X_mid_bar=[X_mid_bar;x_middle_of_bar];
        
    else
        edge_positions=get(b(i),'xdata')+get(b(i),'XOffset');
        x_middle_of_bar=edge_positions ;
        X_mid_bar=[X_mid_bar;x_middle_of_bar];
        
    end
    set(b(i),'DisplayName',Training_seq{i});
    set(b(i),'FaceColor',Color_seq(i,:),'EdgeColor','none');
    error_x_1=x_middle_of_bar(1)*[1,1,1];
    error_y_1=[Training_mat(1,i)]+error_mat(1,i)*[-1,0,1];
    error_x_2=x_middle_of_bar(2)*[1,1,1];
    
    error_y_2=[Training_mat(2,i)]+error_mat(2,i)*[-1,0,1];
    % o=plot(error_x_1,error_y_1,'color',Color_seq(i,:),'linewidth',1);
    % o1=plot(error_x_2,error_y_2,'color',Color_seq(i,:),'linewidth',1);
    o=plot(error_x_1,error_y_1,'color','k','linewidth',1);
    o1=plot(error_x_2,error_y_2,'color','k','linewidth',1);
    
    hg=get(o,'Annotation');hLegendEntry = get(hg,'LegendInformation');
    set(hLegendEntry,'IconDisplayStyle','off');
    hg=get(o1,'Annotation');hLegendEntry = get(hg,'LegendInformation');
    set(hLegendEntry,'IconDisplayStyle','off');
    
end
% early
training_mat=Training_mat';
for i=1:size(training_mat,1)
    p=find(h_matrix_early(i,:));
    for n=1:length(p)
        j=p(n);
        line_end_points_x=[X_mid_bar(i,1),X_mid_bar(j,1)];
        line_end_points_y=max([training_mat(i,1),training_mat(j,1)])*[1,1]+.5*mean([training_mat(i,1),training_mat(j,1)]);
        %
        left_side_line_end_points_x=[X_mid_bar(i,1),X_mid_bar(i,1)];
        left_side_line_end_points_y=[line_end_points_y(1)-.05,line_end_points_y(1)];
        %
        right_side_line_end_points_x=[X_mid_bar(j,1),X_mid_bar(j,1)];
        right_side_line_end_points_y=[line_end_points_y(2)-.05,line_end_points_y(2)];
        h1=plot(line_end_points_x,line_end_points_y,'color','k','linewidth',.5);
        h2=plot(left_side_line_end_points_x,left_side_line_end_points_y,'color','k','linewidth',.5);
        h3=plot(right_side_line_end_points_x,right_side_line_end_points_y,'color','k','linewidth',.5);
        o2=plot(mean(line_end_points_x),line_end_points_y(1)+.05,'*','markersize',3,'linewidth',.5,'color','k');
        hg=get(h1,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');
        hg=get(h2,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');
        hg=get(h3,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');
        hAnnotation = get(o2,'Annotation');hLegendEntry = get(hAnnotation','LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');
    end
end
% late
for i=1:size(training_mat,1)
    p=find(h_matrix_late(i,:));
    for n=1:length(p)
        j=p(n);
        line_end_points_x=[X_mid_bar(i,2),X_mid_bar(j,2)];
        line_end_points_y=max([training_mat(i,2),training_mat(j,2)])*[1,1]+.5*mean([training_mat(i,2),training_mat(j,2)]);
        %
        left_side_line_end_points_x=[X_mid_bar(i,2),X_mid_bar(i,2)];
        left_side_line_end_points_y=[line_end_points_y(1)-.05,line_end_points_y(1)];
        %
        right_side_line_end_points_x=[X_mid_bar(j,2),X_mid_bar(j,2)];
        right_side_line_end_points_y=[line_end_points_y(2)-.05,line_end_points_y(2)];
        %
        h1=plot(line_end_points_x,line_end_points_y,'color','k','linewidth',.5);
        h2=plot(left_side_line_end_points_x,left_side_line_end_points_y,'color','k','linewidth',.5);
        h3=plot(right_side_line_end_points_x,right_side_line_end_points_y,'color','k','linewidth',.5);
        o2=plot(mean(line_end_points_x),line_end_points_y(1)+.05,'*','markersize',3,'linewidth',.5,'color','k');
        hg=get(h1,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');
        hg=get(h2,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');
        hg=get(h3,'Annotation');hLegendEntry = get(hg,'LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');
        hAnnotation = get(o2,'Annotation');hLegendEntry = get(hAnnotation','LegendInformation');set(hLegendEntry,'IconDisplayStyle','off');
    end
end
end

