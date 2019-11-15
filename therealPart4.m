clear all;
close all;

ISR = 0;

kList = 1:2:7;
dList = 25:15:100;

ISRvector = zeros(length(kVals), length(dctVals));

performance = zeros(kVals, dctVals);

dctNum = length(dList);
kNum = length(kList);

for dindex =1:dctNum
    dctlength = dList(dindex);
    [trdata_raw,trclass] = face_recog_knn_train([1 40],dctlength);
    for kindex =1:kNum
        k = kList(kindex);
        ISR = part_4(dctlength, k, trdata_raw, trclass);
        performance(kindex, dindex) = ISR;
        
    end
end

stem3(performance);