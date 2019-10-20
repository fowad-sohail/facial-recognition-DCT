clear all;
%close all;

vector_dim_9 = findfeatures('att_faces/s17/6.pgm', 9);
vector_dim_35 = findfeatures('att_faces/s17/6.pgm', 35);
vector_dim_100 = findfeatures('att_faces/s17/6.pgm', 100);

figure(1);
plot_person(vector_dim_9, vector_dim_35, vector_dim_100);
sg = sgtitle('Subject 17 Picture 6 DCT Vector');
sg.FontSize = 20;
sg.FontWeight = 'bold';

% ------------------------

vector_dim_9 = findfeatures('att_faces/s18/6.pgm', 9);
vector_dim_35 = findfeatures('att_faces/s18/6.pgm', 35);
vector_dim_100 = findfeatures('att_faces/s18/6.pgm', 100);

figure(2);
plot_person(vector_dim_9, vector_dim_35, vector_dim_100);
sg = sgtitle('Subject 18 Picture 6 DCT Vector');
sg.FontSize = 20;
sg.FontWeight = 'bold';

function plot_person(vector_dim_9, vector_dim_35, vector_dim_100);
    subplot(1, 3, 1)
    plot_features(vector_dim_9);
    title('Feature Vector with Dimension 9');
    subplot(1, 3, 2)
    plot_features(vector_dim_35);
    title('Feature Vector with Dimension 35');
    subplot(1, 3, 3)
    plot_features(vector_dim_100);
    title('Feature Vector with Dimension 100');
end
% Given a dct of an image in the zigzag format (given by findfeaturs())
% Return plot of the feature vector vs its indices
function plot_features(output_features)
    t = 1:1:length(output_features);
    y = output_features.'; % transpose column vector to row vector
    plot(t,y);
    xlabel('Number of features');
    ylabel('DCT Output');
end