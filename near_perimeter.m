%sense the parameter
function [ans,near_right,near_top,near_left,near_bottom] = near_perimeter(robot,area)
            if robot.sensor_range < robot.max_speed
               radius = robot.sensor_range;
            else
               radius = robot.max_speed;
            end

            near_right = (abs(area{3}(1) - robot.x) < radius);
            near_top = (abs(area{3}(2) - robot.y) < radius);
            near_left = (abs(area{1}(1) - robot.x) < radius);
            near_bottom = (abs(area{1}(2) - robot.y) < radius);
            if near_right||near_top||near_left||near_bottom
                ans = 1;
            else
                ans = 0;
            end
end

                