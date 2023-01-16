clear all
clc

%finds the folder of interest
rd_dir = 'F:\Trish\Social Touch Videos\Fmr1KO Mice\Forced\Orbital Tightening Files\Filtered';
%saves the filtered calculation to new folder
sv_dir = 'F:\Trish\Social Touch Videos\Fmr1KO Mice\Forced\Orbital Tightening Files\Z-score Averages';
mkdir(sv_dir);

files = dir(fullfile(rd_dir,'*.mat'));

%run through each video and calculates for each condition
for aa = 1:size(files,1)
    thisF = files(aa).name
    filenum = aa;
    
    %loads each file, needs to be transposed to be a column array
    load(fullfile(rd_dir,thisF));
    
%     hsecmouth = transpose(hsecmouth);
    
    %provides prompts for entering the start and end of each behavioral
    %measure
    start = 'enter start time of interaction';
    last = 'enter last time of interaction'; 
    
    %provides prompts for entering the start and end frame where values
    %should be converted to NaN - this is if there are any frames where the
    %behavior is being interfered with (ie. grooming)
    firstskip = 'first frame to skip'
    secondskip = 'second frame to skip'
    
    newEyeAreaHmm = EyeAreaHmm(~isnan(EyeAreaHmm));
    newEyeAreaHmm = (newEyeAreaHmm - nanmean(newEyeAreaHmm))/nanstd(newEyeAreaHmm);
    disp('which frames to omit')
    %this code goes will keep asking if there are frames that need to be
    %converted to NaN values until you say No (N)
    while(1)
        EyeAreaHmm(input(firstskip):input(secondskip))=nan;
        m = input('Do you want to continue, Y/N [Y]:', 's')
        if m=='N'
            break
        end
    end
    
    EyeAreaHmm = (EyeAreaHmm - nanmean(EyeAreaHmm))/nanstd(EyeAreaHmm);
    
    threshold = 'enter threshold that squinting occurs at';
    figure; findchangepts(newEyeAreaHmm, 'Statistic', 'std', 'MinThreshold', 20);
    P = prctile(EyeAreaHmm, 15)
    EyeSquints = find(EyeAreaHmm((input(start)):(input(last))) < input(threshold));
    %begin calculation for each of the behavioral measures
    %before is condition before social touch begins
    disp('before')
    
    AvgBeforeTouch = mean((EyeAreaHmm((input(start)):(input(last)))), 'omitnan');
    
    %during is condition for behavior during social touch
    disp('during')
    
    AvgDuringTouch = mean((EyeAreaHmm((input(start)):(input(last)))), 'omitnan');
    
    %condition for first 5 social touch presentations
    disp('first 5')
    
    AvgFirst5 = mean((EyeAreaHmm((input(start)):(input(last)))), 'omitnan');
    
    disp('last 5')
    
    %condition for last 5 social touch presentations
    AvgLast5 = mean((EyeAreaHmm((input(start)):(input(last)))), 'omitnan');
    
    %saves relevant .mat files to a new file
    thisM = [thisF, '.mat'];
    save(fullfile(sv_dir, thisM), 'AvgBeforeTouch','AvgDuringTouch','AvgFirst5','AvgLast5', 'EyeSquints');

end

