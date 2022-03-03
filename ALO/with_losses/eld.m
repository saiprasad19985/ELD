% This program solves the economic dispatch with Bmn coefficients by
% Ant Lion Algorithm
function[ F P1 Pl]=abceld(x)
global objfun D ub lb data B  Pd
n=length(data(:,1));
[m n1]=size(x);
P=x(1:m,2:n);
B11=B(1,1);
B1n=B(1,2:n);
Bnn=B(2:n,2:n);
A=B11;
BB1=2*B1n*P';
B1=(BB1-1)';
C1=(P*Bnn*P');
C1=diag(C1);
C=Pd-(sum(P'))'+C1;
 A=A*ones(m,1);
for i=1:m
    y=[A(i) B1(i) C(i)];
x1(i,:)=roots(y);
 x2(i)=(abs(min(x1(i,:))))';
 if x2(i)>data(1,5)
     x2(i)=data(1,5);
 else
 end
   if x2(i)<data(1,4)
x2(i)=data(1,4);
   else
   end
end
 P1=[x2' P];
 a1=data(:,1);
 b1=data(:,2);
 c1=sum(data(:,3));
 F1=P1.*P1*a1+P1*b1+c1;
 Pl1=(P1*B*P1').';
 Pl=diag(Pl1);;
 lam=abs(sum(P1')'-Pd-Pl);
 F=(F1)+1000*lam;
% This program solves the economic dispatch with Bmn coefficients by
% Ant Lion Algorithm
function[ F P1 Pl]=input(x)
global objfun D ub lb data B  Pd
n=length(data(:,1));
[m n1]=size(x);
P=x(1:m,2:n);
B11=B(1,1);
B1n=B(1,2:n);
Bnn=B(2:n,2:n);
A=B11;
BB1=2*B1n*P';
B1=(BB1-1)';
C1=(P*Bnn*P');
C1=diag(C1);
C=Pd-(sum(P'))'+C1;
 A=A*ones(m,1);
for i=1:m
    y=[A(i) B1(i) C(i)];
x1(i,:)=roots(y);
 x2(i)=(abs(min(x1(i,:))))';
 if x2(i)>data(1,5)
     x2(i)=data(1,5);
 else
 end
   if x2(i)<data(1,4)
x2(i)=data(1,4);
   else
   end
end
 P1=[x2' P];
 a1=data(:,1);
 b1=data(:,2);
 c1=sum(data(:,3));
 F1=P1.*P1*a1+P1*b1+c1;
 Pl1=(P1*B*P1').';
 Pl=diag(Pl1);;
 lam=abs(sum(P1')'-Pd-Pl);
 F=(F1)+1000*lam;
