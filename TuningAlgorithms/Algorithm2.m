InputIndexes = [48, 52, 55];
low_index = -3;
high_index = 88;
[ET_notes, ET_tolerance_bands] = generateETNotes(low_index,high_index);
untuned_chord = ET_notes(InputIndexes);
offset = low_index - 1;

[tuned_chord, f] = Algorithm1(InputIndexes, ET_notes, ET_tolerance_bands, offset);

log2F = log2(f);
log2chorduntuned = log2(untuned_chord);
log2chordtuned = log2(tuned_chord);
log2Tolerances = log2(ET_tolerance_bands(:,InputIndexes));

LS_tolerance = min(log2chordtuned - log2Tolerances(1,:));
RS_tolerance = min(log2Tolerances(2,:) - log2chordtuned);

