function M = calcM(im1, im2)

    MAX_ITERS = 100;

    %Normalizing image
    im1 = double(im1)/255;
    im2 = double(im2)/255;

    [m,n] = size(im1);
    p = zeros(6,1);
    [x,y] = meshgrid(1:n,1:m);
    %x = x/320;
    %y = y/240;

    [im1x, im1y] = gradient(im1,1/n,1/m);
    It = im2 - im1;
    
    %Calculating A matrix
    A = [x(:).*im1x(:), ...
         y(:).*im1x(:), ...
         im1x(:),       ...
         x(:).*im1y(:), ...
         y(:).*im1y(:), ...
         im1y(:)];
     
    for i=1:MAX_ITERS

        %Calculating p and dp
        dp = -(A'*A)\A'*It(:);
        p = p + dp;
        %disp(norm(dp));

        %Calculating transformation matrix M
        M = [1+p(1),   p(2), p(3); ...
               p(4), 1+p(5), p(6); ...
                  0,      0,   1];

        M = inv(M);
        % Transformating im2 using inverse of M matrix as im2 = M*im1
        [im2t, A] = warp(im2,im1, M);

        %Calculating I(t+1) - I(t)
        It = im2t - im1;
        %disp(norm(It));

        %Break conditions: 1) degree of change of p; 2) similarity
        %between I(t) and I(t+1)
        
        if norm(dp)<0.0001
            break;
        end
        if norm(It)<5,
            break;
        end
        
    end
    %disp(norm(It));
end