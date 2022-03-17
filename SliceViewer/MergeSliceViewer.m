function MergeSliceViewer(Imgs)
    % Imgs is a cell that contain multiple image (all the image should be
    % have the same size in the first 3 dimension)
    % support non-nomalized Image (we will perform min-max nomalization
    % here)
    % Example:
    %    Img18, Lab20 (from MSD, has size 240 240 155 4(1))
    %              >> slice_viewer_combine({Img18, Lab20})
    %    Img20_1, ..., Img20_4, Lab20 (from BraTS20, has size 240 240 155)
    %              >> slice_viewer_combine({Img20_1, ..., Img20_4, Lab20})
    
    % N element in Imgs
    N_elt    = numel(Imgs);
    [NX, NY, NZ, ~] = size(Imgs{1}); % get the size
    
    % There may be many views ina image, so N_img may be greater than N_elt
    N_img    = 0;
    
    % check input and calculate how many images there
    for k = 1 : N_elt
        Img4D = Imgs{k};
        [nx,ny,nz,nd] = size(Img4D);
        N_img = N_img + nd;
        if (nx ~= NX) || (ny ~= NY) || (nz ~= NZ)
            error('image size incompatiable');
        end
    end
    
    % How many images in a row, a col etc.
    if N_elt < 4
        Col = N_elt;
    else
        Col = 4;
    end
    Row   = floor(N_img / Col) + (mod(N_img, Col)>0);
    Merge = zeros((5+NX)*Row-5, (5+NY)*Col-5, NZ);
    
    % Fill in the white edge
    for ii = 1 : Row-1
        Begin = ii * NX + (ii-1) * 5 + 1;
        End   = Begin + 5 - 1;
        Merge(Begin:End,:,:) = 1;
    end
    for jj = 1 : Col-1
        Begin = jj * NY + (jj-1) * 5 + 1;
        End   = Begin + 5 - 1;
        Merge(:,Begin:End,:) = 1;
    end
    
    ii = 1; jj = 1;
    for k = 1 : N_elt
        Img4D = Imgs{k};
        [~,~,~,nd] = size(Img4D);
        for l = 1 : nd
            Img3D = double(Img4D(:,:,:,l));
            m     = min(Img3D(:));
            M     = max(Img3D(:));
            Img3D = (Img3D - m) / (M - m);
            
            xbegin = (ii-1) * (NX+5) + 1;
            ybegin = (jj-1) * (NY+5) + 1;
            xpos = xbegin : xbegin + NX - 1;
            ypos = ybegin : ybegin + NY - 1;
            Merge(xpos,ypos,:) = Img3D;
            
            jj = jj + 1;
            if (jj == Col + 1)
                jj = 1;
                ii = ii + 1;
            end
        end
    end
    sliceViewer(Merge);
end