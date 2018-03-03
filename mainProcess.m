clc
clear;
warning('off');
%% ��һ�� ͼƬԤ����
I=cell(1,2);
I{1} = imread('realTraceMap.bmp');
I{2} = imread('simulatedTraceMap1.bmp');
%figure;
figure('Name','Real Trace Map');
imshow(I{1});
%figure;
figure('Name','Simulated Trace Map');
imshow(I{2});
totalgray_a=totalgray(I{1},'r');
totalgray_b=totalgray(I{2},'b');
yita_totalgray=1-dist(totalgray_a,totalgray_b)/totalgray_a  % �Ҷ���صİٷֱ�

%% ������ ����Ҷȼ�������
netWide=size(I{1},2)/16;
netHeight=size(I{1},1)/16;

[grade_a,totalNetValue_a]=grayGrade(I{1},netWide,netHeight);
[grade_b,totalNetValue_b]=grayGrade(I{2},netWide,netHeight);

x=1:length(grade_a);


figure('Name','Gray Grade Curve');
plot(x,grade_a,'r--');
hold on;
plot(x,grade_b,'b');
set(gca,'ylim',[0 1]);
set(gca,'yticklabel',{'0%','10%', '20%', '30%', '40%' ,'50%','60%','70%','80%','90%','100%'});
Mhtdist=zeros(1,length(grade_a)); %���� �����پ���
for i=1:length(grade_a)
    Mhtdist(i)=dist(grade_a(i),grade_b(i));
end
stem(1:length(grade_a),Mhtdist,'Marker','none');
xlabel('screen');
ylabel('proportion');
legend('gray grade curve of real trace map','gray grade curve of simulation trace map', 'Location','Best');
%yita_grade=pdist2(grade_a,grade_b,'cityblock')/length(grade_a);
yita_graygrade=riter(Mhtdist)

%% ���Ĳ� �԰��������ֵķ�ʽ�� Radon�任 �Ľ��������������򡢷������
[varians_a,curves_a,fdegrees_a]=radonTrs(I{1});
[varians_b,curves_b,fdegrees_b]=radonTrs(I{2});
% �ܶ����߷���ıȽ���״ͼ
M=zeros(length(curves_a),141);   % �������任 ��ͼ
for i=1:length(curves_a)
    M(i,1:length(curves_a{i}))=curves_a{i};
end 

figure('Name','Characteristic Directions');
x=(1:length(varians_a))*1;
h=bar(x,[varians_a' varians_b']);
xlabel('\theta');
ylabel('variance');
legend('real trace map','simulation trace map','Location','Best');
set(gca,'xticklabel',{'15','30', '45', '60' ,'75','90','105' ,'120', '135','150','165','180'});


yita_direction=yitaDirection(fdegrees_a,fdegrees_b)
%% ���岽 �� �������������ƶ� �������������������ƥ������ͼ��
fIndex=round(fdegrees_a/15); 
% figure;

for i=1:4
    result(i)=cosSimu(curves_a{fIndex(i)},curves_b{fIndex(i)});
    x=1:length(curves_a{fIndex(i)});
%     plot(x,curves_a{fIndex(i)}+i-0.94,'r');
%     hold on;
%     plot(x,curves_b{fIndex(i)}+i-0.94,'b');
%     hold on
end
yita_loopcosSimu=mean(result)
% 
% xlabel('Cross section');
% legend('Gray Density Distribution Curve (Real Trace Map)',...
%     'Gray Density Distribution Curve (Simulated Trace Map)', 'Location','Best');
% set(gca,'ylim',[-0.1,4]);
% 
% set(gca,'yticklabel',{strcat('\theta=',num2str(fdegrees_a(1)),',0.0'),'0.5',...
%     strcat('\theta=',num2str(fdegrees_a(2)),',0.0'),'0.5',...
%     strcat('\theta=',num2str(fdegrees_a(3)),',0.0'),'0.5',...
%     strcat('\theta=',num2str(fdegrees_a(4)),',0.0'),'0.5',' '});
% axes;
% 
% reresult=0.99-result;
% bh=barh(0:3,[result',reresult'],'stack','BarWidth',0.05,'LineStyle','none');%'FaceColor',[0.423,0.251,0.392],
% set(bh(1),'facecolor',[0.635294117647059,0.0784313725490196,0.184313725490196]);
% set(bh(2),'facecolor',[0.854901960784314,0.701960784313725,1]);
% set(gca,'xaxislocation','top','color','none');
% set(gca,'ylim',[-0.1 4],'xlim',[0,1],'XTick',0:0.2:1,'ytick',[]);
% ylabel('Gray Density');
% xlabel('Loop Cosine Similarity');
% legend('Loop Cosine Similarity');
%% �ۺ����ƶ�
comprehensive_Similarity=0.2*(yita_totalgray+yita_graygrade)+0.3*(yita_loopcosSimu+yita_direction)


