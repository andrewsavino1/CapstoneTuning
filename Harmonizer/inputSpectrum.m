%% Method for analyzing freq spectrum of input audio signal

audioFile1 = 'jonah_A_Ah.wav';
audioFile2 = 'jonah_F_Oo.wav';
audioFile3 = 'jonah_E_Oo.wav';

[input_signal1, fs1] = audioread(audioFile1);
[input_signal2, fs2] = audioread(audioFile2);
[input_signal3, fs3] = audioread(audioFile3);

% Capture 8192 samples at 44.1kHz sample rate
%Nsamps = 8192;
fsamp = 44100;
Tsamp = 1/fsamp;
t1 = 1:length(input_signal1);
t2 = 1:length(input_signal2);
t3 = 1:length(input_signal3);

% Plot time-domain signal
% subplot(2,1,1);
% plot(t, input_signal);
% ylabel('Amplitude'); 
% xlabel('Time (secs)');
% axis auto;
%title('Input Signal -- Singing E4 with "Oo" vowel');

% Choose FFT size and calculate spectrum
Nfft = 1024;

subplot(2,1,1)
spectrogram(input_signal1(:,1),gausswin(Nfft),Nfft/2,Nfft,fsamp, 'yaxis');
title('Singing E4 with "Oo" vowel');
set(gca, 'yscale','log');


% Plot frequency spectrum
subplot(2,1,2);
[Pxx1,f1] = pwelch(input_signal1,gausswin(Nfft),Nfft/2,Nfft,fsamp);
[Pxx2,f2] = pwelch(input_signal2,gausswin(Nfft),Nfft/2,Nfft,fsamp);
[Pxx3,f3] = pwelch(input_signal3,gausswin(Nfft),Nfft/2,Nfft,fsamp);

favg = (f1+f2+f3)/3;
Pxxavg = (Pxx1+Pxx2+Pxx3)/3;

loglog(f1,Pxx1);
ylabel('PSD'); 
xlabel('Frequency (Hz)');
axis auto;
grid on;

% Get frequency estimate (spectral peak)
[~,loc] = max(Pxx);
estimate = f(loc);
FREQ_ESTIMATE_gaussian = estimate(1,:);
%title('Periodogram Power Spectral Density Estimate');
title(['PSD Frequency estimate = ',num2str(FREQ_ESTIMATE_gaussian(1)),' Hz']);

% sound(input_signal1, 44100)
% sound(input_signal, (3/2)*44100)
% %sound(input_signal, (5/4)*44100)
% sound(input_signal, (6/5)*44100)
% %sound(input_signal, (7/4)*44100)
% sound(input_signal, (8/5)*44100)

%%
% % sound(input_signal, fs);
% 
% %t = 1:length(input_signal);
% %plot(t, input_signal)
% 
% input_seg = input_signal(1:fs);
% abs_seg = abs(input_seg);
% 
% [max_amp, freq] = max(input_signal, 5)
% 
% freqSang = freq(:,1)/44100;
% sound(freqSang, 44100);
% 
% input_signal = input_signal(1:fs);
% fprintf('The frequency sang was %.2f\n', freqSang);
% 
% 
% spectrogram(input_signal, 256, [], [], fs, 'xaxis')


