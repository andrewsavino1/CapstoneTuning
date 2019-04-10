[d,sr]=audioread('benSingingE.wav'); 
samp_freq = .2;
rec_len = length(d)/sr;
num_chords = 4;
d_per_chord = length(d)/num_chords;
samples_per_samp_freq = sr*samp_freq;
Nfft = 1024;

low_index = -3;
high_index = 88;
[ET_notes, ET_tolerance_bands] = generateETNotes(low_index,high_index);



chords = [37 41 44;
          39 42 46;
          41 44 48;
          42 46 49];
      
chords = chords +1;
      
tic()
%sound(d,sr)
for chord=1:num_chords
    notes = chords(chord,:);
   
    for t=0:samp_freq:1-samp_freq
        
        % find the pitch of the sampled input
        i1 = uint32(sr*t + (chord-1)*(d_per_chord))+1;
        i2 = i1 + uint32(sr*samp_freq);  %TODO - these are wrong?
        d_sample = d(i1:i2,:);
        [Pxx1, f1] = pwelch(d_sample, gausswin(Nfft),Nfft/2,Nfft,sr);
        [~,loc] = max(Pxx1);
        estimate = f1(loc);
        sung_freq = estimate(1,:);
        
        % run algorithm to get desired frequencies
        [accomp_freq, f] = Algorithm1(notes, ET_notes, ET_tolerance_bands,...
            low_index-1);
        fund_multiples = accomp_freq./f;
        
       % calc new sample rate 
       sr2 = sr*f/sung_freq;
        
        %play the notes:
        for note=1:length(fund_multiples)
            mult = fund_multiples(note);
            timeshift = pvoc(d_sample, 1/mult, Nfft); 
            newSound = resample(timeshift,1, double(int16(mult))); % NB: 0.8 = 4/5   %casting to an int because matlab dum
            sound(newSound, sr2)
        end
        
        pause(samp_freq-.0001);  % should use timer to be smarter about this
    end    
end
toc()