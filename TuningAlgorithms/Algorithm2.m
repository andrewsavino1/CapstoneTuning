function [outputFreqs, F, improvement] = Algorithm2(tuned_chord, f, ii, ET_notes, ET_tolerance_bands)

untuned_chord = ET_notes(ii);
log2chorduntuned = log2(untuned_chord);
log2chordtuned = log2(tuned_chord);
log2Tolerances = log2(ET_tolerance_bands(:,ii));

LS_tolerance = min(log2chordtuned - log2Tolerances(1,:));
RS_tolerance = min(log2Tolerances(2,:) - log2chordtuned);

% positive means tuned sharper, negative means overall made flatter
overall_offset = sum(log2chordtuned - log2chorduntuned);

if overall_offset > 0
    change = - min(overall_offset, LS_tolerance)/length(tuned_chord);
    outputFreqs = tuned_chord * 2^(change);
    F = f * 2^(change);
elseif overall_offset < 0
    change =  min(-overall_offset, RS_tolerance)/length(tuned_chord);
    outputFreqs = tuned_chord * 2^(change);
    F = f * 2^(change); 
end
log2returned = log2(outputFreqs);
new_offset = sum(log2returned - log2chorduntuned);
improvement = (overall_offset - new_offset)/overall_offset;
end

