clc,clear,close all;

plot3dm(str_encode('x*y+sin(x/(y+1))'),{0,1,100},{0,1,100},...
    [-inf,inf,-inf,inf,-inf,inf],...
    str_encode('a'),...
    cellfun(@(s){str_encode(s)},{'x','y','\omega'}),...
    str_encode(''),...
    str_encode('imgs/001'));