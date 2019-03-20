%% Method for analyzing freq spectrum of input audio signal

audioFile = 'benSingingA.wav';

[input_signal, fs] = audioread(audioFile);

% Capture 8192 samples at 44.1kHz sample rate
Nsamps = 8192;
fsamp = 44100;
Tsamp = 1/fsamp;
t = 1:length(input_signal);

% Plot time-domain signal
subplot(2,1,1);
plot(t, input_signal);
ylabel('Amplitude'); 
xlabel('Time (secs)');
axis tight;
title('Input Signal -- Ben Singing A');

% Choose FFT size and calculate spectrum
Nfft = 1024;
[Pxx,f] = pwelch(input_signal,gausswin(Nfft),Nfft/2,Nfft,fsamp);

% Plot frequency spectrum
subplot(2,1,2);
plot(f,Pxx);
ylabel('PSD'); 
xlabel('Frequency (Hz)');
axis auto;
grid on;

% Get frequency estimate (spectral peak)
[~,loc] = max(Pxx);
estimate = f(loc);
FREQ_ESTIMATE = estimate(1,:)
title(['Frequency estimate = ',num2str(FREQ_ESTIMATE(1)),' Hz']);


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


