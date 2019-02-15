function [array] = generateETNotes(startIndex, endIndex)
%GENERATEETNOTES returns array [startIndex, endIndex] of equal
% temperament frequencies.  Assumes A4=440.
array = ones(1, endIndex-startIndex+1);
A4 = 440;
A4_pos = 49;
index = 1;
for i=startIndex:endIndex
    array(index) = A4*(2^(1/12))^(i-A4_pos);
    index = index+1;
end
end

