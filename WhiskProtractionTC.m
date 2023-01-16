%Code written to Calculate Relative Position of Mouse's Whiskers as a Feature of
%Aversion

%First reads the DeepLabCut excel files to extract XY coordinates of each
%whisker (out of 6)

%Extract each whisker pad coordinate
% clear
% close all

clear all
close all
clc

%finds the folder of interest
rd_dir = 'F:\Trish\Social Touch Videos\Fmr1KO Mice\Forced\Whisker Protraction Files';
%saves the aligned videos to new folder
sv_dir = 'F:\Trish\Social Touch Videos\Fmr1KO Mice\Forced\Whisker Protraction Files\NewFilt';
mkdir(sv_dir);

files = dir(fullfile(rd_dir,'*.csv'));

for aa = 2:size(files,1)
    %finds the folder of interest
    files = dir(fullfile(rd_dir,'*.csv'));
    thisF = files(aa).name;
    filenum = aa;
    
    disp(thisF)
    
  pause(10)
  close all

whfile = readtable(fullfile(rd_dir,thisF));

x1 = whfile(:,2);
y1 = whfile(:,3);
x2 = whfile(:,5);
y2 = whfile(:,6);
x3 = whfile(:,8);
y3 = whfile(:,9);
x4 = whfile(:,11);
y4 = whfile(:,12);
x5 = whfile(:,14);
y5 = whfile(:,15);
x6 = whfile(:,17);
y6 = whfile(:,18);


%x1, y1
x1 = table2array(x1);


% x1 = mean(reshape(x1, 50, []));


y1 = table2array(y1);


% y1 = mean(reshape(y1, 50, []));


%x2, y2
x2 = table2array(x2);



y2 = table2array(y2);

%x3, y3
x3 = table2array(x3);


y3 = table2array(y3);

%x4, y4
x4 = table2array(x4);


y4 = table2array(y4);


%x5, y5
x5 = table2array(x5);

y5 = table2array(y5);

%x6, y6

x6 = table2array(x6);

y6 = table2array(y6);



%Generate a variable containing coordiantes for all points

start = 'enter start time of interaction';
last = 'enter last time of interaction'; 

W1 = [x1(:), y1(:), x2(:), y2(:), x3(:), y3(:), x4(:), y4(:), x5(:), y5(:), x6(:), y6(:)];
Wh1 = hampel(W1);
Wh2 = mean(Wh1([(input(start)):(input(last))], :), 1);
Wh3=Wh1;
Wh3(:,1) = Wh1(:,1)-Wh2(:,1);
Wh3(:,2) = Wh1(:,2)-Wh2(:,2);
Wh3(:,3) = Wh1(:,3)-Wh2(:,3);
Wh3(:,4) = Wh1(:,4)-Wh2(:,4);
Wh3(:,5) = Wh1(:,5)-Wh2(:,5);
Wh3(:,6) = Wh1(:,6)-Wh2(:,6);
Wh3(:,7) = Wh1(:,7)-Wh2(:,7);
Wh3(:,8) = Wh1(:,8)-Wh2(:,8);
Wh3(:,9) = Wh1(:,9)-Wh2(:,9);
Wh3(:,10) = Wh1(:,10)-Wh2(:,10);
Wh3(:,11) = Wh1(:,11)-Wh2(:,11);
Wh3(:,12) = Wh1(:,12)-Wh2(:,12);

%Determine the distance changed relative to the original position

timeavg = 3000;

%Whisker 1

origx1 = mean(x1([1:timeavg]));
origy1 = mean(y1([1:timeavg]));

x1 = transpose(x1);
y1 = transpose(y1);

distxy1 = sqrt((x1-origx1).^2 + (y1-origy1).^2);

distxy1 = transpose(distxy1);

%Whisker 2

origx2 = mean(x2([1:timeavg]));
origy2 = mean(y2([1:timeavg]));

x2 = transpose(x2);
y2 = transpose(y2);

distxy2 = sqrt((x2-origx2).^2 + (y2-origy2).^2);

distxy2 = transpose(distxy2);

%Whisker 3

origx3 = mean(x3([1:timeavg]));
origy3 = mean(y3([1:timeavg]));

x3 = transpose(x3);
y3 = transpose(y3);

distxy3 = sqrt((x3-origx3).^2 + (y3-origy3).^2);

distxy3 = transpose(distxy3);

%Whisker 4 

origx4 = mean(x4([1:timeavg]));
origy4 = mean(y4([1:timeavg]));

x4 = transpose(x4);
y4 = transpose(y4);

distxy4 = sqrt((x4-origx4).^2 + (y4-origy4).^2);

distxy4 = transpose(distxy4);

%Whisker 5
origx5 = mean(x5([1:timeavg]));
origy5 = mean(y5([1:timeavg]));

x5 = transpose(x5);
y5 = transpose(y5);

distxy5 = sqrt((x5-origx5).^2 + (y5-origy5).^2);

distxy5 = transpose(distxy5);

%Whisker 6
origx6 = mean(x6([1:timeavg]));
origy6 = mean(y6([1:timeavg]));

x6 = transpose(x6);
y6 = transpose(y6);

distxy6 = sqrt((x6-origx6).^2 + (y6-origy6).^2);


distxy6 = transpose(distxy6);

%Average Distance of Whisker Travel

distwhisker = [distxy1, distxy2, distxy3, distxy4, distxy5, distxy6];

distwhisker = transpose(distwhisker);
meandist = mean(distwhisker);
meandist = transpose(meandist);
figure(50)
plot(meandist);

%Create a bandpass filter to remove any abnormal targeting of whiskers in
%pixel space

figure(51)
fs = 1e3;
lowpass(meandist,1,fs);
filtdist = lowpass(meandist,1,fs);
filtorig = filtdist;

%Remove any whisking retraction from mean dist so only the distance moved
%for protraction are showed (x tells protraction vs retraction and we take the mean of all x coordinates)

whiskx = [Wh3(:,1), Wh3(:,3), Wh3(:,5), Wh3(:,7), Wh3(:,9), Wh3(:,11)];
whiskx = transpose(whiskx);
medianw = median(whiskx);
medianwsm = smooth(medianw, 10);
figure; plot(medianwsm);
prodisp = "what is the displacement relative to baseline";

medpro = find(medianwsm < input(prodisp));
distance = diff(medpro);
testdistance = find(distance == 1);
distance = diff(medpro');
[B, N, Ind] = RunLength(distance);
Ind         = [Ind, length(distance)+1];
Multiple    = find(N > 1);
Start       = Ind(Multiple);
Stop        = Ind(Multiple + 1) - 1;
n = Stop - Start;
lengthof = find(n>100);

allstarts = Start(lengthof);
allends = Stop(lengthof);
medprostart = medpro(allstarts);
medproend = medpro(allends);

endbaseline = "when does baseline end";

medprostart = medprostart(medprostart>65*50);
medproend = medproend(medprostart>65*50);

totalwhispro = sum(medproend-medprostart);

newfiltdist = medianwsm;




thisM = [thisF, '.mat'];
save(fullfile(sv_dir, thisM), 'newfiltdist', 'totalwhispro', 'medpro', 'allstarts', 'allends', 'medprostart', 'medproend');

clearvars -except aa rd_dir sv_dir
end
