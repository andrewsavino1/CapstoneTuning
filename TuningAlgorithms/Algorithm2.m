InputIndexes = [48, 52, 55] + 1;
low_index = -3;
high_index = 88;
[ET_notes, ET_tolerance_bands] = generateETNotes(low_index,high_index);
offset = low_index - 1;
Offset_Inputs = InputIndexes - offset;
untuned_chord = ET_notes(Offset_Inputs);


[tuned_chord, f] = Algorithm1(InputIndexes, ET_notes, ET_tolerance_bands, offset);

log2F = log2(f);
log2chorduntuned = log2(untuned_chord);
log2chordtuned = log2(tuned_chord);
log2Tolerances = log2(ET_tolerance_bands(:,Offset_Inputs));

LS_tolerance = min(log2chordtuned - log2Tolerances(1,:));
RS_tolerance = min(log2Tolerances(2,:) - log2chordtuned);

% positive means tuned sharper, negative means overall made
% flatter
overall_offset = sum(log2chordtuned - log2chorduntuned);

if overall_offset > 0
    change = - min(overall_offset, RS_tolerance);
    retuned_notes = tuned_chord * 2^(change);
    retuned_f = f * 2^(change);
elseif overall_offset < 0
    change = - max(overall_offset, -1*LS_tolerance);
    retuned_notes = tuned_chord * 2^(change);
    retuned_f = f * 2^(change); 
end
new_offset = sum(log2(retuned_notes) - log2chorduntuned);

