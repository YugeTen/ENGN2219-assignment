%plot the robots

function [dot_plot,intruder_plot,end_plot] = plot_intruder(i_x,i_y,sensor_range,e_x,e_y)

   dot_plot = plot(i_x,i_y,'.g');
   intruder_plot = rectangle('Position',[i_x-sensor_range,i_y-sensor_range,...
       2*sensor_range,2*sensor_range],'Curvature',[1 1],'EdgeColor','g','LineWidth',2);
   end_plot = plot(e_x, e_y, '.b');

end
