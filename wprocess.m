function [wp] = wprocess(sm, st)
%WPROCESS Paths of wiener process using the wavelet construction. 
%   [WP] = WPROCESS(SM, ST) returns a sample path in the interval [0, 1]
%   of a Wiener process constructed using wavelets. SM is the number of
%   samples of the path, and ST is the number of steps taken in the
%   construction of the sample path.
%       
%   Note: For accuracy of construction the value of SM must be a 
%   power of 2.
% 
%   For example, wp = wprocess(1024, 100).

if nargin ~= 2
  error('wprocess:invalidInputs', 'Wrong numer of input parameters.');
end

if any(sm <= 0 | st <=0) 
  error('wprocess:invalidInputs', 'Enter SM, and ST > 0.');
end

[f, e] = log2(sm);
if f ~= 0.5
  error('wprocess:invalidInputs', 'Value of SM must be a power of 2.');
end 

mu = 0;
sigma = 1;
x = linspace(0, 1, sm);
wiener = zeros(1, length(x));

% for n = 0
a_0 = 1;
psi_0 = x;

wiener = wiener + a_0 * psi_0 * normrnd(mu, sigma);

% for n = 1
a_1 = 1/2;

psi_1 = zeros(1, length(x));
i = 1;
while x(i) < 0.5
  psi_1(i) = 2 * x(i);
  i = i + 1;
end
while i <= length(x)
  psi_1(i) = 2-2 * x(i);
  i = i + 1;
end

wiener = wiener + a_1 * psi_1 * normrnd(mu, sigma);

% for n > 1
j = 1;
while j >= 1
  sampled_psi = downsample(psi_1, 2^j);
  sampled_psi = sampled_psi(1:floor(sm/2^j));  

  k = 0;
  while k < 2^j  
    n = 2^j + k;
    if (n > st)
      wp = wiener;
      return;
    end

    a_n = 2^(-(j/2 + 1));        

    a = k * length(sampled_psi) + 1;
    b = a + length(sampled_psi) - 1;
    psi_n = zeros(1, length(x)); 
    psi_n(a:b) = sampled_psi;        

    wiener = wiener + a_n * psi_n*normrnd(mu, sigma);

    k = k + 1;
  end
  j = j + 1;
end
