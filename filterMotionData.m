% Filters all the raw pupil data in rd_dir using a variety of metrics
%
% Output file vars: 
%   dd: diameter_data_3 filtered based on std*2 and bad diameter
%       qualities (< 1 st dev below mean quality)
%   ddwin: dd moving mean of size 3
%   ddwinstd: std of the window, for quality control purposes (perhaps)
%   dd_scaled: dd scaled to 1/3 of measurements (about 10 hz)

% read-in directory with raw mat files
rd_dir = '/Volumes/Seagate Backup Plus Drive/Social Touch Backup Seagate/GC_Ball_Motion-master/GC_Ball_Motion-master/Data';

% save directory for filtered mat files
sv_dir = '/Volumes/Seagate Backup Plus Drive/Social Touch Backup Seagate/GC_Ball_Motion-master/GC_Ball_Motion-master/FilteredData';
mkdir(sv_dir);

files = dir(fullfile(rd_dir,'*.mat'));

win = 3;

for aa = 1:size(files,1)
    thisF = files(aa).name;
   
    load(fullfile(rd_dir,thisF), 'medians');
    
    dd = medians;
    
    for i=1:length(medians)
        dd(dd<2)=nan;
    end
    
    vidN = thisF;
    save(fullfile(sv_dir,thisF), 'medians','dd');
    
end
