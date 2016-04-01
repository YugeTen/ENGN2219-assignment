%Create the robots, set up its different attributes

function robot = createRobot(x, y,robot_sensor_range,robot_max_speed,near_perimeter,near_right,near_top,near_left,near_bottom,...
                             area_right,area_top,area_left,area_bottom,next_x,next_y,robot_num, find_target,chase_count)
  robot.x = x;
  robot.y = y;
  robot.sensor_range = robot_sensor_range;
  robot.max_speed = robot_max_speed;
  robot.near_perimeter = near_perimeter;
  robot.near_right = near_right;
  robot.near_top = near_top;
  robot.near_left = near_left;
  robot.near_bottom = near_bottom;
  robot.x_max = area_right;
  robot.y_max = area_top;
  robot.x_min = area_left;
  robot.y_min = area_bottom;
  robot.next_x = next_x;
  robot.next_y = next_y;
  robot.robot_num = robot_num; %when the robots are initialized, they are 
                               %inside each other's sensor
                               %range and thus could obtain the total
                               %number of the robots.
  robot.find_target = find_target;
  robot.chase_count = chase_count;



  
  