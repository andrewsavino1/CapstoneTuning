function [outputArg1,outputArg2] = plotWaves(beforeFreqs, afterFreqs, fig)
%PLOTWAVES Summary of this function goes here
%   Detailed explanation goes here
clf(fig)

outer_lim = 10/afterFreqs(1);
x = linspace(0,outer_lim);
%assert size(beforeFreqs) == size(afterFreqs)

%% 'before' graph
subplot(1,2,1);
hold on

y = sin(beforeFreqs' .* x);
xlim([0,outer_lim])
plot(x,y)
plot(x, sum(y), 'LineWidth',4)
legendCell = cellstr(num2str(beforeFreqs', '%-d'));
legend(legendCell)

title('Algorithm input')



%% 'after' graph
subplot(1,2,2);
hold on
y = sin(afterFreqs' .* x);
plot(x,y)
plot(x, sum(y), 'LineWidth',4)
legendCell = cellstr(num2str(afterFreqs', '%-d'));
legend(legendCell)
xlim([0,outer_lim])

legendCell = cellstr(num2str(afterFreqs', '%-d'));
legend(legendCell)
title('Algorithm output')

hold off

end

