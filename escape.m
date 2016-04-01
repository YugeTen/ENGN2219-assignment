%This function is designed for the intruder to escape once it senses the
%robots. Once the intruder is captured, that is, when the distance between
%itself and the robot is 0,the returned value of "caputure" will be set to 
%1 when sent back to the main program.

function [next_x, next_y,capture] = escape(intruder,robot)
    dx = intruder.x - robot.x;
    dy = intruder.y - robot.y;
    d = sqrt(dx^2+dy^2);

    if d == 0
        next_x = intruder.x;
        next_y = intruder.y;
        capture = 1;
    elseif dy == 0
        move_x = dx * (d+intruder.max_speed) / d;
        next_x = intruder.x + dx/abs(dx)*(abs(move_x)-abs(dx));
        next_y = intruder.y;
        capture = 0;
    elseif dx == 0
        move_y = dy * (d+intruder.max_speed) / d;
        next_x = intruder.x;
        next_y = intruder.y + dy/abs(dy)*(abs(move_y)-abs(dy));
        capture = 0;
    else
        move_x = dx * (d+intruder.max_speed) / d;
        move_y = dy * (d+intruder.max_speed) / d;
        next_x = intruder.x + dx/abs(dx)*(abs(move_x)-abs(dx));
        %if dx is equal to 0, the value of next_x will be null. That's the
        %reason we have the above two elseif sets.
        next_y = intruder.y + dy/abs(dy)*(abs(move_y)-abs(dy));
        capture = 0;
    end
    
   
end




