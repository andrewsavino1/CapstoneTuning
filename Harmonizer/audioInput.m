%% Method for analyzing freq spectrum of input audio signal

audioFile = 'benSingingA.wav';

[input_signal, fs] = audioread(audioFile);

% sound(input_signal, fs);

t = 1:length(input_signal);

%plot(t, input_signal)
[max_amp, freq] = max(input_signal);

freqSang = freq(:,1)/441;
sound(freqSang, 8192);

fprintf('The frequency sang was %.2f\n', freqSang);



input_signal = input_signal(1:fs);
spectrogram(input_signal, 256, [], [], fs, 'xaxis')

%s = spectrogram(input_signal);
%spect(x, 'yaxis')

%periodgram(input_signal)
%data = input_signal(:,1);
%dspdata.psd(data, fs)

% x = randn(1000,1);
%    [y,f,t,p] = spectrogram(x,256,250,256,1000);
%    % now to create an equivalence between the column vectors
%    % in p
%    win = hamming(256);
%    xdft = fft(x(1:256).*win);
%    psdx = abs(xdft(1:length(xdft)/2+1)).^2;
%    psdx = 1/(1000*norm(win,2)^2)*psdx;
%    psdx(2:end-1) = 2*psdx(2:end-1);
%    % now compare
%    subplot(211)
%    plot(psdx)
%    subplot(212)
%    plot(p(:,1))