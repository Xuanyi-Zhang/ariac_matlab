filename='laser_scan_log.csv';
part1='CN1:CN15353';
part2='CO1:CO15353';
part3='CP1:CP15353';
part4='CQ1:CQ15353';
Piston_rod='CR1:CR15353';
Gear_part='CS1:CS15353';
Gasket='CT1:CT15353';
Pulley='CU1:CU15353';
z_avg_range='D1:D15353';
z_min_range='C1:C15353';
z_max_range='B1:B15353';
[z_avg,z_avg_string]=xlsread(filename,z_avg_range);
[z_min,z_min_string]=xlsread(filename,z_min_range);
[z_max,z_max_string]=xlsread(filename,z_max_range);
part_name=[part1,part2,part3,part4,Piston_rod,Gear_part,Gasket,Pulley];

for k=1:8
a=0;
b=0;
    a=1+11*(k-1);
    b=a+10;
[marker1,string]=xlsread(filename,1,part_name(a:b));

size_data1=size(marker1);
z_avg_data=0;
z_avg_sum=0;
z_smallest=2;
z_biggest=0;
% average value of z_avg in .csv when part exists.
% minimal value of the part
% maximal value of the part
for i=1:size_data1(1)
    if marker1(i)==0
        z_avg_data=[z_avg_data,z_avg(i)]; 
        if(z_min(i)<z_smallest)
            z_smallest=z_min(i);
        end
        
        if(z_max(i)>z_biggest)
            z_biggest=z_max(i);
        end
    end
end
size1=size(z_avg_data);
for j=2:size1(2)
    z_avg_sum=z_avg_sum+z_avg_data(j);
end
data_number(k)=size1(2)-1;
z_smallest1(k)=z_smallest;
z_biggest1(k)=z_biggest;
z_avg_all(k)=z_avg_sum/data_number(k);
z_matrix=[z_smallest,z_avg_all,z_biggest];
SD(k)=std(z_matrix);

end
f = figure('Position',[25 25 700 200]);

% create the data
d = [data_number
     z_smallest1
     z_avg_all
     z_biggest1
     SD];

% Create the column and row names in cell arrays 
cnames = {'ground_part1','ground_part2','ground_part3','ground_part4','ground_Piston_rod','ground_Gear_part','ground_Gasket','ground_Pulley'};
rnames = {'data_number','z_min','z_avg','z_max','SD'};

% Create the uitable
t = uitable(f,'Data',d,...
            'ColumnName',cnames,... 
            'RowName',rnames);
t.Position(3:4) = t.Extent(3:4);

