function [ cor_mat ] = ts2cor( time_series )
%TS2COR takes a time series of N ROIs and produces
%   the NxN correlation matrix
    
    %compute correlation
    cmat = corrcoef(time_series);
    %do fisher z transform
    cor_mat = .5.*log((1+cmat)./(1-cmat));
    
end

