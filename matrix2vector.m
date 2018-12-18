function [ vec ] = matrix2vector( mat )
%MATRIX2VECTOR takes the upper triangle of a matrix
%       and turns it into a vecto
        vec = [];
        nc=size(mat,2);
        
        for i = 1:(nc-1)
            vec = [vec mat(i,i+1:nc)];
        end

end

