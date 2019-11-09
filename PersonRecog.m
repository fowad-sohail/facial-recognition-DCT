function [topDist, person_id] = PersonRecog(filename, trdata_raw, trclass, dctlength, k)
    subject = findfeatures(filename,dctlength); %Get DCT of test image
    result = zeros(200, 1);
    for i=1:200
        dct = trdata_raw(i,:);
        distance = 0;
        for dem=1:dctlength 
            distance = distance + (dct(dem) - subject(dem))^2;
        end 
        distance = sqrt(distance);
        result(i) = distance;
    end
    
    %Finding Winners
    topDist = result(1:k);
    person_id = zeros(k, 1);
    for p=1:k
        person_id(p) = trclass(p);
    end
    
    for i=1:200
        highestValue = topDist(1);
        highestIndex = 1;
        for w=2:k
            if(topDist(w) > highestValue)
                highestValue = topDist(w);
                highestIndex = w;
            end
        end
        if(result(i) < highestValue)
            topDist(highestIndex) = result(i);
            person_id(highestIndex) = trclass(i);
        end
    end    
end