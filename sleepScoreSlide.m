function [ label, prS0, raw_results ] = sleepScoreSlide( subject_file, model_path, window_size, shift_size )
%SLEEPSCORESLIDE same as sleepScore but does sliding window
%               additional parameters are: 
%                   - window_size (in frames)
%                   - shift_size (in frames)
%
% returns:  label - from multi class model (S0,S1,S2,SW)
%                   one prediction for each window
%           prS0  - probability of S0 from S0|SX model
%                   optimal threshold not at 0.5, but rather 0.25 (see
%                   paper). I.e, values > 0.25 are S0 below SX.
%                   one prediction for each window
%           raw_results - raw pairwise predictions for all 7 models
%                   rows equal the models from the models variable below
%
%           raw_results have a 3rd dimension corrsponding to the window


%change if needed
    seconds='48';
    main='matlab';
    models={'S0vsS1', 'S0vsS2', 'S0vsSW', 'S1vsS2', 'S1vsSW', 'S2vsSW','S0vsSX'}; 
    

    %read time series from flat file
    ts=readTS(subject_file);
    
    frames=size(ts,1);
    
    %compute correlation matrix and fisherz transform
    cmat_tot=ts2cor(ts);
    %get upper triangle of matrix
    cvec_tot=matrix2vector(cmat_tot);
    
    all_win = [];
    wend = window_size;
    while wend <= frames
        wstart = wend - window_size + 1;
        cmat=ts2cor(ts(wstart:wend,:));
        cvec=matrix2vector(cmat);
        all_win = [all_win; cvec];
        wend = wend + shift_size;
    end
    nwin = size(all_win, 1);
    
    
    raw_results = zeros(size(models,2),3,nwin);
    for i=1:size(models,2)
        mod=models{i};
        fn=[model_path, '/', main, '_w', seconds, 's_ALL_', mod, '.txt'];
        mymod=readSVMmodel(fn);
        for n = 1:nwin
            cvec = all_win(n,:);
            [cl, pr, dv] = applySVMmodel(cvec, mymod);
            raw_results(i,:,n) = [cl, pr, dv];        
        end        
    end
    %columns of raw results contain (class, probability, decision value);
    
    
    dummy = raw_results(7,2,:);
    prS0  = dummy(:);
    label = [];
    for n=1:nwin
        label = [ label; useECOC(raw_results(1:6,2,n)')];
    end

end

