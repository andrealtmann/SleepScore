function [ cl prob dv ] = applySVMmodel( vec, model_svm )
%APPLYSVMMODEL Summary of this function goes here
%   Detailed explanation goes here

    vec = [1 vec];
    
    %scale variables    model_svm(1,:) contains means and model_svm(2,:)
    %contains the SD
    vec_t = (vec - model_svm(1,:))./model_svm(2,:);
    
    %compute dot product, model_svm(3,:) contains betas from the svm
    dv = dot(vec_t , model_svm(3,:));

    %convert dv into a probability score
    %model_sv(4:) contains xxx for platt's transform
    pa = model_svm(4,1);
    pb = model_svm(4,2);
    
    prob = 1 / (1 + exp(dv * pa + pb));
    
    cl = 1;
    if prob <= .5
        cl = -1;
    end

end

