numSub = 40;
dctlength = 70;
k = 5;
for i=1:numSub
    for j=6:10
        
    % Assign the vector f_range to the range of subject specified by
    % subject_range
    f_range=1:40;

    % Check if subject_range(1) = f_range(1) = 1
    if (f_range(1) ~= 1)
      error('The first subject must have a label of 1');
    end

    % Assign the number of subjects to the length of f_range
    nsubjects = length(f_range);
	% ************************* UPDATE THIS DEPENDING ON YOUR FILE SYSTEM ************************* 
        filename = ['C:\Users\TimRo\Documents\Github\facial-recognition-DCT\att_faces\s'...
            num2str(f_range(i)) '\' num2str(j) '.pgm'];
        [topDist, person_id] = PersonRecog(filename, trdata_raw, trclass, dctlength, k);
        
        person_unique = unique(person_id);
        total_unique = length(person_unique);
        person_count = zeros(length(person_unique), 1);
        for p=1:k
            person = person_id(p);
            for q=1:total_unique
                if(person == person_unique(q))
                    person_count(q) = person_count(q) + 1;
                end
            end
        end
        tie = find(person_count==max(person_count));
        tie_mins = zeros(numel(tie), 1);
        winner = 0;
        if(numel(tie) > 1)
            for r=1:numel(tie)
                person = person_unique(tie(r));
                instances = find(person_id == person);
                minDistance = topDist(instances(1));
                if(numel(instances) > 1)     
                    for inst=2:numel(instances)
                        testDist = topDist(instances(inst));
                        if(testDist < minDistance)
                            minDistance = testDist;
                        end
                    end
                end 
                tie_mins(r) = minDistance;
            end
            min_index = find(tie_mins==min(tie_mins));
            winner = person_unique(tie(min_index));
        else
            winner = person_unique(tie(1));
        end
        disp("TOP DIST");
        disp(topDist);
        disp("PERSON ID");
        disp(person_id);
        disp("SELECTED WINNER");
        disp(winner);
        disp("Test");
    end
end