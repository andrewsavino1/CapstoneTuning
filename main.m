%% first, open and connect MIDI device
midi_interface('open')
active_notes = zeros(0,1);
go = 1;


%% then loop continuously checking for new input
try
    while go
        [messages, times] = midi_interface();
        [~,num_messages] = size(messages);
        for i=1:num_messages
            [note, vel] = parseMessage(messages(:,i));
            if vel == 0
                active_notes = active_notes(active_notes~=note);
            else
                active_notes = sort([active_notes, note]);
            end
        end
        if ~isempty(active_notes)
            correctedFreqs = Algorithm1(active_notes);
            playNotes(correctedFreqs, 4, 3);
        end
        pause(1)
    end
catch ME
    midi_interface('close') 
end
    
    
    
    
