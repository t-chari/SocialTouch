%Code written to Calculate Area within the Mouse's Eye as a Feature of
%Aversion

%First read the DeepLabCut excel  files to extract the X and Y coordinates of
%each point around the eye

%Extract X coordinates for all points
% close all
% clear

clear all
close all
clc

%finds the folder of interest
rd_dir = 'F:\Trish\Neuropixels Face Videos\\Orbital Tightening Files';
%saves the aligned videos to new folder
sv_dir = 'F:\Trish\Neuropixels Face Videos\\Orbital Tightening Files\\Filtered';
mkdir(sv_dir);

files = dir(fullfile(rd_dir,'*.csv'));

for aa = 1:size(files,1)
    thisF = files(aa).name;
    filenum = aa;
    
    disp(thisF)

EyeFile = readtable(fullfile(rd_dir,thisF));
    
eyex1 = EyeFile(:,2);

eyex1 = table2array(eyex1);
% eyex1 = str2double(eyex1);
% eyex1(1:1:2) = [];

eyex2 = EyeFile(:,5);

eyex2 = table2array(eyex2);
% eyex2 = str2double(eyex2);
% eyex2(1:1:2) = [];

eyex3 = EyeFile(:,8);

eyex3 = table2array(eyex3);
% eyex3 = str2double(eyex3);
% eyex3(1:1:2) = [];

eyex4 = EyeFile(:,11);

eyex4 = table2array(eyex4);
% eyex4 = str2double(eyex4);
% eyex4(1:1:2) = [];

eyex5 = EyeFile(:,14);

eyex5 = table2array(eyex5);
% eyex5 = str2double(eyex5);
% eyex5(1:1:2) = [];

eyex6 = EyeFile(:,17);

eyex6 = table2array(eyex6);
% eyex6 = str2double(eyex6);
% eyex6(1:1:2) = [];

eyex = [eyex1, eyex2, eyex3, eyex4, eyex5, eyex6];

eyex = eyex.';
% 
% Extract Y coordinates for all points

eyey1 = EyeFile(:,3);

eyey1 = table2array(eyey1);
% eyey1 = str2double(eyey1);
% eyey1(1:1:2) = [];

eyey2 = EyeFile(:,6);

eyey2 = table2array(eyey2);
% eyey2 = str2double(eyey2);
% eyey2(1:1:2) = [];

eyey3 = EyeFile(:,9);

eyey3 = table2array(eyey3);
% eyey3 = str2double(eyey3);
% eyey3(1:1:2) = [];

eyey4 = EyeFile(:,12);

eyey4 = table2array(eyey4);
% eyey4 = str2double(eyey4);
% eyey4(1:1:2) = [];

eyey5 = EyeFile(:,15);

eyey5 = table2array(eyey5);
% eyey5 = str2double(eyey5);
% eyey5(1:1:2) = [];

eyey6 = EyeFile(:,18);

eyey6 = table2array(eyey6);
% eyey6 = str2double(eyey6);
% eyey6(1:1:2) = [];

eyey = [eyey1, eyey2, eyey3, eyey4, eyey5, eyey6];

eyey = eyey.';

%Calculate area of polygon 

EyeArea = polyarea(eyex, eyey);

EyeArea = EyeArea.';

EyeAreanew = EyeArea(1:120*(floor(length(EyeArea)/120)));

EyeAreaSecs = mean(reshape(EyeAreanew, 120, []));

EyeAreaSecs = EyeAreaSecs.';

EyeAreaframes = EyeArea;
EyeAreaframesh = hampel(EyeArea);
EyeAreaframes = EyeAreaframes * (25.4/729);
EyeAreaframesh = EyeAreaframesh * (25.4/729);
EyeAreaH = hampel(EyeAreaSecs);
EyeAreaHmm = EyeAreaH * (25.4/729);
EyeAreaHmm = EyeAreaHmm(1:length(EyeAreaHmm));
figure(aa)
plot(EyeAreaHmm)
xlim([0 450])
ylim([0 180])
xlabel("Time (in seconds)")
ylabel("Area (pixels^2)")

thisM = [thisF, '.mat'];
save(fullfile(sv_dir, thisM), 'EyeArea','EyeAreaH','EyeAreaHmm', 'EyeAreaframes', 'EyeAreaframesh');

end

% EyeAreahampel = hampel(EyeArea);
% EyeAreamm = EyeAreahampel * (25.4/729);
% figure(2)
% plot(EyeAreamm)
% xlim([0 6000])
% xlabel("Time (in seconds)")
% ylabel("Area (mm^2)")

%Determine the weight of orbital tightening based on max area
% 
% %No tightening
% OTWeight(1,150) = zeros;
% 
% for i = 1:length(OTWeight)
% %No tightening
%     if EyeAreaSecs(i) >= 0.75*(max(EyeAreaSecs))
%         OTWeight(i) = 0;
% %Moderate tightening
%     elseif EyeAreaSecs(i) < 0.75*(max(EyeAreaSecs)) & EyeAreaSecs(i) > 0.25*(max(EyeAreaSecs))
%         OTWeight(i) = 0.5;
% %Extreme tightening
%     elseif EyeAreaSecs(i) <= 0.25*(max(EyeAreaSecs))
%         OTWeight(i) = 1;
%     end
% end
