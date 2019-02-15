function [et_notes, tolerance_bands] = generateETNotes(startIndex, endIndex)
%GENERATEETNOTES returns array [startIndex, endIndex] of equal
% temperament frequencies.  Assumes A4=440.

A4 = 440;         % frequency typically associated with A4 in western music
A4_pos = 49;      % A4 is 49th note on piano
max_cent_change = 49;   % controls algo's wiggle room
index = 1;

et_notes = ones(1, endIndex-startIndex+1);
for i=startIndex:endIndex
    et_notes(index) = A4*(2^(1/12))^(i-A4_pos);
    index = index+1;
end

tolerance_bands = zeros(2,88);
for i = 1:88
    tolerance_bands(1,i) = changeByCents(et_notes(i), -1*max_cent_change);
    tolerance_bands(2,i) = changeByCents(et_notes(i), max_cent_change);
end
end

function [outputFreq] = changeByCents(startingFreq, deltCents)
    outputFreq = startingFreq * 2^(deltCents/1200);
end
