% Method for analyzing freq spectrum of input audio signal
% Choose FFT size and calculate spectrum
Nfft = 2048;
fsamp = 44100;
Tsamp = 1/fsamp;

audioFile = 'SENOL_SAVINO_ET.wav';
audioFile2 = 'SENOL_SAVINO_JI.wav';

[input_signal, fs] = audioread(audioFile);
[input_signal2, fs2] = audioread(audioFile2);

t1 = 1:length(input_signal);


subplot(2,1,1)
new_signal = input_signal2(:,1) - input_signal(:,1);

[s, w, t] = spectrogram(input_signal(1:205340,1),gausswin(Nfft),Nfft/16,Nfft,fsamp);
spectrogram(input_signal(1:215340,1),gausswin(Nfft),Nfft/16,Nfft,fsamp, 'yaxis');

title('Equal Temperament');
set(gca, 'yscale','log');
ylim([0.2 5]);


% Plot frequency spectrum
subplot(2,1,2);
% spectrogram(input_signal2(:,1),gausswin(Nfft),Nfft/16,Nfft,fsamp, 'yaxis');
set(gca, 'yscale','log');
ylim([0.2 5]);

[Pxx,f] = pwelch(input_signal,gausswin(Nfft),Nfft/32,Nfft,fsamp);


loglog(f,Pxx);
ylabel('PSD'); 
xlabel('Frequency (Hz)');
axis auto;
grid on;

% Get frequency estimate (spectral peak)
[~,loc] = max(Pxx);
estimate = f(loc);

FREQ_ESTIMATE_gaussian = estimate(1,:);


title('Just Intonation');
title(['PSD Frequency estimate = ',num2str(FREQ_ESTIMATE_gaussian(1)),' Hz']);


% soundsc(input_signal, 44100)
% %pause(length(input_signal)/44100)
% sound(input_signal, (3/2)*44100)
% % %sound(input_signal, (5/4)*44100)
% sound(input_signal, (6/5)*44100)
% % %sound(input_signal, (7/4)*44100)
% sound(input_signal, (8/5)*44100)
