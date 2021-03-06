function X = MyFDCT2(x)
    m = size(x,2);
    n = size(x,1);
    aa = x(1:n,:);
    % Compute weights to multiply DFT coefficients
    ww = (exp(-1i*(0:n-1)*pi/(2*n))/sqrt(2*n)).';
    ww(1) = ww(1) / sqrt(2);
    
    % Re-order the elements of the columns of x
    y = [ aa(1:2:n,:); aa(n:-2:2,:) ];
    yy = fft(y);  
    ww = 2*ww;  % Double the weights for even-length case  
    
    % Multiply FFT by weights:
    X = ww(:,ones(1,m)) .* yy;

    if isreal(x)
      X = real(X);
    end
end