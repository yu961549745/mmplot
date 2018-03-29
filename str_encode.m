function s = str_encode(s)
s=char(java.net.URLEncoder.encode(s,'UTF8'));
end