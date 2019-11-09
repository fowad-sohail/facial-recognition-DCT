[trdata_raw,trclass] = face_recog_knn_train([1 40],70);
[topDist, id] = PersonRecog('att_faces/s8/6.pgm', trdata_raw, trclass, 70, 5);
disp(topDist);
disp(id);