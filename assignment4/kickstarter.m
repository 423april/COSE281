clear all


% define funded and nonfunded as row vectors
funded = [373 3772 10746 16903 19271 22233 22036 18823];
nonfunded = [501 4825 12516 22749 24823 44325 54831 39251];

scatter([0 : 7]', nonfunded','displayname','Data'); grid on; xlim([0 10]), ylim([-5000 70000])
hold on

for i = 1 : 7
    A = [0 : 7]' .^ [0 : i];
    coeff = A \ nonfunded';
    y = [0 : 0.05 : 10]' .^ [0 : i] * coeff;
    
    err(i) = norm(A * coeff - nonfunded');
    plot([0 : 0.05 : 10], y, 'linewidth', 2, 'displayname', sprintf('Degree %d', i, err(i)))

end
legend('location', 'southeast');

hold off
scatter([0 : 7]', funded','displayname','Data'); grid on; xlim([0 10]), ylim([-5000 70000])
hold on

for i = 1 : 7
    
    A = [0 : 7]' .^ [0 : i];
    coeff = A \ funded';
    y = [0 : 0.05 : 10]' .^ [0 : i] * coeff;
    
    err(i) = norm(A * coeff - funded');
    plot([0 : 0.05 : 10], y, 'linewidth', 2, 'displayname', sprintf('Degree %d, Error %f', i, err(i)))

end
legend('location', 'southeast');clear all


% define funded and nonfunded as row vectors
funded = [373 3772 10746 16903 19271 22233 22036 18823];
nonfunded = [501 4825 12516 22749 24823 44325 54831 39251];

scatter([0 : 7]', nonfunded','displayname','Data'); grid on; xlim([0 10]), ylim([-5000 70000])
hold on

for i = 1 : 7
    A = [0 : 7]' .^ [0 : i];
    coeff = A \ nonfunded';
    y = [0 : 0.05 : 10]' .^ [0 : i] * coeff;
    
    err(i) = norm(A * coeff - nonfunded');
    plot([0 : 0.05 : 10], y, 'linewidth', 2, 'displayname', sprintf('Degree %d', i, err(i)))

end
legend('location', 'southeast');

hold off
scatter([0 : 7]', funded','displayname','Data'); grid on; xlim([0 10]), ylim([-5000 70000])
hold on

for i = 1 : 7
    
    A = [0 : 7]' .^ [0 : i];
    coeff = A \ funded';
    y = [0 : 0.05 : 10]' .^ [0 : i] * coeff;
    
    err(i) = norm(A * coeff - funded');
    plot([0 : 0.05 : 10], y, 'linewidth', 2, 'displayname', sprintf('Degree %d, Error %f', i, err(i)))

end
legend('location', 'southeast');