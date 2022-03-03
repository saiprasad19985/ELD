function [ F P1 ]=eld(x)
global data  Pd


a1=data(:,1);
 b1=data(:,2);
 c1=sum(data(:,3));
 
n=length(data(:,1));
p=x(:,2:n);
r=Pd-sum(p);
 
 if r>data(1,5)
     r=data(1,5);                         
 elseif r<data(1,4)
     r=data(1,4);                              
 end

 Pgenerating =[r p];
 P1=Pgenerating;
 F1=P1.*P1*a1+P1*b1+c1;
  lam=abs(sum(P1)-Pd);
F=(F1)+1000*lam;
 