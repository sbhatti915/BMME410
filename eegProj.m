% Sameer Bhatti
% sabhatti@live.unc.edu
% 4/3/19
% eegProj.m
%
% Produces filtered signals in time-domain of an EEG signal

clc
clear all
close all
%% Declarations
x = xlsread('eegData.xlsx');
x(:,2) = x;

for k = 1:length(x(:,2))
    x(k,1) = 0.1 + 0.0025*(k-1);
end

eegVoltRaw = x(:,2);
timeRaw = x(:,1);

%% Question 1
time = timeRaw(272:272+1023);
eegVolt = eegVoltRaw(272:272+1023);

plot(time,eegVolt)
xlabel('time (s)')
ylabel('EEG (mV)')
title('EEG Section of Alpha Wave')
saveas(gcf,'Prob1.jpg')

%% Question 2
figure
mag = fft(eegVolt);
freq = (1/0.0025)*(1/1024)*(1:1024);

plot(freq,abs(mag))
xlabel('freq (Hz)')
ylabel('|x[k]|')
title('Frequency Response of 1024 points')
saveas(gcf,'Prob2.jpg')
%% Question 3
lowPassMag = mag;
lowPassMag(find(freq<=20, 1, 'last' )+1:find(freq>=380, 1 )-1) = 0;

figure
plot(freq,abs(lowPassMag))
title('Low Pass Filter at 20Hz')
xlabel('frequency (Hz)')
ylabel('|x[k]|')
saveas(gcf,'Prob3.jpg')

%% Question 4
inverseMag = ifft(lowPassMag);

figure
plot(time,inverseMag)
xlabel('time (s)')
ylabel('EEG (mV)')
title('EEG signal lowpass filtered')
saveas(gcf,'Prob4.jpg')

%% Question 5
[b,a] = butter(1,20/400);
H = freqz(b,a,1024);
buttFilt = mag.*H;
buttFiltMag = buttFilt;
buttFilt(end/2+1:end) = buttFilt(end/2:-1:1);

figure
plot(freq,abs(buttFilt))
xlabel('frequency (Hz')
ylabel('|[x[k]|')
title('Butterworth filter Magnitude')
saveas(gcf,'Prob5.jpg')

invButtFilt = ifft(buttFiltMag);

figure
plot(time,invButtFilt)
xlabel('time (s)')
ylabel('EEG (mV)')
title('Butterworth Filter of EEG')
saveas(gcf,'Prob6.jpg')