%function carreco
close all
clear all;

%==========================================================
%˵����
%
%
%===========================================================
% ==============�ⶨ�㷨ִ�е�ʱ�䣬��ʼ��ʱ=================
tic
%=====================����ͼƬ================================
[fn,pn,fi]=uigetfile('*.jpg','ѡ��ͼƬ');
I=imread([pn fn]);figure,imshow(I);title('ԭʼͼ��');%��ʾԭʼͼ��
chepailujing=[pn fn]
I_bai=I;
[PY2,PY1,PX2,PX1]=caitu_fenge(I);
[U V]=size(I);
%===============����������������������======================
[PY2,PY1,PX2,PX1,threshold]=SEC_xiuzheng(PY2,PY1,PX2,PX1);
%==============����ͼƬ=============================
Plate=I_bai(PY1:PY2,PX1:PX2,:);%ʹ��caitu_tiqu
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
%==============�����ø�ʴ�����ɫ������=============
bw=Plate;figure,imshow(bw);title('����ͼ��');%hsv��ͼ��ȡͼ��
%==============����Ҫ����ͼ�����б�Ƚ���ѡ������ѡ���ͼƬ20090425686.jpg
bw=rgb2gray(bw);figure,imshow(bw);title('�Ҷ�ͼ��');
%================��бУ��======================
qingxiejiao=rando_bianhuan(bw)
bw=imrotate(bw,qingxiejiao,'bilinear','crop');figure,imshow(bw);title('��бУ��');%ȡֵΪ��ֵ������ת
%==============================================
bw=im2bw(bw);%figure,imshow(bw);
bw=bwmorph(bw,'hbreak',inf);%figure,imshow(bw);
bw=bwmorph(bw,'spur',inf);%figure,imshow(bw);title('����֮ǰ');
bw=bwmorph(bw,'open',5);%figure,imshow(bw);title('�պ�����');
bw = bwareaopen(bw, threshold);figure,imshow(bw);title('����');
%==================���������================================
% h=waitbar(0,'���������У����Ե�......')
% for i=1:10000
%     waitbar(i/5000,h) 
% end
% close(h);
%wavplay(wavread('����������.wav'),22000);
%==========================================================
bw=~bw;figure,imshow(bw);title('������ɫ'); 
%=============��ͼ���һ���ü�����֤�߿���������===========
bw=touying(bw);figure;imshow(bw);title('Y������');
bw=~bw;
bw = bwareaopen(bw, threshold);
bw=~bw;%figure,imshow(bw);title('���β���');
[y,x]=size(bw);%�Գ������¸�ֵ
%=================���ַָ�=================================
fenge=shuzifenge(bw,qingxiejiao)
[m,k]=size(fenge);
%=================��ʾ�ָ�ͼ����========================= 
figure;
 for s=1:2:k-1
    subplot(1,k/2,(s+1)/2);imshow(bw( 1:y,fenge(s):fenge(s+1)));
end
%================ ������ͼƬ��λ===============��AV6388
han_zi  =bw( 1:y,fenge(1):fenge(2));imshow(han_zi);
zi_mu   =bw( 1:y,fenge(3):fenge(4));
zm_sz_1 =bw( 1:y,fenge(5):fenge(6));
zm_sz_2 =bw( 1:y,fenge(7):fenge(8));  
shuzi_1 =bw( 1:y,fenge(9):fenge(10)); 
shuzi_2 =bw( 1:y,fenge(11):fenge(12)); 
shuzi_3 =bw( 1:y,fenge(13):fenge(14)); 
%==========================ʶ��====================================
%======================���������ݶ���==============================
xiuzhenghanzi =   imresize(han_zi, [110 55],'bilinear');
xiuzhengzimu  =   imresize(zi_mu,  [110 55],'bilinear');
xiuzhengzm_sz_1=  imresize(zm_sz_1,[110 55],'bilinear');
xiuzhengzm_sz_2 = imresize(zm_sz_2,[110 55],'bilinear');
xiuzhengshuzi_1 = imresize(shuzi_1,[110 55],'bilinear');
xiuzhengshuzi_2 = imresize(shuzi_2,[110 55],'bilinear');
xiuzhengshuzi_3 = imresize(shuzi_3,[110 55],'bilinear');
%============ ��0-9 , A-Z�Լ�ʡ�ݼ�Ƶ����ݴ洢�������====================
hanzishengfen=duquhanzi(imread('cpgui.bmp'),imread('cpguizhou.bmp'),imread('cpjing.bmp'),imread('cpsu.bmp'),imread('cpyue.bmp'));
%�����ֺ���ĸ������ͬ������Ҫ�޸�
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
%============================ʶ����================================  
i=1;%shibiezm_sz�ú���ʶ������������
jieguohanzi  = shibiehanzi(hanzishengfen,xiuzhenghanzi);shibiejieguo(1,i) =jieguohanzi;  i=i+1;
jieguozimu   = shibiezimu(zimu,xiuzhengzimu);           shibiejieguo(1,i) =jieguozimu;   i=i+1;
jieguozm_sz_1= shibiezm_sz(shuzizimu,xiuzhengzm_sz_1);  shibiejieguo(1,i) =jieguozm_sz_1;i=i+1;
jieguozm_sz_2= shibiezm_sz(shuzizimu,xiuzhengzm_sz_2);  shibiejieguo(1,i) =jieguozm_sz_2;i=i+1;
jieguoshuzi_1= shibieshuzi(shuzi,xiuzhengshuzi_1);      shibiejieguo(1,i) =jieguoshuzi_1;i=i+1;
jieguoshuzi_2= shibieshuzi(shuzi,xiuzhengshuzi_2);      shibiejieguo(1,i) =jieguoshuzi_2;i=i+1;
jieguoshuzi_3= shibieshuzi(shuzi,xiuzhengshuzi_3);      shibiejieguo(1,i) =jieguoshuzi_3;i=i+1;
%==========================�Ի�����ʾ��ʾ=============================================
shibiejieguo
msgbox(shibiejieguo,'ʶ����');
%=====================�����ı�==================
fid=fopen('Data.xls','a+');
fprintf(fid,'%s\r\n',shibiejieguo,datestr(now));
fclose(fid);
%===================��������===================
%duchushengyin(shibiejieguo);
%================��ȡ��ʱ==========================
t=toc 
%=======================================
 












