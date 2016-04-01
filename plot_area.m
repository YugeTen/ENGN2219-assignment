%plot the area

function ans = plot_area(area, entry)

    area_width = sum(area{3} - area{2});
    area_height = sum(area{2} - area{1});
    entry_width = sum(entry{3} - entry{2});
    entry_height = sum(entry{2} - entry{1});
    rectangle('Position',[area{1}(1),area{1}(2),area_width,area_height]...
    ,'LineWidth',3);
    rectangle('Position',[entry{1}(1),entry{1}(2),entry_width,entry_height]...
    ,'LineStyle','-');
    axis([area{1}(1)-area_width*0.2  area{4}(1)+area_width*0.2...
    area{1}(2)-area_width*0.2 area{2}(2)+area_width*0.2]);
    hold on
    title('Intruder and robots')

end