%% Method for analyzing freq spectrum of input audio signal

audioFile = 'SpeechTest.wav';

[input_signal, fs] = audioread(audioFile);

sound(input_signal, fs);

t = 1:length(input_signal);

plot(t, input_signal)

%periodgram(input_signal)
data = input_signal(:,1);
dspdata.psd(data, fs)