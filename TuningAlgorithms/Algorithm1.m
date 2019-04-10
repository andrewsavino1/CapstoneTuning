function [outputFreqs, F] = Algorithm1(InputIndexes, ET_notes, ET_tolerance_bands, offset)
%ALGORITHM1 Seeks to maximize the fundamental Frequency st. adjusting the
%original notes as little as possible
tic  % start timer

%adjustable params:
max_multiple = 32;

num_notes = length(InputIndexes);
adj_distances = zeros(1, num_notes);

%Standardize the the indexes to ideally start sufficiently high up
standardization =  length(ET_notes) -InputIndexes(length(InputIndexes)) + offset;
InputIndexes = standardization + InputIndexes;

for i = 1:(num_notes - 1)
    adj_distances(i) = ET_notes(InputIndexes(i+1)-offset) - ET_notes(InputIndexes(i)-offset);
end
adj_distances(num_notes) = ET_notes(InputIndexes(1)-offset);

starting_F = min(adj_distances);

%Search by iterating down the OT series starting from starting_F
Findex = find(ET_notes > starting_F, 1);

while 1
    if Findex == 0
        outputFreqs = ET_notes(InputIndexes-offset);  % if doesn't work should probably just play original freqs
        F = 0;
        break
    end
    F = ET_notes(Findex);
    max_overtones = max_multiple;%min(ET_tolerance_bands(2,num_notes), max_multiple);
    multipleF = F.*(1:max_overtones);
    ovt = 1;
    outputFreqs = zeros(1,num_notes);
    
    for note = 1:num_notes
        index = InputIndexes(note);
        low_bound = ET_tolerance_bands(1,index-offset);
        up_bound = ET_tolerance_bands(2,index-offset);
        while ovt <= max_overtones
           corrected_freq = multipleF(ovt);
           ovt = ovt+1;
           if corrected_freq >= low_bound && corrected_freq <= up_bound
               outputFreqs(note) = corrected_freq * 2^(-standardization/12);
               break;
           end
        end
    end
    if outputFreqs(num_notes) == 0
        outputFreqs = [];
        Findex = Findex - 1;
    else
        break;
    end
    disp(outputFreqs);
end
toc  %end timer


end

