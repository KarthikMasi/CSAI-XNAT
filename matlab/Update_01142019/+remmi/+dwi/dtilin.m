function [adc,fa,vec,eign] = dtilin(sig,bmat)
% function [adc,fa,vec,eign] = dtilin(sig,bmat,std_noise) performs   
% linearized diffusion tensor analysis
%   sig = diffusion-weighted signal
%   bmat = matrix given as [Dxx,Dyy,Dzz,Dxy,Dyz,Dxz,log(S0);...]'
% 
% returns:
%   adc = apparent diffusion coefficient 
%   fa = fractional anisotropy
%   vec = 3x3 matrix of eigenvectors
%   eign = 3 eigenvalues
%
%  This function uses the weighted-least squares algorithm outlined in:
%  Kingsley P B 2006 Introduction to Diffusion Tensor Imaging Mathematics: 
%  Part III. Tensor Calculation, Noise, Simulations, and Optimization 
%  Concepts Magn. Reson. Part A 28A 155-79
%
%  Note: dtilin tends to be more sensitive to noise than dtinonlin, but 
%  much faster.

% linearize the problem
sig1 = -log(sig/sig(1));

% fit and make the D matrix
D = (bmat*bmat')\(bmat)*sig1;
D = diag(D(1:3)) + (diag(D(4:5),-1) + diag(D(4:5),1) + diag(D(6),-2) + diag(D(6),2))/2;

% eigenvalue/vector decomposition
[vec,val] = eig(D);
eign = abs(diag(val)*1000);

% calculate the apparent diffusion coefficient and fractional anisotropy
adc = mean(eign);
fa = sqrt(3/2*sum((eign-adc).^2)/sum(eign.^2));