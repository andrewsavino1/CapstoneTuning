function index = n(letter,number)
%N converts a note (Ex. B3) into an index
    letterBase = 1;
    switch letter(1)
        case 'A'
            letterBase = 12;
        case 'B'
            letterBase = 14;
        case 'C'
            letterBase = 3;
        case 'D'
            letterBase = 5;
        case 'E'
            letterBase = 7;
        case 'F'
            letterBase = 8;
        case 'G'
            letterBase = 10;
    end
    
    index = 1 + 12*(number-1) + letterBase;
    if length(letter) == 2
        switch letter(2)
            case '#'
                index = index + 1;
            case 'b'
                index = index - 1;
        end
    end
end

