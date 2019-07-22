function out=splitn(img,n,varargin)
% Splits 3D image containing multiple samples into individual datasets
% each containing one sample. Assumes samples are 1) much larger in size
% than background artifacts and similar in size to each other, 
% 2) oriented in a rectangular grid-like fashion 
% (i.e. rows and columns of samples), 3) oriented the
% same way as atlas (http://brainatlas.mbi.ufl.edu/).
%
% Input
%   img=3D image data to split
%   n=number of samples contained in data
%   coords=input coordinates for splitting
%
% Output
%   out=structure containg the following:
%       segimg=nx1 cell, each cell containing dataset for one individual sample
%       coords=coordinates for splitting subsequent datasets
%
% Note: Output images are organized from top left sample to bottom right
%       moving from left to right, then top to bottom

switch nargin
    case 2
        % Create binary mask (Note: Threshold may need adjustment if segmentation
        % is not good)
        mask=abs(img)>0.2*max(abs(img(:)));
        
        % Detect connected bodies in mask
        cc=bwconncomp(mask,18);
        
        % Determine number of voxels in each connected body
        numVoxels = cellfun(@numel,cc.PixelIdxList);
        
        % Sort number of voxels from largest to smallest
        [~,idx]=sort(numVoxels,'descend');
        
        % Relevant linear indices (n largest connected bodies)
        relidx=idx(1:n);
        
        % Create cell array containing the linear indices from n largest bodies
        idxlin=cell(n,1);
        for ii=1:n
            idxlin{ii}=cc.PixelIdxList{relidx(ii)};
        end
        
        % Convert linear indices to subscript indices
        [sx,sy,sz]=size(mask);
        idxsub=cell(n,1);
        for ii=1:n
            cidx=zeros(length(idxlin{ii}),3);
            for jj=1:length(idxlin{ii})
                [i,j,k]=ind2sub([sx,sy,sz],idxlin{ii}(jj));
                cidx(jj,1)=i;
                cidx(jj,2)=j;
                cidx(jj,3)=k;
            end
            idxsub{ii}=cidx;
        end
        
        % Segment n datasets based on indices of connected bodies
        segimg=cell(n,1);
        coords=zeros(n,4); % [minx maxx miny maxy]
        
        for ii=1:n
            minx=min(idxsub{ii}(:,1));
            maxx=max(idxsub{ii}(:,1));
            miny=min(idxsub{ii}(:,2));
            maxy=max(idxsub{ii}(:,2));
            
            % Create a set of coordinates to segment data with
            coords(ii,1)=minx-1;
            if coords(ii,1)<1
                coords(ii,1)=1;
            end
            coords(ii,2)=maxx+1;
            if coords(ii,2)>size(mask,1)
                coords(ii,2)=size(mask,1);
            end
            coords(ii,3)=miny-1;
            if coords(ii,3)<1
                coords(ii,3)=1;
            end
            coords(ii,4)=maxy+1;
            if coords(ii,4)>size(mask,2)
                coords(ii,4)=size(mask,2);
            end
            segimg{ii}=img(coords(ii,1):coords(ii,2),coords(ii,3):coords(ii,4),:);
            rh(ii)=coords(ii,2)-coords(ii,1); % Row height
            maxh(ii)=coords(ii,2);            % Max height
        end
        rhm=mean(rh); % Use mean row height as criteria for sorting
        % Arrange segmented images from top left to bottom right (going from
        % left to right, then top to bottom)
        
        % Determine centroid of object
        S=regionprops(cc,'Centroid');
        cen=zeros(n,4);
        for ii=1:n
            cen(ii,1:3)=S(relidx(ii)).Centroid;
            cen(ii,4)=ii;
            cen(ii,5)=maxh(ii);
        end
        % Sort centroid coordinates into rows determined by row height
        % then sort from left to right
        ctr=n;
        minh=0;
        censort=[];
        while ctr>0
            minh=minh+1;
            % If centroid lies within sliding window (minh<x<minh+rhm)
            % Sort centroids within that window left to right, then place
            % in censort (sorted centroid matrix)
            tmp=cen(cen(:,2)>minh & cen(:,2)<=minh+rhm,:);
            if size(tmp,1)>0
                tmp=sortrows(tmp,1);
                ctr=ctr-size(tmp,1);
                censort=[censort;tmp];
                % Move sliding window to next row
                minh=max(tmp(:,5));
            end
        end
        % Order in which to arrange segmented images
        perm=censort(:,4);
        
        out.segimg=segimg(perm);
        out.coords=coords(perm,:);

    case 3
        coords=varargin{1};
        
        % Segment n datasets based on indices of connected bodies
        segimg=cell(n,1);
        for ii=1:n
            segimg{ii}=img(coords(ii,1):coords(ii,2),coords(ii,3):coords(ii,4),:);
        end
        out.segimg=segimg;
        out.coords=coords;
        
    otherwise
        error('Unexpected inputs');
end
