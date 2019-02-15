function [] = playNotes(frequencies, duration, amp)
%PLAYNOTES Summary of this function goes here
%   Detailed explanation goes here

    %temporary fix: for some reason, the first note starts earlier than the
    %others, so fixing this by adding a leading 0
    frequencies = [0, frequencies];

    sampling_frequency = 8192;
    values = 0:(1/sampling_frequency):duration;
    test = 2*pi*frequencies'*values;
    a = amp*sin(test);
    for i=1:size(a,1)
        sound(a(i,:));
    end
end

