function small_figplot(xunit, yunit)

axisFSZ = 22;
labelSZ = 36;
lenSZ = 700;

set(groot,'defaultLineLineWidth',1.5)

figure;
ax = gca;
ax.XAxis.FontSize = axisFSZ;
ax.YAxis.FontSize = axisFSZ;
xlabel(xunit, 'interpreter', 'latex', 'FontSize', labelSZ);
ylabel(yunit, 'interpreter', 'latex', 'FontSize', labelSZ);
pbaspect([1 1 1]);
set(gcf, 'Position',  [0, 0, lenSZ, lenSZ])

end

