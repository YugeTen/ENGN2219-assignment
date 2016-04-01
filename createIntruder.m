%Create the intruder, set up its different attributes

function intruder = createIntruder(x,y,initial_x,initial_y,end_x,end_y,intruder_sensor_range,...
    intruder_max_speed,next_x,next_y,area_right,area_top,area_left,area_bottom,target_distances,...
    find_robot,get_to_endpoint,gone,captured,in_perimeter)
   intruder.x = x;
   intruder.y = y;
   intruder.initial_x = initial_x;
   intruder.initial_y = initial_y;
   intruder.end_x = end_x;
   intruder.end_y = end_y;
   intruder.sensor_range = intruder_sensor_range;
   intruder.max_speed = intruder_max_speed;
   intruder.next_x = next_x;
   intruder.next_y = next_y;
   intruder.x_max = area_right;
   intruder.y_max = area_top;
   intruder.x_min = area_left;
   intruder.y_min = area_bottom;
   intruder.target_distances = target_distances;
   intruder.find_robot = find_robot;
   intruder.get_to_endpoint = get_to_endpoint;
   intruder.gone = gone;
   intruder.captured = captured;
   intruder.in_perimeter = in_perimeter;
end
