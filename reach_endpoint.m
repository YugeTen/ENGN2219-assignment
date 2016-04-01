% This function is to navigate the intruder to get to the end point once it
% entered the perimeter.



function [next_x, next_y,get_to_endpoint] = reach_endpoint(intruder,dx,dy)
    if abs(dx) > intruder.max_speed && abs(dy) > intruder.max_speed
        next_x = intruder.x + (dx/abs(dx))*intruder.max_speed;
        next_y = intruder.y;
        get_to_endpoint = 0;
    elseif abs(dx) <= intruder.max_speed && abs(dy) > intruder.max_speed
        next_x = intruder.end_x;
        next_y = intruder.y + (dy/abs(dy))*intruder.max_speed;
        get_to_endpoint = 0;
    elseif abs(dx) > intruder.max_speed && abs(dy) <= intruder.max_speed
        next_x = intruder.x + (dx/abs(dx))*intruder.max_speed;
        next_y = intruder.end_y;
        get_to_endpoint = 0;
    elseif abs(dx) <= intruder.max_speed && abs(dy) <= intruder.max_speed
        d = sqrt(dx^2 + dy^2);
        if d <= intruder.max_speed
            next_x = intruder.end_x;
            next_y = intruder.end_y;
            get_to_endpoint = 1;
        else
            next_x = intruder.x + intruder.max_speed*dx/d;
            next_y = intruder.y + intruder.max_speed*dy/d;
        end     
    end
end
