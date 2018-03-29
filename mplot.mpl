# 字符串编码
str_encode:=s->sprintf("'%s'",HTTP:-URLEncode(s));

# 文件计数器
FileCounter:=module()
    local k:=0;
    export next_file,curr_file;

    curr_file:=proc()
        return sprintf("imgs/fig%03d",k);
    end proc:

    next_file:=proc()
        k:=k+1;
        return sprintf("imgs/fig%03d",k);
    end proc:
end module:

# 打开 MATLAB 并设置路径
Matlab:-openlink();
Matlab:-evalM(
    sprintf("cd(char(java.net.URLDecoder.decode(%s,'UTF8')))",str_encode(currentdir()))
);

# 处理坐标名称
label_str:=x->str_encode(`if`(type(x,string),x,latex(x,output=string)));

# 3D曲面绘图接口
plot3dm:=proc(eq,{x::range:=0..1,y::range:=0..1,title::string:="",grid::list:=[50,50],labels::list:=[x,y,z],extcmd::string:=""})
    uses ImageTools;
    local plot3d_args;
    plot3d_args:=remove(x->type(x,equation) and lhs(x)=:-extcmd,[_passed]);
    print(old_plot3d(plot3d_args[]));
    Matlab:-evalM(sprintf("plot3dm(%s,{%f,%f,%d},{%f,%f,%d},%s,{%s,%s,%s},%s,%s)",
        str_encode( sprintf("%a",eq) ),
        op(1,x),op(2,x),grid[1],
        op(1,y),op(2,y),grid[2],
        str_encode(title),
        label_str(labels[1]),label_str(labels[2]),label_str(labels[3]),
        str_encode(extcmd),
        str_encode(FileCounter:-next_file())
    ));
    Embed(Read(sprintf("%s.png",FileCounter:-curr_file())));
end proc:

# 重载plot3d函数
old_plot3d:=copy(plot3d,deep);
unprotect(plot3d);
plot3d:=plot3dm;