function [varians,curves,fdegrees]=radonTrs(I)
% density Radon transform
IBack=zeros(size(I)); % ����������,�� I ͬʱ��ת�����Ӽ���
limit=min([size(I,2) size(I,1)]);

step=15;
varians=zeros(1,180/step);
curves=cell(1,fix(180/step));
sliceWide=5;   % ��Ƭ�Ŀ�ȣ� ����Ϊ���ߵĿ��
for i=step:step:180   % �� 1 ����Ϊ 180 �Ⱥ� 0 ����һ����
    tempI=~I; tempIBack=~IBack;
    tempI=imrotate(tempI,i); tempIBack=imrotate(tempIBack,i);
    tempI=~tempI;tempIBack=~tempIBack;
    % ��ʼ��Ƭ����
    sliceNum=fix(size(tempI,2)/sliceWide);  % ��Ƭ������
    sliceDensity=zeros(1,sliceNum);     %  ��Ƭ����ԻҶ��ܶ�
    
    tmp=zeros(1,sliceNum); % ������ԵӰ����
    for j=1:sliceNum
        SliceI=tempI(:,(j-1)*sliceWide+1:j*sliceWide);
        SliceIBack=tempIBack(:,(j-1)*sliceWide+1:j*sliceWide);
        [r1,~]=find(SliceI==0);
        [r2,~]=find(SliceIBack==0);
        if length(r2)>0 
         sliceDensity(j)=length(r1)/length(r2);
        end
        tmp(j)=length(r2);
    end
    % �ܶ����� ������ԵӰ��
    leftnode=0;
    tmpsum=0;
    for k=1:sliceNum
        if tmpsum>limit*sliceWide
            leftnode=k;
            break;
        end
        tmpsum=tmpsum+tmp(k);
        
    end
    curves{i/step}=sliceDensity;
    varians(i/step)=std(sliceDensity);
end
%figure;
x=[1:length(varians)]*step;

[~, fdegrees]=sort(varians,'descend');
fdegrees=fdegrees(1:4)*step;%
