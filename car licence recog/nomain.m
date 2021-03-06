%function carreco
close all
clear all;

%==========================================================
%说明：
%
%
%===========================================================
% ==============测定算法执行的时间，开始计时=================
tic
%=====================读入图片================================
[fn,pn,fi]=uigetfile('*.jpg','选择图片');
I=imread([pn fn]);figure,imshow(I);title('原始图像');%显示原始图像
chepailujing=[pn fn]
I_bai=I;
[PY2,PY1,PX2,PX1]=caitu_fenge(I);
[U V]=size(I);
%===============车牌区域根据面积二次修正======================
[PY2,PY1,PX2,PX1,threshold]=SEC_xiuzheng(PY2,PY1,PX2,PX1);
%==============更新图片=============================
Plate=I_bai(PY1:PY2,PX1:PX2,:);%使用caitu_tiqu
 hold on;
        line1 = [1 PY1; V PY1];
         plot(line1(:, 1), line1(:, 2), 'y-', 'LineWidth', 2);pause(1.5);
 hold on;
        line2 = [1 PY2; V PY2];
         plot(line2(:, 1), line2(:, 2), 'r-', 'LineWidth', 2);pause(1.5);
    hold on;
        line3 = [PX1 1; PX1 U];
         plot(line3(:, 1), line3(:, 2), 'g-', 'LineWidth', 2);pause(1.5);
          hold on;
        line4 = [PX2 1; PX2 U];
         plot(line4(:, 1), line4(:, 2), 'b-', 'LineWidth', 2);
%==============考虑用腐蚀解决蓝色车问题=============
bw=Plate;figure,imshow(bw);title('车牌图像');%hsv彩图提取图像
%==============这里要根据图像的倾斜度进行选择这里选择的图片20090425686.jpg
bw=rgb2gray(bw);figure,imshow(bw);title('灰度图像');
%================倾斜校正======================
qingxiejiao=rando_bianhuan(bw)
bw=imrotate(bw,qingxiejiao,'bilinear','crop');figure,imshow(bw);title('倾斜校正');%取值为负值向右旋转
%==============================================
bw=im2bw(bw);%figure,imshow(bw);
bw=bwmorph(bw,'hbreak',inf);%figure,imshow(bw);
bw=bwmorph(bw,'spur',inf);%figure,imshow(bw);title('擦除之前');
bw=bwmorph(bw,'open',5);%figure,imshow(bw);title('闭合运算');
bw = bwareaopen(bw, threshold);figure,imshow(bw);title('擦除');
%==================加入进度条================================
% h=waitbar(0,'程序运行中，请稍等......')
% for i=1:10000
%     waitbar(i/5000,h) 
% end
% close(h);
%wavplay(wavread('程序运行中.wav'),22000);
%==========================================================
bw=~bw;figure,imshow(bw);title('擦除反色'); 
%=============对图像进一步裁剪，保证边框贴近字体===========
bw=touying(bw);figure;imshow(bw);title('Y方向处理');
bw=~bw;
bw = bwareaopen(bw, threshold);
bw=~bw;%figure,imshow(bw);title('二次擦除');
[y,x]=size(bw);%对长宽重新赋值
%=================文字分割=================================
fenge=shuzifenge(bw,qingxiejiao)
[m,k]=size(fenge);
%=================显示分割图像结果========================= 
figure;
 for s=1:2:k-1
    subplot(1,k/2,(s+1)/2);imshow(bw( 1:y,fenge(s):fenge(s+1)));
