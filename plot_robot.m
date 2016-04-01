%plot the robots

function [position_plot,robot_plot] = plot_robot(x,y,sensor_range)

   position_plot = plot(x,y,'.r');
   robot_plot = rectangle('Position',[x-sensor_range,y-sensor_range,...
       2*sensor_range,2*sensor_range],'Curvature',[1 1],'EdgeColor','r','LineWidth',2);

end

