function [note,velocity] = parseMessage(midiMessage)
%PARSEMESSAGE 
%Input: a 1x3 array of bits, whose meanings can be found here:
%https://www.midi.org/specifications/item/table-1-summary-of-midi-message
%Output: 

%params:
midi_piano_offset = -20;

%currently ignore first byte since my keyboard appears to only throw
%on messages (does off by setting velocity to 0)

note = midiMessage(2) + midi_piano_offset;
velocity = midiMessage(3);
end

