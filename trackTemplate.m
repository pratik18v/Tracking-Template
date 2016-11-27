function trackTemplate(path_to_car_sequence, sigma, template)
%trackTemplate: Tracks a given template through a sequence of frames given the
%location of the template in the first frame. This code assumes that the
%motion of the object is purely translational.
    dirname='output';
    mkdir(dirname);
    warning('off','MATLAB:colon:nonIntegerIndex');
    fid=fopen(strcat(dirname,'/coordinates.txt'),'w');
    MAX_ITER = 10000;
    im1 = imread(strcat(path_to_car_sequence,'frame00303.jpg'));
    T = imread(template);
    [mT, nT,~] = size(T);
    
    %Finding original location of template in image
    corr = normxcorr2(T(:,:,1),im1(:,:,1));

    [~, maxInd] = max(abs(corr(:)));
    [ymax, xmax] = ind2sub(size(corr),maxInd(1));
    %W_coords = [xmax, ymax];
    W_coords = [(xmax-size(T,2)) (ymax-size(T,1))];
    W_width = nT;
    W_height = mT;


    %Calculating M matrix from Tx and Ty
    [Tx,Ty] = imgradientxy(T(:,:,1));
    Minv = [Tx(:),Ty(:)]'*[Tx(:),Ty(:)];
    S = -Minv\[Tx(:),Ty(:)]';

    %Iterating over all images in the sequence
    for i=308:403,
        imname = strcat(path_to_car_sequence,'frame00',int2str(i),'.jpg');
        disp(imname);
        im = imread(imname);
        d = 100000;
        iter = 0;
        %Iterating for large motions
        while d>150,
            iter = iter+1;
            if iter>MAX_ITER,
                break;
            end
            imT = im(W_coords(2):W_coords(2)+W_height,W_coords(1):W_coords(1)+W_width,:);
            imT = imresize(imT,[mT,nT]);
            %[imTx,imTy] = imgradientxy(imT(:,:,1));
            %A = [imTx(:),imTy(:)]'*[imTx(:),imTy(:)];
            %imshow(imT);

            diff = imT-T;
            d = abs(sum(sum(sum((diff-T).^2).^0.5)));
            %disp(d);
            diff = rgb2gray(diff);
            u = S(1,:)*double(diff(:));
            v = S(2,:)*double(diff(:));
            translate = [1,0,u;0,1,v;0,0,1];
            W = translate*[W_coords(1);W_coords(2);1];          
            W_coords = [W(1),W(2)];
            disp(W_coords);
        end
        fig=figure('visible','off');
        imshow(im);
        hold on;
        rectangle('position',[W_coords(1) W_coords(2) W_width W_height],...
                  'edgecolor','g','linewidth',2);
        print(fig,strcat(dirname,'/frame00',int2str(i)),'-djpeg');
        formatSpec = '%d %0.2f %0.2f %0.2f %0.2f %0.2f %0.2f %0.2f %0.2f\n';
        fprintf(fid,formatSpec,i,W_coords(1),W_coords(2), ...
            W_coords(1)+W_width,W_coords(2), ...
            W_coords(1),W_coords(2)+W_height,...
            W_coords(1)+W_width,W_coords(2)+W_height);
    end
end

