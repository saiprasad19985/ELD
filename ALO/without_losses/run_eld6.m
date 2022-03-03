%% This program solve Economic load Dispatch (ELD) problem without Transmission losses using Ant Lion Optimization
clear all;
clc;
format short;
global data lb ub dim  Pd  B
%% Enter the No. of Search Agents
SearchAgents=40; % Number of search Agents (i.e. No. of Population)
%% Maximum number of iterations
Max_iteration=500; 
%% input data ( generator coeffecients,upper and lower limits)
 data=[0.15240	38.53973	756.79886	10	125
       0.10587	46.15916	451.32513	10	150
       0.02803	40.39655    1049.9977	35	225
       0.03546	38.30553	1243.5311	35	210
       0.02111	36.32782	1658.5596	130	325
       0.01799	38.27041	1356.6592	125	315];
B=1e-4*[.14 .17 .15 .19 .26 .22;.17 .60 .13 .16 .15 .20;.15 .13 .65 .17 .24 .19;.19 .16 .17 .71 .30 .25;.26 .15 .24 .30 .69 .32;.22 .20 .19 .25 .32 .85];

Pd=700;% load demand
Function_name='eld';
[lb,ub,dim,fobj]=input(Function_name);
% Use ALO Main function to Evaluate the Population
[Best_score,Best_pos,cg_curve]=ALO(SearchAgents,Max_iteration,lb,ub,dim,fobj);
semilogy(cg_curve,'m-.');% for ploting the graph
[ F P1 ]=eld(Best_pos);

display(['Fuel Cost  : ', num2str(F,10)]);
display(['generation : ', num2str(P1,5)]);


title('Objective space')
xlabel('Iterations');
ylabel('Fule Cost (Rs./hour)');
legend('ELD without losses using ALO')