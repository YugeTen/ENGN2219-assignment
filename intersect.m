%This function is to find the intersections between the sensors/range of maxspeed
%and peremeters

function intersection_coor = intersect(robot,radius,area)
    j = 0;
    if robot.near_right
        h1 = abs(area{3}(1) - robot.x);
        b1 = sqrt(radius^2 - h1^2);
        itsts_list(1) = b1;
        j = ~j;
    end
    if robot.near_top
        h2 = abs(area{3}(2) - robot.y);
        b2 = sqrt(radius^2 - h2^2);
        insts_list(2) = b2;
        j = ~j;
    end
    if robot.near_left
        h3 = abs(area{1}(1) - robot.x);
        b3 = sqrt(radius^2 - h3^2);
        insts_list(3) = b3;
        j = ~j;
    end
    if robot.near_bottom
        h4 = abs(area{1}(2) - robot.y);
        b4 = sqrt(radius^2 - h4^2);
        insts_list(4) = b4;
        j = ~j;
    end
    
    if j
        if robot.near_right
            intersection_coor = [area{3}(1), robot.y + b1];
        elseif robot.near_top
            intersection_coor = [robot.x - b2, area{3}(2)];
        elseif robot.near_left
            intersection_coor = [area{1}(1), robot.y - b3];
        else
            intersection_coor = [robot.x + b4, area{1}(2)];
        end
    else
        if robot.near_right&&robot.near_top
            intersection_coor = [robot.x - b2, area{3}(2)];
        elseif robot.near_top&&robot.near_left
            intersection_coor = [area{1}(1), robot.y - b3];
        elseif robot.near_left&&robot.near_bottom
            intersection_coor = [robot.x + b4, area{1}(2)];
        else
            intersection_coor = [area{3}(1), robot.y + b1];
        end
    end
end

        
        
        
        

