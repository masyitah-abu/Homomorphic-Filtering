clear;clc;
sigma=input('How much noise you want to add?:');
%% Original image
i = imread('raw.PNG');
I = rgb2gray(i);
I1 = imresize(I, [256 256]);
figure(1)
imshow(I1);colormap gray
title('original image','fontsize',14)

%% Image+noise
R = imnoise(I1, 'speckle', sigma); 
figure(2)
imshow(R);colormap gray
title('Speckle noise','fontsize',14)

R=im2double(R);
R=log(R+1);
%% Filtering
%% Wiener
n = input( 'Enter class number:' );
switch n
     case 1
        N = size(I1,1);
        %sigma =10;
        alpha=1;
        gamma=1;
        Xf = fft2(I1); %fft ori image
        Hf = fft2(R); % fft noise
        y = real(ifft2(Hf.*Xf))+sigma*randn(N,N); % inverse fft both y=image+noise

        Yf = fft2(y);
        Pyf = (abs(Yf).^2)./((abs(Yf)).^2)+((abs(Hf)).^2); %Class 1

        sHf = Hf.*(abs(Hf)>0)+1/gamma*(abs(Hf)==0);
        iHf = 1./sHf;
        iHf = iHf.*(abs(Hf)*gamma>1)+gamma*abs(sHf).*iHf.*(abs(sHf)*gamma<=1);

        Pyf = Pyf.*(Pyf>sigma^2)+sigma^2*(Pyf<=sigma^2);
        Gf = iHf.*(Pyf-sigma^2)./(Pyf-(1-alpha)*sigma^2);

        eXf = Gf.*Yf;
        E = real(ifft2(eXf));
     case 2
       N = size(I1,1);
        %sigma =10;
        alpha=1;
        gamma=1;
        Xf = fft2(I1); %fft ori image
        Hf = fft2(R); % fft noise
        y = real(ifft2(Hf.*Xf)); % inverse fft both y=image+noise

        Yf = fft2(y);
        Pyf = (abs(Yf).^2)/(abs((Yf)+(Yf+Hf))-(Hf)-log(1))^2;%Class 2

        sHf = Hf.*(abs(Hf)>0)+1/gamma*(abs(Hf)==0);
        iHf = 1./sHf;
        iHf = iHf.*(abs(Hf)*gamma>1)+gamma*abs(sHf).*iHf.*(abs(sHf)*gamma<=1);

        Pyf = Pyf.*(Pyf>sigma^2)+sigma^2*(Pyf<=sigma^2);
        Gf = iHf.*(Pyf-sigma^2)./(Pyf-(1-alpha)*sigma^2);

        eXf = Gf.*Yf;
        E = real(ifft2(eXf));
     case 3
        N = size(I1,1);
        %sigma =10;
        alpha=1;
        Xf = fft2(I1); 
        Hf = fft2(R);
        y = real(ifft2(Hf.*Xf));

        Yf = fft2(y);
        Pyf = ((abs(Yf)+abs(Hf)).^2)./((abs(Yf)).^2)+((abs(Hf)).^2);% Class 3

        iHf = 1./Hf;
        Pyf = Pyf.*(Pyf>sigma^2)+sigma^2*(Pyf<=sigma^2);
        Gf = iHf.*(Pyf-sigma^2)./(Pyf-(1-alpha)*sigma^2);

        eXf = Gf.*Yf;
        E = real(ifft2(eXf));
    otherwise 
        disp('no class')
 end

%% Error

T5 = uint8(E);
figure(6)
imshow(T5, []);colormap gray
title('Output Image of Wiener Filter','fontsize',14)
[peaksnr5, snr5] = psnr(T5, I1);
err5 = immse(T5, I1);

FilterName = {'Wiener'};
PSNR = [peaksnr5];
SNR = [snr5];
MSE = [err5];
Wiener_Filter = table(FilterName,PSNR,SNR,MSE)

