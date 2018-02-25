prompt={'Link_1 (in m)', 'Angle 1 \theta (in degrees):', 'Link_2 (in m)', 'Angle 2 \theta (in degrees):', 'Link_3 (in m)', 'Angle 3 \theta (in degrees):'};
name = 'Input Values';
defaultans = {'5', '110', '4', '60', '3', '120'};
options.Interpreter = 'tex';
answer = inputdlg(prompt,name,[1 10; 1 180; 1 10; 1 180; 1 10; 1 180],defaultans,options);
[link_1 status] = str2num(answer{1});
[ang_1f status] = str2num(answer{2});
[link_2 status] = str2num(answer{3});
[ang_2f status] = str2num(answer{4});
[link_3 status] = str2num(answer{5});
[ang_3f status] = str2num(answer{6});

a1 = 90;
a2 = 90;
a3 = 90;
br = 0;
position = [];
while(1)
    if (rem(a1,360) ~= ang_1f)
        ang_1 = (a1 - 90) * 3.14 / 180;
        ang_2 = (a2 - 90) * 3.14 / 180;
        ang_3 = (a3 - 90) * 3.14 / 180;
        if (a1 > ang_1f)
            a1 = a1 - 1;
        else
            a1 = a1 + 1;
        end
    else
        ang_1 = (ang_1f - 90) * 3.14 / 180;
        if (rem(a2,360) ~= ang_2f)
            ang_2 = (a2 - 90) * 3.14 / 180;
            ang_3 = (a3 - 90) * 3.14 / 180;
            if (a2 > ang_2f)
                a2 = a2 - 1;
            else
                a2 = a2 + 1;
            end
        else
            ang_2 = (ang_2f - 90) * 3.14 / 180;
            if (rem(a3,360) ~= ang_3f)
                ang_3 = (a3 - 90) * 3.14 / 180;
                if (a3 > ang_3f)
                    a3 = a3 - 1;
                else
                    a3 = a3 + 1;
                end
            else
                ang_3 = (ang_3f - 90) * 3.14 / 180;
                br = 1;
            end
        end
    end
    
    matrix_1 = [cos(ang_1), -sin(ang_1), 0, 0; sin(ang_1), cos(ang_1), 0, 0; 0, 0, 1, 0; 0, 0, 0, 1];
    matrix_2 = [cos(ang_2), -sin(ang_2), 0, 0; sin(ang_2), cos(ang_2), 0, link_1; 0, 0, 1, 0; 0, 0, 0, 1];
    matrix_3 = [cos(ang_3), -sin(ang_3), 0, link_2; sin(ang_3), cos(ang_3), 0, 0; 0, 0, 1, 0; 0, 0, 0, 1]; 
    
    point_1 = [0; 0; 0; 0];
    point_2 = matrix_1 * [0; link_1; 0; 1];
    point_3 = matrix_1 * matrix_2 * [link_2; 0; 0; 1];
    point_4 = matrix_1 * matrix_2 * matrix_3 * [0; -link_3; 0; 1];

    length_max = link_1 + link_2 + link_3;

    points = [point_1, point_2, point_3, point_4];

    x = points(1 : 1, 1 : 4); 
    y = points(2 : 2, 1 : 4);
    centers = transpose([x; y]);
    radii = [0.5; 0.5; 0.5; 0.5];
    hold off;
    plot(0, 0);
    axis([-length_max length_max -length_max length_max]);
    temp = centers(4, 1:2);
    position = [position; temp];
    hold all;
    plot(x, y);
    plot(position(:, 1), position(:, 2), 'b', 'linewidth', 3);
    viscircles(centers,radii);
    axis([-length_max length_max -length_max length_max]);
    pause(0.01);
    if (br == 1)
        break;
    end
end
clear all;
hold off;
    
