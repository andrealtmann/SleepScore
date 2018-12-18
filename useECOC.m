function [ label ] = useECOC( predictions )
%USEECOC Summary of this function goes here
%   Detailed explanation goes here
    
    classes = {'S0','S1','S2','SW'};
    
    decision_matrix =  [1.0, 1.0, 1.0, 0.5, 0.5, 0.5;   %S0
                        0.0, 0.5, 0.5, 1.0, 1.0, 0.5;   %S1
                        0.5, 0.0, 0.5, 0.0, 0.5, 1.0;   %S2
                        0.5, 0.5, 0.0, 0.5, 0.0, 0.0];  %SW
    
   mdist = zeros(4,1);
   for i = 1:4
      mdist(i) = sqrt(sum(power(decision_matrix(i,:) - predictions,2))); 
   end

   [mv, mi] = min(mdist);
   label = classes(mi);
   
end

