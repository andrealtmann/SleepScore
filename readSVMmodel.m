function [ svm_model ] = readSVMmodel( fname )
%READSVMMODEL Summary of this function goes here
%   Detailed explanation goes here
    svm_model = csvread(fname, 1,1);

end

