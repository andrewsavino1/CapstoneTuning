% %% Audio device (microphone) input
% deviceReader = audioDeviceReader(mic_sr);
% setup(deviceReader);

recorder = audiorecorder(44100,8,1,0);

record(recorder, 5);

b = getaudiodata(recorder);

sound(b, 44100);