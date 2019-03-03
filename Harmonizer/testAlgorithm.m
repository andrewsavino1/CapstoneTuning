function [outputFreqs] = testAlgorithm(inputIndexes)
%ALGORITHM1 Seeks to maximize the fundamental Frequency st. adjusting the
%original notes as little as possible

%adjustable params:
max_multiple = 24;
low_index = 1;
high_index = 88;

[ET_notes, ET_tolerance_bands] = generateETNotes(low_index,high_index);

end

