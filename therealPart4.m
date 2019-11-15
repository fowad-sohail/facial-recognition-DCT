clear all;
close all;

ISR = 0;

kList = 1:2:7;
dList = 25:15:100;

%ISRvector = zeros(length(kVals), length(dctVals));


dctNum = length(dList);
kNum = length(kList);

performance = zeros(dctNum, kNum);

for dindex =1:dctNum
    dctlength = dList(dindex);
    [trdata_raw,trclass] = face_recog_knn_train([1 40],dctlength);
    for kindex =1:kNum
        k = kList(kindex);
        ISR = part_4(dctlength, k, trdata_raw, trclass);
        performance(dindex, kindex) = ISR*100;
    end
end

dList = dList';
dTotal = repmat(dList, 1, kNum);
kTotal = repmat(kList, dctNum, 1);
surf(dTotal, kTotal, performance);
xlabel("DCT Value");
ylabel("K Value");
zlabel("ISR");
ylim([1 7]);
xlim([25 100]);
xticks(25:15:100);
yticks(1:2:7);
zlim([75 95]);
zticks(75:5:95);
title("Success Rate");
