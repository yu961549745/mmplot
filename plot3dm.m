function plot3dm(eqstr,xrange,yrange,axis_range,title_str,labels,extcmd,savefile)

% �ַ����� URL ������д���, ��ֹ������������
eqstr=str_decode(eqstr);
title_str=str_decode(title_str);
extcmd=str_decode(extcmd);
labels=cellfun(@(s){str_decode(s)},labels);
savefile=str_decode(savefile);

% �˳��ʹη���Ϊ��ӦԪ�صļ���,�����������ֲ���
eqstr=strrep(eqstr,'*','.*');
eqstr=strrep(eqstr,'/','./');
eqstr=strrep(eqstr,'^','.^');


% ��ͼ

[x,y]=meshgrid(linspace(xrange{:}),linspace(yrange{:}));
z=eval(eqstr);

figure;
h=surf(x,y,x+y);
c=get(h,'CData');
cla;
h=surf(x,y,z);
set(h,'CData',c);
shading interp;

hold on;
xrange{3}=30;
yrange{3}=30;
[x,y]=meshgrid(linspace(xrange{:}),linspace(yrange{:}));
z=eval(eqstr);
h=mesh(x,y,z);
set(h,'EdgeColor','k','FaceAlpha',0);

xlabel(labels{1});
ylabel(labels{2});
zlabel(labels{3},'rotation',0);
axis(axis_range)
title(title_str);


% ִ�ж���� Matlab ��ͼ����
eval(extcmd);

% ��ͼ������, ͬʱ����  fig �� png ��ʽ
drawnow;
[path,~]=fileparts(savefile);
if ~exist(path,'dir')
    mkdir(path);
end
saveas(gcf,[savefile,'.fig']);
saveas(gcf,[savefile,'.png']);
close(gcf);
end
