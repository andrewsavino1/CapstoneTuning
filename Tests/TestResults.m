inputChords2 = [22 23;
               22 24;
               22 25;
               22 26;
               22 27;
               22 28;
               22 29;
               22 30;
               22 31;
               22 32;
               22 33;
               22 34];
           
inputChords3 =[22 26 29; % major triad
               22 25 29;  % minor triad
               22 24 26;
               22 24 27;
               22 24 29;
               22 26 31;
               23 26 31; % first inversion triad (6)
               22 27 31]; % second inversion triad (6/4)
              
inputChords4 =[22 26 29 32; % dom 7
               22 26 29 33]; % major 7
           
           
notes = 44:44+19;
lowIndex = -30;
numNotes = 5;
numTrials =1000;
[ET_notes, ET_tolerance_bands] = generateETNotes(lowIndex,88);
times = zeros(2,numTrials);
outputs = zeros(numTrials,numNotes);
funds = zeros(1,numTrials);
% improvements = zeros(1,numTrials);
for i = 1:numTrials
   chord = sort(datasample(notes, numNotes,'Replace', false));
   
   tic
   [o,F, ii] = Algorithm1(chord, ET_notes, ET_tolerance_bands, lowIndex-1);
   times(1,i) = toc;
   [o2,F2,improvement] = Algorithm2(o, F, ii, ET_notes, ET_tolerance_bands);
   times(2,i) = toc;
   outputs(i,:) = o;
   funds(i) = F;
   %improvements(i) = improvement;
   tot_improv(numNotes-1,i) = improvement;
    
end
histogram(times(1,:))
xlabel('Time (seconds)')
ylabel('Frequency')
title('Runtime of 5-note Chords')
convergence_Rate = 1 -( nnz(~funds))/1000
               
               
               