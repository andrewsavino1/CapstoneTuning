function tests = TestAlgorithm
%TESTFUNCTION Summary of this function goes here
%   Detailed explanation goes here
tests = functiontests(localfunctions);
end

% test


%% Test Functions
function testMajorChord(testCase)
    algorithm = @Algorithm1;
    basenote = n('A', 4);
    majorChord = [basenote, basenote+4, basenote+7]
    outputFreqs = algorithm(majorChord);
    
    verifyEqual(testCase, outputFreqs(2)/5, outputFreqs(1)/4,...
        'Third of major chord is incorrect')
    verifyEqual(testCase, outputFreqs(3)/6, outputFreqs(1)/4,...
        'Fifth of major chord is incorrect')
end 

function testMinorChord(testCase)
    algorithm = @Algorithm1;
	basenote = n('C', 4);
    majorChord = [basenote, basenote+3, basenote+7];
    outputFreqs = algorithm(majorChord);
    
    verifyEqual(testCase, outputFreqs(2)/6, outputFreqs(1)/5,...
        'Third of major chord is incorrect')
    verifyEqual(testCase, outputFreqs(3)/6, outputFreqs(1)/4,...
        'Fifth of major chord is incorrect')
end



%% Setup and teardown
function setupOnce(testCase)  % do not change function name
    algorithm = @Algorithm1;
    ETNotes = generateETNotes(1,88);
end

function teardownOnce(testCase)  % do not change function name
% change back to original path, for example
end