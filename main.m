%% first, open and connect MIDI device
devName = 'Yamaha S08-1';
active_notes = zeros(0,1);
go = 1;
MIDI_BIAS = -20;
device = mididevice(devName);

%setup
low_index = 1;
high_index = 88;

[ET_notes, ET_tolerance_bands] = generateETNotes(low_index,high_index);

%% then loop continuously checking for new input
try
    while go
        if hasdata(device)
            receivedMessages = midireceive(device);
            [num_messages,~] = size(receivedMessages);
            for i=1:num_messages
                try
                    note = receivedMessages(i).Note + MIDI_BIAS;
                    vel = receivedMessages(i).Velocity;
                    if vel == 0
                        active_notes = active_notes(active_notes~=note);
                    else
                        active_notes = sort([active_notes, note]);
                    end
                catch ME
                    disp('picked up an invalid signal')
                end
            end
            if ~isempty(active_notes)
                correctedFreqs = Algorithm1(active_notes, ET_notes, ET_tolerance_bands);
                playNotes(correctedFreqs, 4, 3);
            end
            %pause(.1)
        end
    end
catch ME
    disp(ME)
end




