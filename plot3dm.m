function plot3dm(eqstr,xrange,yrange,title_str,labels,extcmd,savefile)

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
surf(x,y,z);
xlabel(labels{1});
ylabel(labels{2});
zlabel(labels{3},'rotation',0);
axis tight
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