end
%================ 给七张图片定位===============桂AV6388
han_zi  =bw( 1:y,fenge(1):fenge(2));imshow(han_zi);
zi_mu   =bw( 1:y,fenge(3):fenge(4));
zm_sz_1 =bw( 1:y,fenge(5):fenge(6));
zm_sz_2 =bw( 1:y,fenge(7):fenge(8));  
shuzi_1 =bw( 1:y,fenge(9):fenge(10)); 
shuzi_2 =bw( 1:y,fenge(11):fenge(12)); 
shuzi_3 =bw( 1:y,fenge(13):fenge(14)); 
%==========================识别====================================
%======================把修正数据读入==============================
xiuzhenghanzi =   imresize(han_zi, [110 55],'bilinear');
xiuzhengzimu  =   imresize(zi_mu,  [110 55],'bilinear');
xiuzhengzm_sz_1=  imresize(zm_sz_1,[110 55],'bilinear');
xiuzhengzm_sz_2 = imresize(zm_sz_2,[110 55],'bilinear');
xiuzhengshuzi_1 = imresize(shuzi_1,[110 55],'bilinear');
xiuzhengshuzi_2 = imresize(shuzi_2,[110 55],'bilinear');
xiuzhengshuzi_3 = imresize(shuzi_3,[110 55],'bilinear');
%============ 把0-9 , A-Z以及省份简称的数据存储方便访问====================
hanzishengfen=duquhanzi(imread('cpgui.bmp'),imread('cpguizhou.bmp'),imread('cpjing.bmp'),imread('cpsu.bmp'),imread('cpyue.bmp'));
%因数字和字母比例不同。这里要修改
shuzizimu=duquszzm(imread('0.bmp'),imread('1.bmp'),imread('2.bmp'),imread('3.bmp'),imread('4.bmp'),...
                   imread('5.bmp'),imread('6.bmp'),imread('7.bmp'),imread('8.bmp'),imread('9.bmp'),...
                   imread('10.bmp'),imread('11.bmp'),imread('12.bmp'),imread('13.bmp'),imread('14.bmp'),...
                   imread('15.bmp'),imread('16.bmp'),imread('17.bmp'),imread('18.bmp'),imread('19.bmp'),...
                   imread('20.bmp'),imread('21.bmp'),imread('22.bmp'),imread('23.bmp'),imread('24.bmp'),...
                   imread('25.bmp'),imread('26.bmp'),imread('27.bmp'),imread('28.bmp'),imread('29.bmp'),...
                   imread('30.bmp'),imread('31.bmp'),imread('32.bmp'),imread('33.bmp'));
zimu  = duquzimu(imread('10.bmp'),imread('11.bmp'),imread('12.bmp'),imread('13.bmp'),imread('14.bmp'),...
                 imread('15.bmp'),imread('16.bmp'),imread('17.bmp'),imread('18.bmp'),imread('19.bmp'),...
                 imread('20.bmp'),imread('21.bmp'),imread('22.bmp'),imread('23.bmp'),imread('24.bmp'),...
                 imread('25.bmp'),imread('26.bmp'),imread('27.bmp'),imread('28.bmp'),imread('29.bmp'),...
                 imread('30.bmp'),imread('31.bmp'),imread('32.bmp'),imread('33.bmp'));
shuzi = duqushuzi(imread('0.bmp'),imread('1.bmp'),imread('2.bmp'),imread('3.bmp'),imread('4.bmp'),...
                 imread('5.bmp'),imread('6.bmp'),imread('7.bmp'),imread('8.bmp'),imread('9.bmp')); 
%============================识别结果================================  
i=1;%shibiezm_sz该函数识别数字有问题
jieguohanzi  = shibiehanzi(hanzishengfen,xiuzhenghanzi);shibiejieguo(1,i) =jieguohanzi;  i=i+1;
jieguozimu   = shibiezimu(zimu,xiuzhengzimu);           shibiejieguo(1,i) =jieguozimu;   i=i+1;
jieguozm_sz_1= shibiezm_sz(shuzizimu,xiuzhengzm_sz_1);  shibiejieguo(1,i) =jieguozm_sz_1;i=i+1;
jieguozm_sz_2= shibiezm_sz(shuzizimu,xiuzhengzm_sz_2);  shibiejieguo(1,i) =jieguozm_sz_2;i=i+1;
jieguoshuzi_1= shibieshuzi(shuzi,xiuzhengshuzi_1);      shibiejieguo(1,i) =jieguoshuzi_1;i=i+1;
jieguoshuzi_2= shibieshuzi(shuzi,xiuzhengshuzi_2);      shibiejieguo(1,i) =jieguoshuzi_2;i=i+1;
jieguoshuzi_3= shibieshuzi(shuzi,xiuzhengshuzi_3);      shibiejieguo(1,i) =jieguoshuzi_3;i=i+1;
%==========================对话框显示显示=============================================
shibiejieguo
msgbox(shibiejieguo,'识别结果');
%=====================导出文本==================
fid=fopen('Data.xls','a+');
fprintf(fid,'%s\r\n',shibiejieguo,datestr(now));
fclose(fid);
%===================读出声音===================
%duchushengyin(shibiejieguo);
%================读取计时==========================
t=toc 
%=======================================
 













