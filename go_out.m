%This function is to navigate the intruder out of the perimeter in the
%least time-consuming way once it has reached the end point.

function [next_x, next_y] = go_out(intruder)
       distances = [abs(intruder.x - intruder.x_min),...
           abs(intruder.x - intruder.x_max),...
           abs(intruder.y - intruder.y_min),...
           abs(intruder.y - intruder.y_max)];
       i = find(distances == min(distances),1);
       if i == 1
           next_x = intruder.x - intruder.max_speed;
           next_y = intruder.y;
       elseif i == 2
           next_x = intruder.x + intruder.max_speed;
           next_y = intruder.y;
       elseif i == 3
           next_x = intruder.x;
           next_y = intruder.y - intruder.max_speed;
       elseif i == 4
           next_x = intruder.x;
           next_y = intruder.y + intruder.max_speed;
       end
end

       

