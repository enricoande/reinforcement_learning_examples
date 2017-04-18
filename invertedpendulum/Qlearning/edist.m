function [ d ] = edist( x , y )
% edist.m     E.Anderlini@ed.ac.uk     08/06/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function calculates the Euclidean distance in multi-dimensional
% space between two matrices of dimensions ((nw x nB) x n) along each row.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
% Calculating the Euclidean distance at every row:
d = sum((x-y).^2,2).^0.5;  %,2 indicates along each row