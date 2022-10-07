function TFRsc(A1, A2, A3, xunit, yunit, flipCB, axisFSZ, labelSZ, lenSZ)

if nargin == 1
    TFR = A1;
    XV = 1:size(TFR, 2);
    YV = 1:size(TFR, 1);
    xunit = "";
    yunit = "";
else
    XV = A1;
    YV = A2;
    TFR = A3;
    if nargin <= 3
        xunit = "time";
        yunit = "frequency";
    end
end

if nargin <= 3
    flipCB = 1;
    axisFSZ = 18;
    labelSZ = 18;
    lenSZ = 500;
end

figure;
imagesc(XV, YV, TFR);
axis xy;
if flipCB
    colormap(flipud(gray));
else
    colormap(gray);
end
ax = gca;
ax.XAxis.FontSize = axisFSZ;
ax.YAxis.FontSize = axisFSZ;
xlabel(xunit, 'interpreter', 'latex', 'FontSize', labelSZ);
ylabel(yunit, 'interpreter', 'latex', 'FontSize', labelSZ);
pbaspect([1 1 1]);
set(gcf, 'Position',  [0, 0, lenSZ, lenSZ])
end

