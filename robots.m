%%%%%%%                        ENGN2219                         %%%%%%%%
%%%%%%%                       Assignment 2                      %%%%%%%%
%%%%%%%                    Group id: A1Grp45                    %%%%%%%%
%%%%%%%                     u5468145 Di He                      %%%%%%%%
%%%%%%%                    u5634555 Yuge Shi                    %%%%%%%%



%main program

clc;
close all;
clear;

%read the config file
fileName = input('please input file name:\n', 's');
fileFilter1 = fopen(fileName, 'r');
line = fgetl(fileFilter1);
index1 = 1;
while ischar(line)
    text{index1} = line;
    line = fgetl(fileFilter1);
    index1 = index1 + 1;
end
fclose(fileFilter1)
index1 = index1 - 1;


%error handling
errorTest = 0;
index2 = 1;
for i = 1:index1
    if isempty(text{i} ~= '#') == 0
        if text{i}(1) ~= '#'
            data{index2} = text{i};
            index2 = index2 + 1;
        end
    else
        fprintf('Value missing in input file');
        errorTest = 1;
        break
    end
end

for i = 1:length(data)
    for j = 1:length(data{i})
        if data{i}(j) < 0
            fprintf('Negative value found in input file')
            errorTest = 1;
        end
    end
end


for i = 1:2
    coor_struct{i} = str2num(data{i});
    if coor_struct{i}(1) ~= coor_struct{i}(3)||coor_struct{i}(4) ~= coor_struct{i}(6)||...
          coor_struct{i}(5) ~= coor_struct{i}(7)||coor_struct{i}(2) ~= coor_struct{i}(8)  
        errorTest = 1;
        fprintf('Rectangle coordinates invalid')
    end
end


