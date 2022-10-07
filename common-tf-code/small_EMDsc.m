function small_EMDsc(A1, A2, A3)

axisFSZ = 22;
labelSZ = 36;
lenSZ = 700;

if nargin == 1
    EMD = A1;
    XV = 1:size(EMD, 2);
    YV = 1:size(EMD, 1);
else
    XV = A1;
    YV = A2;
    EMD = A3;
end

TFRsc(XV, YV, EMD, "time", "component index", 0, axisFSZ, labelSZ, lenSZ)
end

