function [result] = findfeatures(filename,dctlength)
%--------------------------------------------------------------------
%
% function [result] = findfeatures(filename,dctlength)
% filename: example 's1.pgm'
% dctlength: length of desired dct
% example: [result]=findfeatures('s1.pgm',35); 
%
%--------------------------------------------------------------------
% Read image
[ingresso]=imread(filename);
Lout = dctlength;

% Do zig-zag scanning
[dimx,dimy] = size(ingresso); % x, y dimensions of the given picture
% product of dimensions is the number of elements
% in the matrix and the number of pixels in the picture
dimprod     = dimx*dimy;
% create an array of zeros of the same dimensions
% as the input picture
zigzag = zeros(dimx,dimy);
% initialize indices for zigzag
ii = 1;
jj = 1;

zigzag(ii,jj) = 1;
slittox = 0; % determines if direction of movement is x
slittoy = 1; % determines if direction of movement is y
last    = 0; % variable for edgecase detection

% indexing variable
%starts at 2 because (1,1) is already defined
cont    = 2;

while cont<dimprod
    % if direction of movement is x
    % AND if there is space to move (haven't hit the edge)
    if slittox == 1 && (ii+1)<=dimx
        % conditional handles movement in the x direction
        ii = ii+1; % increment x index
        jj = jj; % remain constant in the y direction
        zigzag(ii,jj)=cont; % current index = cont
        cont = cont+1; % increment cont (index)
        slittox = 0; % turn off movement in x direction
        last    = 1;
        continue; % return to top of loop
    end
    
    % if direction of movement is x, but the cursor is at the right edge
    % AND if there is space to move downwards
    if slittox == 1 && (ii+1)>dimx && (jj+1<=dimy)
        % handles movement if cursor is at the right edge
        ii = ii; % hold x
        jj = jj+1; % increment y
        zigzag(ii,jj)=cont; % current index = cont
        cont = cont+1; % increment cont (index)
        slittox = 0; % turn off movement in x direction
        last    = 1; 
        continue; % return to top of loop
    end

    % if direction of movement is y
    % AND if there is space to move (haven't hit the edge)
    if slittoy == 1 && (jj+1)<=dimy
        % handles movmeent in y
        ii = ii; % hold x
        jj = jj+1; % increment y
        zigzag(ii,jj)=cont; % current index = cont
        cont = cont+1; % increment cont index
        slittoy = 0; % turn off movement in y direction
        last    = 0;
        continue; % return to top of loop
    end
    
    % if direction of movement is y, but the cursor is at the right edge
    % AND if there is space to move downwards
    if slittoy == 1 && (jj+1)>dimy && (ii+1<=dimx)
        % handles movement on bottom edge of picture
        ii = ii+1; % increment x
        jj = jj; % hold y
        zigzag(ii,jj)=cont; % current index = cont
        cont = cont+1; % increment cont index
        slittoy = 0; % turn off movement in y direction
        last    = 0;
        continue; % return to top of loop
    end

    % if direction of movement is neither x nor y
    % AND cursor needs to change direction
    if (slittox == 0 && slittoy == 0) && last == 1
        % handles moving diagonally downward
        if ii-1>=1 && jj+1<=dimy % left and bottom edge detection
            ii=ii-1; % move left in the x
            jj=jj+1; % move down in the y
            zigzag(ii,jj)=cont; % current index = cont
            cont = cont+1; % increment cont
            continue; % return to top of loop
        else
            slittox = 0; % don't move in the x direction
            slittoy = 1; % move in the y direction
            continue;
        end
    end

    % if direction of movement is neither x nor y
    % AND cursor needs to change direction
    if (slittox == 0 && slittoy == 0) && last == 0
        % handles moving diagonally upward
        if ii+1<=dimx && jj-1>=1 % right and top edge detection
            ii=ii+1; % move right x
            jj=jj-1; % move up in y
            zigzag(ii,jj)=cont; % current index = cont
            cont = cont+1; % increment cont
            continue; % return to top of loop
        else
            slittox = 1; % move in the x direction
            slittoy = 0; % don't move in the y direction
            continue;
        end
    end
end
zigzag(dimx,dimy)=dimprod; % last index = number of elements
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
t                = dct2(ingresso); % dct of input image
vettore_t        = t(:); % convert image to column vector
vettore_t_zigzag = zeros(size(vettore_t)); % zero vector of size(vettore_t)
vettore_zigzag   = zigzag(:); % convert zigzag to column vector
for ii=1:length(vettore_t)
    % rearrange picture vector in zigzag format instead of horizontal
    % format
    vettore_t_zigzag(vettore_zigzag(ii)) = vettore_t(ii);
end
% truncate output according to the parameter dctlength
result = vettore_t_zigzag(2:Lout+1);
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