if errorTest == 0
    robot_num = str2num(data{3});
    robot_sensor_range = str2num(data{4});
    robot_max_speed = str2num(data{5});
    intruder_sensor_range = str2num(data{6});
    intruder_max_speed = str2num(data{7});
    coor = str2num(data{8});
    intruder_initial_x = coor(1);
    intruder_initial_y = coor(2);
    coor = str2num(data{9});
    intruder_end_x = coor(1);
    intruder_end_y = coor(2);
    
    % transfer the coordinates into double so that we can
    % get rid of the space
    coor = {};
    for i = 1:2
        coor_struct{i} = str2num(data{i});
    end
    
    area_coor = coor_struct{1};
    entry_coor = coor_struct{2};
    area = {};
    entry = {};
    
    % plot rectangular background and entry square
    for i = 1:2:length(area_coor)
        area = [area,[area_coor(i), area_coor(i+1)]];
    end
    
    for i = 1:2:length(entry_coor)
        entry = [entry,[entry_coor(i), entry_coor(i+1)]];
    end 
    plot_area(area,entry)
    
    
    % generate random initial coordinates for robots
    x = entry{1}(1) + sum(entry{3} - entry{2}) * rand(1, robot_num);
    y = entry{1}(2) + sum(entry{2} - entry{1}) * rand(1, robot_num);
    
    
    % plot all the robots and create a structure for each robot
    for i = 1 : robot_num
            [position_plot{i},robot_plot{i}] = plot_robot(x(i),y(i),robot_sensor_range);
            robot{i} = createRobot(x(i),y(i),robot_sensor_range, robot_max_speed,...
                0,1,1,1,1,area{3}(1),area{3}(2),area{1}(1),area{1}(2),0,0,robot_num,0,0);
    end
    
   
    robot_next_x_list = zeros(1,robot_num);
    robot_next_y_list = zeros(1,robot_num);    
   
    % initializing intruder
    target_distances = ones(1, robot_num)*2*sqrt((area{3}(1)-area{1}(1))^2+(area{3}(2)-area{1}(2))^2);
    find_robot = zeros(1, robot_num);
    [dot_plot,intruder_plot,end_plot] = plot_intruder(intruder_initial_x,intruder_initial_y,...
        intruder_sensor_range,intruder_end_x,intruder_end_y);
    intruder = createIntruder(intruder_initial_x,intruder_initial_y,intruder_initial_x,...
        intruder_initial_y,intruder_end_x,intruder_end_y,intruder_sensor_range,intruder_max_speed,...
        0,0,area{3}(1),area{3}(2),area{1}(1),area{1}(2),target_distances, find_robot,0,0,0,1);
    
    
    initial_y = robot{1}.y;
    circumference_count = 0;
    back_to_initial_y = 0;
    token = 1 ;
    
    % Once initial patrolling is done, token is set to 0
    while token
        for i = 1:robot_num
            
            % all the robots move to the right before getting onto
            % perimeter

            [robot{i}.near_perimeter,...
             robot{i}.near_right, robot{i}.near_top,...
             robot{i}.near_left, robot{i}.near_bottom] = near_perimeter(robot{i},area);
            if robot{i}.near_perimeter == 0
                robot{i}.next_x = robot{i}.x + robot_max_speed;
                robot{i}.next_y = robot{i}.y;

            else
                
                % The "first" robot patrols around perimeter while others
                % stop
                
                if i == 1

                    if robot_sensor_range <= robot_max_speed
                        next_point = intersect(robot{i},robot_sensor_range,area);
                        radius = robot_sensor_range;
                    else
                        next_point = intersect(robot{i},robot_max_speed,area);
                        radius = robot_max_speed;
                    end
                    robot{i}.next_x = next_point(1);
                    robot_next_x_list(i) = next_point(1);
                    robot{i}.next_y = next_point(2);
                    robot_next_y_list(i) = next_point(2); 
                    circumference_count = circumference_count + 1;
                    
                    % when back_to_initial_y equals 5, this robot has got
                    % back and initial patrolling finishes.
                    if initial_y - radius < robot{i}.y &&...
                        robot{i}.y < initial_y + radius
                        back_to_initial_y = back_to_initial_y + 1;
                    end
                    if back_to_initial_y == 5
                        token = 0;
                    end
                end
            end 

            %move to the next point
            set(position_plot{i}, 'XData', robot{i}.next_x, 'YData', robot{i}.next_y)
            set(robot_plot{i}, 'Position',[robot{i}.next_x-robot_sensor_range,...
                robot{i}.next_y-robot_sensor_range,2*robot_sensor_range,2*robot_sensor_range])
            robot{i}.x = robot{i}.next_x;
            robot{i}.y = robot{i}.next_y;


        end

        pause(0.0001)
    end
    
    % circumference of the perimeter is calculated from the number of steps
    % the first robot took to go around the perimeter
    circumference = circumference_count * radius;
    length_interval = circumference/(robot{1}.robot_num);
    
    % time interval for even distribution is counted and shared with other
    % robots
    time_interval = length_interval/radius;
    for i = 1:robot_num
        robot{i}.time_interval = time_interval;
    end

    t = 0;

    
    while ~intruder.gone && ~intruder.captured
        t = t + 1;

        for i = 1:robot_num
            
            if t > i*robot{i}.time_interval  
                [robot{i}.near_perimeter,...
                    robot{i}.near_right, robot{i}.near_top,...
                    robot{i}.near_left, robot{i}.near_bottom] = near_perimeter(robot{i},area);
                target_distance = sqrt((robot{i}.x-intruder.x)^2 + (robot{i}.y - intruder.y)^2);
                
                if target_distance <= robot{i}.sensor_range
                    [robot{i}.near_perimeter,robot{i}.near_right, robot{i}.near_top,...
                        robot{i}.near_left, robot{i}.near_bottom] = near_perimeter(robot{i},area);
                    robot{i}.find_target = 1;
                    intruder.in_perimeter = intruder_position(intruder);
                    
                    % if intruder is inside perimeter, chase it, otherwise,
                    % keep patrolling around perimeter
                    if intruder.in_perimeter
                        [next_x,next_y,intruder.captured] = chase(robot{i}, intruder);
                        next_point = [next_x,next_y];
                    else
                        % if robot is currently not near perimeter, move to
                        % the perimeter in the closest way
                        if ~robot{i}.near_perimeter
                            [next_x,next_y] = go_out(robot{i});
                            next_point = [next_x,next_y];
                        else
                            next_point = intersect(robot{i}, radius, area);
                        end
                    end
                else
                    robot{i}.find_target = 0;
                    [robot{i}.near_perimeter,robot{i}.near_right, robot{i}.near_top,...
                        robot{i}.near_left, robot{i}.near_bottom] = near_perimeter(robot{i},area);
                    % if a robot chases the intruder into the area but
                    % finally loses it, the robot moves back to the perimeter in the closest way.
                    if ~robot{i}.near_perimeter
                        [next_x,next_y] = go_out(robot{i});
                        next_point = [next_x,next_y];
                    else
                        next_point = intersect(robot{i}, radius, area);
                    end
                    
                end                
                
                robot{i}.next_x = next_point(1);
                robot_next_x_list(i) = next_point(1);
                robot{i}.next_y = next_point(2);
                robot_next_y_list(i) = next_point(2); 
                
                set(position_plot{i}, 'XData', robot{i}.next_x, 'YData', robot{i}.next_y)
                set(robot_plot{i}, 'Position',[robot{i}.next_x-robot_sensor_range,...
                    robot{i}.next_y-robot_sensor_range,2*robot_sensor_range,2*robot_sensor_range])
                robot{i}.x = robot{i}.next_x;
                robot{i}.y = robot{i}.next_y;              
            end
                
       
        
        end
        if t > robot_num*time_interval
            for i = 1:robot_num
                target_distances(i) = sqrt((robot{i}.x - intruder.x)^2 + (robot{i}.y - intruder.y)^2);
                if target_distances(i) <= intruder.sensor_range
                    intruder.find_robot(i) = 1;
                    intruder.target_distances(i) = target_distances(i);
                else
                    intruder.find_robot(i) = 0;
                end
            end


            if intruder.find_robot == 0
                
                % if intruder hasn't got to the endpoint, move towards
                % endpoint, otherwise move out of the perimeter in the
                % closest way
                
                if intruder.get_to_endpoint == 0
                    dx = intruder.end_x - intruder.x;
                    dy = intruder.end_y - intruder.y;
                    [intruder.next_x, intruder.next_y,intruder.get_to_endpoint] = reach_endpoint(intruder,dx,dy);
                else
                    [intruder.next_x, intruder.next_y] = go_out(intruder);
                    if intruder.get_to_endpoint
                        intruder.gone = ~intruder_position(intruder);
                    end
                end
           
                
            else
                
                % find robot, escape!
                a = find(intruder.target_distances == min(intruder.target_distances),1);
                [intruder.next_x,intruder.next_y,intruder.captured] = escape(intruder,robot{a});
                
                % intruder.gone is set to 1 if the intruder reached
                % endpoint and successfully escaped
                if intruder.get_to_endpoint
                    intruder.gone = ~intruder_position(intruder);
                end
            end

            set(dot_plot, 'XData', intruder.next_x, 'YData', intruder.next_y)
            set(intruder_plot, 'Position',[intruder.next_x-intruder.sensor_range,...
                intruder.next_y-intruder.sensor_range,2*intruder.sensor_range,2*intruder.sensor_range])
            intruder.x = intruder.next_x;
            intruder.y = intruder.next_y;
        end
       
        pause(0.02)
    end
    if intruder.gone
        fprintf('Intruder wins!\n')
    elseif intruder.captured
        fprintf('Robots win!\n')
    end    
end