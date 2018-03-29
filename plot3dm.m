function plot3dm(eqstr,xrange,yrange,title_str,labels,extcmd,savefile)

% 字符串以 URL 编码进行传递, 防止产生编码问题
eqstr=str_decode(eqstr);
title_str=str_decode(title_str);
extcmd=str_decode(extcmd);
labels=cellfun(@(s){str_decode(s)},labels);
savefile=str_decode(savefile);

% 乘除和次方改为对应元素的计算,其它函数保持不变
eqstr=strrep(eqstr,'*','.*');
eqstr=strrep(eqstr,'/','./');
eqstr=strrep(eqstr,'^','.^');


% 绘图

[x,y]=meshgrid(linspace(xrange{:}),linspace(yrange{:}));
z=eval(eqstr);

figure;
surf(x,y,z);
xlabel(labels{1});
ylabel(labels{2});
zlabel(labels{3},'rotation',0);
axis tight
title(title_str);

% 执行额外的 Matlab 绘图命令
eval(extcmd);

% 绘图并保存, 同时保存  fig 和 png 格式
drawnow;
[path,~]=fileparts(savefile);
if ~exist(path,'dir')
    mkdir(path);
end
saveas(gcf,[savefile,'.fig']);
saveas(gcf,[savefile,'.png']);
close(gcf);
end
