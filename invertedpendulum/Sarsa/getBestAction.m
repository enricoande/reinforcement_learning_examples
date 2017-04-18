function [ a ] = getBestAction( Q )
% getBestAction.m     E.Anderlini@ed.ac.uk     26/08/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Given the entries of the Q-table for the current state, this function 
% returns the action that results in the maximum Q-value for that state.
% Input:
% Q(nActions):         Q-table entries for current state s
% Output:
% a:                   index of the maximum action value for s
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[v a] = max(Q);        % value, action