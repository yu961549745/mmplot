function s = str_decode(s)
s=char(java.net.URLDecoder.decode(s,'UTF8'));
end