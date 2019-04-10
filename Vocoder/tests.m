[d,sr]=audioread('benSingingC.wav'); 
% 1024 samples is about 60 ms at 16kHz, a good window 
y=pvoc(d,.75,1024); 
% Compare original and resynthesis 
%sound(d,sr) 
%sound(y,sr)

% e = pvoc(d, 0.8, 1024); 
% f = resample(e, 4, 5); % NB: 0.8 = 4/5 
% sound(f, sr)

for i=1:5
    e = pvoc(d, 5/i, 1024); 
    f = resample(e, 5, i); % NB: 0.8 = 4/5 
    sound(f, sr)
    sound(d, sr)
    pause(3)
end