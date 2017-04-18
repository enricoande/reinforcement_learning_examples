function sample = get_sample(s,a,r,sp)
% get_sample.m     E.Anderlini@ed.ac.uk     26/08/2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function returns a sample structure given the current state, action,
% reward and future state.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sample.state     = s;
sample.action    = a;
sample.reward    = r;
sample.nextstate = sp;

end