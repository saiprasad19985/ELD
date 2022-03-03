% This program solves the economic dispatch with Bmn coefficients by
% Genetic Algorithm
% the data matrix should have 5 columns of fuel cost coefficients and plant  limits.
% 1.a ($/MW^2) 2. b $/MW 3. c ($) 4.lower lomit(MW) 5.Upper limit(MW)
%no of rows denote the no of plants(n)

function[F P1]=eldnba(x)
global data B Pd
x=abs(x);
n=length(data(:,1));
for i=1:n-1
    if x(i)>1
        x(i)=1;
    else
    end
    P(i)=data(i+1,4)+x(i)*(data(i+1,5)-data(i+1,4));
end
x=abs(min(x));
 if x>data(1,5)
     x=data(1,5);
 else
 end
   if x<data(1,4)
x=data(1,4);
   else
   end
 P1=[x P];
for i=1:n
   F1(i)=data(i,1)* P1(i)^2+data(i,2)*P1(i)+data(i,3);
end
% Pl=P1*B*P1';
 lam=abs(sum(P1)-Pd);
 F=sum(F1)+1000*lam;
