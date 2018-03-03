function [grade,totalNetValue]=grayGrade(image,netWide,netHeight)
totalNetValue=zeros(fix(size(image,1)/netHeight),fix(size(image,2)/netWide)); % �������
for i=1:size(image,1)/netHeight
    for j=1:size(image,2)/netWide
        temp_block=image((i-1)*netHeight+1:i*netHeight,(j-1)*netWide+1:j*netWide);
        [r,~]=find(temp_block<200);
        totalNetValue(i,j)=length(r);
    end
end
totalNetValue=sort(totalNetValue(:));
totalNetValue=totalNetValue/(netWide*netHeight);

node=0.15; % �����ڵ㣬�� 0 �� 1 �ֳ� 2 ��Σ�ǰ�ε�ɸ�ױ仯�Ͼ�ϸ
grade=zeros(1,round(node/0.001)); % ȷ����ʼ�ļ���ɸ��
for i=1:round(node/0.001)
    [r,~]=find(totalNetValue<i*0.001);
    grade(i)=length(r);
end
grade=grade/length(totalNetValue);