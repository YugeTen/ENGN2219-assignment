%This function is to monitor if the intruder is still inside the perimeter.
%The function returns the value of in_perimeter to the main program.

function in_perimeter = intruder_position(intruder)
if intruder.x_min <= intruder.x &&...
        intruder.y_min <= intruder.y &&...
        intruder.x <= intruder.x_max &&...
        intruder.y <= intruder.y_max
    in_perimeter = 1;
else
    in_perimeter = 0;
end
end

