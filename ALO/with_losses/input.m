
function [lb,ub,dim,fobj] = input(F)
global data 
switch F
            
    case 'eld'
   
    fobj = @eld;
lb=data(:,4)';%/*lower bounds of the parameters. */
ub=data(:,5)';
dim=length(data(:,1));    
end