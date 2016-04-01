%This function is designed for the robot to chase the intruder once the
%intruder is inside its sensor range. Once the intruder is captured, the 
%returned value of "caputure" will be set to 1 when sent back to the main
%program.
%If the distance between the intruder and the robot is smaller than the
%value of the maximum speed of the robot, the intruder is considered to be
%captured in this time step; else, the robot will move towards the intruder
%in its maximum speed.
%In the mean time, the if-elseif set at the end of the function ensures the
%robots to stay inside the perimeter all the time. 



function [next_x,next_y,capture] = chase(robot, intruder)
    dx = intruder.x - robot.x ;
    dy = intruder.y - robot.y ;
    d = sqrt(dx^2+dy^2);
    
    if d < robot.max_speed
        capture = 1;
        next_x = intruder.x;
        next_y = intruder.y;
    elseif dy == 0
        move_x = robot.max_speed * dx / d;
        next_x = robot.x + move_x;
        next_y = robot.y;
        capture = 0;
    else
        move_x = robot.max_speed * dx / d;
        move_y = dy/abs(dy)* sqrt(robot.max_speed^2 - move_x^2);
        %if dy is equal to 0, the value of n_t will be null. That's the
        %reason we have the above elseif set.
        next_x = robot.x + move_x;
        next_y = robot.y + move_y;
        capture = 0;        
    end
    
    if robot.x_min > next_x
        next_x = robot.x_min;
    elseif next_x > robot.x_max
        next_x = robot.x_max;
    elseif robot.y_min > next_y 
        next_y = robot.y_min;
    elseif next_y > robot.y_max
        next_y = robot.y_max;
    end
  
end
