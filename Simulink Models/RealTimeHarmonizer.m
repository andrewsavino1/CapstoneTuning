%% Constant variables
mic_sr = 44100;                 % sample rate of mic input
spf = 1024;                     % samples per frame in mic input (default)
mic_update_fr = spf/mic_sr;     % rate at which we run pitch detection
Nfft = spf;

%% Algorithm setup
low_index = -20;
high_index = 88;
offset = low_index - 1;
[ET_notes, ET_tolerance_bands] = generateETNotes(low_index,high_index);
F = 1;


%% MIDI device setup
devName = 'Yamaha CP40 STAGE-1';           % run mididevinfo to find name
active_notes = zeros(0,1);
accomp_freq = zeros(0,1);
go = 1;
MIDI_BIAS = -20;
device = mididevice(devName);


%% Audio device (microphone) input
deviceReader = audioDeviceReader(mic_sr);
setup(deviceReader);

%% Time-keeping Variables for Harmoinzer
next_mic_read = 0;


%% Harmonizer main loop
tic()                           % use this to refresh at constant rate

while true
    % update the currently played notes if new MIDI signals in buffer
    if hasdata(device)
        inputMessages = midireceive(device);
        [num_messages,~] = size(inputMessages);
        for i=1:1:num_messages
            try
                if isNoteOn(inputMessages(i))
                     note = inputMessages(i).Note + MIDI_BIAS;
                     active_notes = [active_notes note];
                     active_notes = sort([active_notes, note]);
                end
                if isNoteOff(inputMessages(i))
                    note = inputMessages(i).Note + MIDI_BIAS;
                    active_notes = active_notes(active_notes~=note);
                end
            catch ME
                disp(ME)
            end
        end
        if ~isempty(active_notes)
            [accomp_freq, F] = Algorithm1(unique(active_notes), ET_notes,...
                ET_tolerance_bands, offset);
        end
    end
    
    % Now, once per cycle, Harmonize
    if next_mic_read <= toc
        
        % find the pitch of the sampled input
        % TODO invesitage audio toolbox' pitch command
        d_sample = deviceReader();
        [Pxx1, f1] = pwelch(d_sample, gausswin(Nfft),Nfft/2,Nfft,mic_sr);
        [~,loc] = max(Pxx1);
        estimate = f1(loc);
        sung_freq = estimate(1,:);
        
        % Calculate Multiples from the alg output and the sample rate
        % conversion from the input to get it to sound at the fundamental
        fund_multiples = accomp_freq./F;
        sr2 = mic_sr*F/sung_freq;
        
        %play the notes:
        for note=1:length(fund_multiples)
            mult = fund_multiples(note);
            timeshift = pvoc(d_sample, 1/mult, Nfft);
            newSound = resample(timeshift,1, double(int16(mult))); 
            % casting to an int because MATLAB has trouble
            sound(newSound, sr2)
        end
           
        next_mic_read = next_mic_read + mic_update_fr;  % read again in 1 sample time
    end 
end


%% helper functions for MIDI device reader

function yes = isNoteOn(msg)
yes = msg.Type == midimsgtype.NoteOn ...
    && msg.Velocity > 0;
end

function yes = isNoteOff(msg)
yes = msg.Type == midimsgtype.NoteOff ...
    || (msg.Type == midimsgtype.NoteOn && msg.Velocity == 0);
end
