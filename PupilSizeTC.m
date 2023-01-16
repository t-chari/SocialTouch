rd_dr = '/Users/tchari/Documents/Portera Lab/Data/Pupil Files';

sd_dr = '/Users/tchari/Documents/Portera Lab/Data/Pupil Files/Analyzed Files';

files = dir(fullfile(rd_dr, '*.mat'));

for aa = 1:size(files,1)
    thisF = files(aa).name;
    
    disp(thisF)
    
    load(fullfile(rd_dr, thisF), 'pupil');
     
    
    PDfactor = 25.4/615;
    pupilmm = double(pupil{1,1}.area_smooth)*PDfactor; 
    pupildd = (sqrt(pupilmm/pi))*2;
%     
%     if length(pupilmm) > 6000
%     beftime = 110;
%     elseif length(pupilmm) < 6000
%     beftime = 60;
%     end
%     
    pupilzscore = (pupildd - nanmean(pupildd))/(nanstd(pupildd));

    pupilzscoren = smooth(pupilzscore,120);

      
  
    if length(pupilzscoren) > 9600
    beftime = 110;
    elseif length(pupilzscoren) < 9600
    beftime = 50;
    end
    
    before = 10*30:beftime*30;
    disp(beftime)
    
    
    if length(pupilzscoren) > 9600
    afttime = 150;
    elseif length(pupilzscoren) < 9600
    afttime = 72;
    end
    
    after = afttime*30:(afttime+(5*10.3))*30;
    
    disp(afttime)
    
    befpupil = nanmean(pupilzscoren(before));
    aftpupil = nanmean(pupilzscoren(after));
    
    
    
    vidN = thisF;
    save(fullfile(sd_dr,thisF), 'pupilzscoren','befpupil','aftpupil');
    
end

    