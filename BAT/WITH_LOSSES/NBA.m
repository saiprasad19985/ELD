% ------------------------------------------------------------------------
% Novel Bat Algorithm (NBA) (demo)
% Programmed by Xian-Bing Meng
% Updated at Jun 19, 2015.    
% Email: x.b.meng12@gmail.com
%
% This is a demo version implemented NBA for solving the unconstrained        
%   problem, namely Sphere function.  
%
% The details about NBA are illustratred in the following paper.    
% Xian-Bing Meng, et al. A novel bat algorithm with habitat selection and
%   Doppler effect in echoes for optimization, Expert Systems With 
%   Applications 42(2015) pp.6350-6364, DOI: 10.1016/j.eswa.2015.04.026
%
% The parameters in NBA are presented as follows.
% 1)The parameters in the basic Bat Algorithm (BA)
% FitFunc             % The objective function
% M                   % Maxmimal generations (iterations)
% pop                 % Population size
% dim                 % Dimension 
% r0Max, r0Min        % The maximal and minimal pulse rate
% freqDMax, freqDMin  % The maximal and minimal frequency
% AMax, AMin          % The maximal and minimal loudness
% gamma               
% alpha                
%
% 2)The additional parameters in Novel Bat Algorithm (NBA)
% G                   % The frequency of updating the loudness and pulse
%                           emission rate
% probMax, probMin    % The maximal and minimal probability of habitat
%                           selection
% CMax, CMin          % The maximal and minimal compensation rate for 
%                           Doppler effect in echoes
% thetaMax, thetaMin  % The maximal and minimal contraction�Cexpansion 
%                           coefficient
% wMax, wMin          % The maximal and minimal inertia weight
%
% Using the default value, NBA can be executed using the following code.
% [ bestX, fMin ] = NBA
% ------------------------------------------------------------------------
 
% Main programs

function [ bestX, fMin ] = NBA( FitFunc, M, pop, dim, G, gamma, alpha, ...
    r0Max, r0Min, AMax, AMin, freqDMax, freqDMin, probMax, probMin, ...
    CMax, CMin, thetaMax, thetaMin, wMax, wMin )
% Display help
help NBA.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set the default parameters
if nargin < 1
    % 1)The parameters in the basic Bat Algorithm (BA)
    FitFunc = @Sphere;
    M = 1000;   
    pop = 30;   
    dim = 20;   
    gamma = 0.9;
    alpha = 0.99;
    r0Max = 1;
    r0Min = 0;
    AMax = 2;
    AMin = 1;
    freqDMax = 1.5;
    freqDMin = 0;
    
    % 2)The additional parameters in Novel Bat Algorithm (NBA)
    G = 10;   
    probMax = 0.9;
    probMin = 0.6;
    thetaMax = 1;
    thetaMin = 0.5;
    wMax = 0.9;
    wMin = 0.5;
    CMax = 0.9;
    CMin = 0.1;
end

% set the parameters
lb= -100 * ones( 1,dim );   % Lower bounds
ub= 100 * ones( 1,dim );    % Upper bounds
vLb = 0.6 * lb;
vUb = 0.6 * ub;

r = rand( pop, 1 ) .* 0.2 + 0;
r0 = rand( pop, 1 ) .* ( r0Max - r0Min ) + r0Min;
A = rand( pop, 1 ) .* ( AMax - AMin ) + AMin;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Initialization

for i = 1 : pop
    x( i, : ) = lb + (ub - lb) .* rand( 1, dim ); 
    v( i, : ) = rand( 1, dim ); 
    fit( i ) = FitFunc( x( i, : ) ); 
end
pFit = fit; % The individual's best fitness value
pX = x;     % The individual's best position corresponding to the pFit

[ fMin, bestIndex ] = min( fit );  % fMin denotes the global optimum
% bestX denotes the position corresponding to fMin
bestX = x( bestIndex, : );   
bestIter = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Start the iteration.

 for iteration = 1 : M
 
    % The compensation rates for Doppler effect in echoes
    C = rand( pop, 1 ) .* ( CMax - CMin ) + CMin;
    % The probability of habitat selection
    prob = rand( pop, 1 ) .* ( probMax - probMin ) + probMin;
    % Contraction�Cexpansion coefficient
    theta=( thetaMax - thetaMin ) * ( M - iteration )/(1.0 * M) + thetaMin;
    
    freqD = rand( pop, dim ) .* ( freqDMax - freqDMin ) + freqDMin;  
    w = (wMax - wMin) * ( M - iteration )/(1.0 * M) + wMin; %Inertia weight
    
    meanP = mean( pX );
    meanA = mean( A );
    
    for i = 1 : pop
        if rand < prob
            if rand < 0.5
                x( i, : ) = bestX + theta * abs( meanP - pX(i, :) ) *...
                    log( 1.0/rand );
            else
                x( i, : ) = bestX - theta * abs( meanP - pX(i, :) ) *...
                    log( 1.0/rand );
            end
        else
            freqD( i, :) = freqD(i, :) .* ( 340 + v( i, : ) )./( 340 + ...
                v( bestIndex, : ) + realmin );
            v( i, : ) = w .* v( i, : ) + ( bestX - pX(i, :) ) .* ...
                freqD(i,:) .* ( 1 + C(i) .* ( bestX - pX(i, :) ) ./...
                ( abs( bestX - pX(i, :) ) + realmin ) );
            
            v( i, : ) = Bounds( v( i, : ), vLb, vUb );  
            x( i, : ) = x( i, : ) + v( i, : );
        end    
    
        % Local search
        if rand > r( i )
            randnValueA = randn( 1,dim ).* ( abs( A(i) - meanA )+ realmin);
            x( i, : ) = bestX .* ( 1 + randnValueA );
        end   
        
        x( i, : ) = Bounds( x( i, : ), lb, ub );  
        fit( i ) = FitFunc( x( i, : ) );
    end
  
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Update the individual's best fitness vlaue and the global best one
   
    for i = 1 : pop 
        if fit( i ) < pFit( i )
            pFit( i ) = fit( i );
            pX( i, : ) = x( i, : );
        end
        
        if( pFit( i ) < fMin && rand < A(i) )
            fMin = pFit( i );
            bestX = pX( i, : );
            bestIndex = i;
            bestIter = iteration;
            
            A(i) = A(i) * alpha;
            r(i) = r0(i) * ( 1 - exp( -gamma * iteration ) );
        end
    end
    
    if( iteration - bestIter > G )                  
         r = rand( pop, 1 ) .* 0.05 + 0.85;
         A = rand( pop, 1 ) .* ( AMax - AMin ) + AMin;
    end

end
% End of the main program

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The following functions are associated with the main program
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is the objective function
function y = Sphere( x )
y = sum( x .^ 2 );

% Application of simple limits/bounds
function s = Bounds( s, Lb, Ub)
  % Apply the lower bound vector
  temp = s;
  I = temp < Lb;
  temp(I) = Lb(I);
  
  % Apply the upper bound vector 
  J = temp > Ub;
  temp(J) = Ub(J);
  % Update this new move 
  s = temp;