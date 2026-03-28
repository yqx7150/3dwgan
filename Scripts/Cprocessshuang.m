%This program is used to process the binary files to form a maximum
%amplitude projections (C Scan)
%Written by YY Liu at 2012/5/8
%  matlabpool local 1

step=94;      %step number
line= 99;         %scan line number
sample=43;    %samples per step
inputrange_signal=1;   %PA signal input range
inputrange_ref=1;       %reference signal input range
choice=2;                    %MAP choice;1=max; 2=max(abs); 3=max(abs(hilbert))
%max/min/zero 12-bit code
max_dec12=hex2dec('fff');
min_dec12=hex2dec('000');
zero_dec12=(max_dec12-min_dec12)/2.0;
%  pc_data=zeros(1024,250);
MAP=zeros(line,step);
% REF=zeros(line,step);           %REF matrix for quantitative debug only
% MAPref=zeros(line,step);
% MAP3=zeros(line,step);
for i=0:line-1
 data_PA=data19_SNR0_fusion_cut(:,:,i+1);
  
%     FilePath=['G:\fangke\3dronghe\zerbra\2-50\1_',num2str(i),'.bin'];
%     %open file as binary
%     fid=fopen(FilePath,'rb');
%     %read 8-bit data(2 means that each data is 2 bytes and 2 channels)
%     [data_dec8,datcount]=fread(fid,2*2*sample*step,'uint8');
%     %8-bit dec to 12-bit dec
%     fclose(fid);
%     data_dec12=data_dec8(2:2:2*2*step*sample)*16+floor(data_dec8(1:2:2*2*step*sample-1)/16);
%     %The following code to transfer data to voltage
%     %tranfer all 12-bit decimal data to voltage
%     data_voltage=(data_dec12-zero_dec12)/zero_dec12*inputrange_signal;
%     %assign voltage to different channels
%     %5 buffers are used,normally
%     data_temp1=reshape(data_voltage,step*sample/5,10);
%     %Photoacoustic signal
%      if (mod(i,2)==0)
%     data_PA=reshape(data_temp1(:,1:2:9),sample,step);
%     data_ref=reshape(data_temp1(:,2:2:10),sample,step)/inputrange_signal*inputrange_ref;
%      else
%           data_PA=reshape(data_temp1(:,1:2:9),sample,step);
%            data_PA1=zeros(sample,step);
%           for n=1:step
% %               if (n<step/2+0.5)
%              
%                   data_PA1(:,2*(step/2+0.5)-n)=data_PA(:,n);
% %               else
% %                   data_PA1(:,2*(step/2+0.5)-n)=data_PA(:,n);
%           end
%           data_PA=   data_PA1;
%     data_ref=reshape(data_temp1(:,2:2:10),sample,step)/inputrange_signal*inputrange_ref;
%      end
%      FilePath=['D:\data\20151222\fnetc1_',num2str(i),'.bin'];
%     %open file as binary
%     fid=fopen(FilePath,'rb');
%     %read 8-bit data(2 means that each data is 2 bytes and 2 channels)
%     [data_dec8,datcount]=fread(fid,2*2*sample*step,'uint8');
%     %8-bit dec to 12-bit dec
%     fclose(fid);
%     data_dec12=data_dec8(2:2:2*2*step*sample)*16+floor(data_dec8(1:2:2*2*step*sample-1)/16);
%     %The following code to transfer data to voltage
%     %tranfer all 12-bit decimal data to voltage
%     data_voltage=(data_dec12-zero_dec12)/zero_dec12*inputrange_signal;
%     %assign voltage to different channels
%     %5 buffers are used,normally
%     data_temp1=reshape(data_voltage,step*sample/5,10);
%     %Photoacoustic signal
%     data_PA1=reshape(data_temp1(:,1:2:9),sample,step);
%     data_ref=reshape(data_temp1(:,2:2:10),sample,step)/inputrange_signal*inputrange_ref;
%     
%     data_PA=data_PA+data_PA1;
    %######################################
    %Added for Hui Wang at 20130603
%     data_PA=data_PA-ones(1024,1)*mean(data_PA);
    %######################################
    %Laser power reference signal
    %######################################
    %Added By ZHAOKAI,for image with dot
   % for j=1:1024
    %      for k=1:500
    %     if(abs(data_PA(j,k)))>0.3
   %         data_PA(j,k)=0;
     %      end
  %     end
 %  end
   %  for m=1:1024
  %     for  n=1:500
   %         if(abs(data_ref(m,n)))>0.1
    %            data_ref(m,n)=0;
    %        end
    %     end
   % end
    %######################################

       [Y,U]=max(abs(data_PA))  ;
%     temp_ref=ones(sample,1)*mean(data_ref);
    if(choice==1)
        MAP(i+1,:)=max(data_PA(:,:));
        MAPref(i+1,:)=max(data_PA./temp_ref);
    end
    if(choice==2)
%    pc_data=pc_data+data_PA;
        MAP(i+1,:)=max(abs(data_PA(:,:)));
       MAPref(i+1,:)=U;
%        REF(i+1,:)=max(abs(temp_ref));      %REF matrix for quantitative debug only
    end
    if(choice==3)
        MAP(i+1,:)=max(abs(hilbert(data_PA(:,:))));
        REF(i+1,:)=max(abs(temp_ref));      %REF matrix for quantitative debug only
        MAPref(i+1,:)=max(abs(hilbert(data_PA(:,:)./temp_ref(:,:))));
    end
    disp(['line ',num2str(i+1),' completed']);
end

%   matlabpool close
% MAP3=MAP;
figure;imagesc(MAP( : , : )); 
colormap(hot);
%   figure;imagesc(pc_data);            %MAP with no reference
%  colormap(gray);
colorbar
f1=medfilt2(MAP, [3 3]);
figure;imshow(f1(:,:),[]); 
colormap(hot);
