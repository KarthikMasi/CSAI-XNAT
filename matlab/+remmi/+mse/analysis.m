function t2set = analysis(dset,varargin)
% t2set = remmi.mse.analysis(dset,metrics,fitting,mera_analysis,name) 
% performs generalized relaxometry analysis with MERA on data in dset:
%
%       dset.(name) = data to process
%       dset.mask = mask for processing data
%       dset.pars = basic remmi parameter set including te
%       dset.labels = cell array of labels to dset.img dimensions
%
%       metrics = a optional structure of function handles that operate on 
%       the output structure of MERA. 
%
%       fitting & mera_analysis = passed directly to MERA for multi- 
%       exponential T2/EPG analysis
%
%       name = name of field in dset to fit. Default is 'img'
%
%   If not provided, default values for metrics, fitting, mera_analysis,
%   and name are taken from remmi.mse.mT2options
% 
%   Returns a dataset which contains parameter maps defined in the metrics
%   structure
%
% Kevin Harkins & Mark Does, Vanderbilt University
% for the REMMI Toolbox

% by default, use epg options
[metrics,fitting,manalysis,name] = remmi.mse.mT2options(varargin{:});

if ~exist('dset','var')
    dset = struct();
end

if ~isfield(dset,name) || isempty(dset.(name))
    dset = remmi.util.thresholdmask(remmi.recon(dset));
end

sz = size(dset.(name)); 
if length(sz) < length(dset.labels)
    sz(length(dset.labels)) = 1;
end
seg_sz = 20000; % number of multi-echo measurements to process at one time

% what dimension is multiple echoes?
echoDim = ismember(dset.labels,'NE');

if ~any(echoDim)
    error('Data set does not contain multiple echo times');
end

% get the echo times
in.t = dset.pars.te; % sec

% define a mask if one is not given
if isfield(dset,'mask')
    mask = squeeze(dset.mask);
    
    % apply the mask across all non-echo dimensions
    msz = sz(~echoDim);
    if numel(msz)==1
        msz(2) = 1;
    end
    mask = bsxfun(@times,mask,ones(msz));
else
    msz = sz(~echoDim);
    if numel(msz)==1
        msz(2) = 1;
    end
    mask = squeeze(true(prod(msz,1)));
end

names = fieldnames(metrics);
maps = cell([length(names) sz(~echoDim)]);

% put the NE dim first
idx = 1:numel(size(dset.(name)));
if numel(idx) < length(dset.labels)
    idx(length(dset.labels)) = length(dset.labels);
end
data = permute(dset.(name),[idx(echoDim) idx(~echoDim)]);

% linear index to all the vectors to process
mask_idx = find(mask);

% take the absolute value of complex data
makereal = str2func('@(x) abs(x)');
if isreal(data)
    % if the data is already real, allow negative values to remain negative
    makereal = str2func('@(x) x');
end

% split the calls to MERA into segments of size seg_sz
nseg = ceil(numel(mask_idx)/seg_sz);
metlen = zeros(size(names));
for seg=1:nseg
    fprintf('Processing segment %d of %d.\n',seg,nseg);
    
    % segment the mask
    segmask = (seg_sz*(seg-1)+1):min(seg_sz*seg,numel(mask_idx));
    
    in.D = makereal(data(:,mask_idx(segmask)));

    % process the data in MERA
    [out,fout] = remmi.mse.MERA.MERA(in,fitting,manalysis);

    % compute all of the metrics required
    for m=1:length(names)
        % calculate the metric
        met = metrics.(names{m})(out);
        metlen(m) = max(size(met,1),metlen(m));  % save the size for later
        
        % store the maps for later
        maps(m,mask_idx(segmask)) = num2cell(met,1);
    end
end

% set the maps into the dataset, keeping proper dimensions
t2set = struct();
for m=1:length(names)
    
    len = unique(cellfun(@length,maps(m,:)));
    
    if numel(len) > 2 
        % the vectors in maps vary in length. The import is a bit involved
        maxlen = max(len);
        for n = 1:numel(maps(m,:))
            if length(maps{m,n}) ~= maxlen
                maps{m,n}(maxlen,1) = 0;
            end
        end
        
        val = cell2mat(maps(m,:));
        val = reshape(val,[metlen(m) sz(~echoDim)]);
    else
        % all the vectors in maps are the same length. Simple import
        
        % index to empty cells
        ix=cellfun(@isempty, maps(m,:));

        % create matrix to hold the metric
        val = zeros([metlen(m) sz(~echoDim)]);
        val(:,~ix) = cell2mat(maps(m,:));
    end
    
    nd = ndims(val);
    
    % rearrange
    if nd>1
        val = permute(val,[2:nd 1]);
    end
    
    % place into the return structure
    t2set.(names{m}) = val;
end

t2set.fitting = fout;
t2set.metrics = metrics;
t2set.labels = dset.labels(~echoDim);

end
