% Method for analyzing freq spectrum of input audio signal
% Choose FFT size and calculate spectrum
Nfft = 1024;
fsamp = 44100;
Tsamp = 1/fsamp;

audioFile = 'three_note_progression.wav';

[input_signal, fs] = audioread(audioFile);

t1 = 1:length(input_signal);

subplot(2,1,1)
spectrogram(input_signal(:,1),gausswin(Nfft),Nfft/2,Nfft,fsamp, 'yaxis');
title('Singing A4 with "Ah" vowel');
set(gca, 'yscale','log');


% Plot frequency spectrum
subplot(2,1,2);
[Pxx,f] = pwelch(input_signal,gausswin(Nfft),Nfft/2,Nfft,fsamp);


loglog(f,Pxx);
ylabel('PSD'); 
xlabel('Frequency (Hz)');
axis auto;
grid on;

% Get frequency estimate (spectral peak)
[~,loc] = max(Pxx);
estimate = f(loc);

FREQ_ESTIMATE_gaussian = estimate(1,:);


% title('Periodogram Power Spectral Density Estimate');
title(['PSD Frequency estimate = ',num2str(FREQ_ESTIMATE_gaussian(1)),' Hz']);


sound(input_signal, 44100)
pause(length(input_signal)/44100)
sound(input_signal, (3/2)*44100)
% %sound(input_signal, (5/4)*44100)
sound(input_signal, (6/5)*44100)
% %sound(input_signal, (7/4)*44100)
sound(input_signal, (8/5)*44100)
