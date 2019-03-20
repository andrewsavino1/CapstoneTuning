audio = 'benSingingA.wav';

[input, fs] = audioread(audio);

input = input(1:fs);

%plot(signal);

%sound(signal, 44100);
%sound(signal, 88100);

% b = signal(44100*2 : 44100*3);
% 
% b_repeat = [b ; b ; b];