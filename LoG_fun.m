function  out  = LoG_fun( img,sigma, n )
% this function computes gaussian scale space and its second derivatives
% the output image is acheieved using max selection through third dimension

%% inputs:
% img: the input image

% sigma:  standard deviation of gaussian kernel


% n: number of scales

%% output
% out: output filtered image
%%
[nrows,ncols]=size(img);
ksize=ceil(4*sigma);
x=-ksize:ksize;
y=x;
[X,Y]=meshgrid(x,y);

gauss_krl=(1/(2*pi*(sigma^2)))*exp(-((X.^2)+(Y.^2))/(2*(sigma^2)));


outg=zeros(nrows,ncols,n);
outg(:,:,1)=imfilter(img,gauss_krl,'replicate');
for i=1:n-1

       outg(:,:,i+1)=imfilter(outg(:,:,i),gauss_krl,'replicate');
%     img2=(j*sigma^2)*conv2(img,[-1 -1 -1; -1 8 -1; -1 -1 -1],'same');
    
end
outw=zeros(nrows,ncols,n);


for i=1:n

%     img2=(j*sigma^2)*conv2(img,[-1 -1 -1; -1 8 -1; -1 -1 -1],'same');
       outw(:,:,i)=i*(sigma^2)*imfilter(outg(:,:,i),[-1 -1 -1; -1 8 -1; -1 -1 -1],'replicate');

end


out=max(outw,[],3);

end