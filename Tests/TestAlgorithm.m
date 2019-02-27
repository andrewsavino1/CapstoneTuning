function tests = TestAlgorithm
%TESTFUNCTION Summary of this function goes here
%   Detailed explanation goes here
tests = functiontests(localfunctions);
end



%% Test Functions
function testMajorChord(testCase)
    algorithm = @Algorithm1;
    basenote = n('A', 4);
    majorChord = [basenote, basenote+4, basenote+7];
    low_index = 1;
    high_index = 88;
    [ET_notes, ET_tolerance_bands] = generateETNotes(low_index,high_index);
    outputFreqs = algorithm(majorChord, ET_notes, ET_tolerance_bands, 0);
    
    verifyEqual(testCase, outputFreqs(2)/5, outputFreqs(1)/4,...
        'Third of major chord is incorrect')
    verifyEqual(testCase, outputFreqs(3)/6, outputFreqs(1)/4,...
        'Fifth of major chord is incorrect')
end 

function testMinorChord(testCase)
    algorithm = @Algorithm1;
	basenote = n('C', 4);
    majorChord = [basenote, basenote+3, basenote+7];
    low_index = 1;
    high_index = 88;

    [ET_notes, ET_tolerance_bands] = generateETNotes(low_index,high_index);
    outputFreqs = algorithm(majorChord, ET_notes, ET_tolerance_bands, 0);
    
    verifyEqual(testCase, outputFreqs(2)/6, outputFreqs(1)/5,...
        'Third of major chord is incorrect')
    verifyEqual(testCase, outputFreqs(3)/6, outputFreqs(1)/4,...
        'Fifth of major chord is incorrect')
end


function testNoteDoesntMoveTooFar(testCase)
    algorithm = @Algorithm1;
	basenote = n('C', 4);
    low_index_1 = 1;
    low_index_2 = 7;
    high_index = 88;
    [ET_notes1, ET_tolerance_bands1] = generateETNotes(low_index_1,high_index);
    [ET_notes2, ET_tolerance_bands2] = generateETNotes(low_index_2,high_index);
    outputFreqs1 = algorithm(basenote, ET_notes1, ET_tolerance_bands1, 0);
    outputFreqs2 = algorithm(basenote, ET_notes2, ET_tolerance_bands2, 6);
    
    verifyEqual(testCase, outputFreqs1, outputFreqs2,...
        'When changing the starting point of the scale, the chord changed transposition')
end



%% Setup and teardown
function setupOnce(testCase)  % do not change function name
    algorithm = @Algorithm1;
    ETNotes = generateETNotes(1,88);
end

function teardownOnce(testCase)  % do not change function name
% change back to original path, for example
end