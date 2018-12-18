function [ label, prS0, raw_results ] = sleepScore( subject_file, model_path )
%SLEEPSCORE 
%
% returns:  label - from multi class model (S0,S1,S2,SW)
%           prS0  - probability of S0 from S0|SX model
%                   optimal threshold not at 0.5, but rather 0.25 (see
%                   paper). I.e, values > 0.25 are S0 below SX.
%           raw_results - raw pairwise predictions for all 7 models
%                   rows equal the models from the models variable below
%



    %change if needed
    seconds='48';
    main='matlab';
    models={'S0vsS1', 'S0vsS2', 'S0vsSW', 'S1vsS2', 'S1vsSW', 'S2vsSW','S0vsSX'}; 
    

    %read time series from flat file
    ts=readTS(subject_file);
    
    %compute correlation matrix and fisherz transform
    cmat=ts2cor(ts);
    
    %get upper triangle of matrix
    cvec=matrix2vector(cmat);
    
    raw_results = zeros(size(models,2),3);
    for i=1:size(models,2)
        mod=models{i};
        fn=[model_path, '/', main, '_w', seconds, 's_ALL_', mod, '.txt'];
        %disp(fn);
        mymod=readSVMmodel(fn);
        [cl, pr, dv] = applySVMmodel(cvec, mymod);
        raw_results(i,:) = [cl, pr, dv];        
        
    end
    %columns of raw results contain (class, probability, decision value);
    
    
    prS0  = raw_results(7,2);
    label = useECOC(raw_results(1:6,2)');
    
    
    
end

