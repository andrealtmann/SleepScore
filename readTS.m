function [ ts ] = readTS( fname )
%READTS: reads a time series file
%   fname points to a text file
%       it should contain 90 columns (cortical ROIs from AAL)
%       it should contain rows equal to volumes
    ts=dlmread(fname);
    
    %optional: add checks

end

