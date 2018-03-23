import jieba
import nltk
from nltk.corpus import *
n = 3000;
dir1 = '/Users/tinoryj/Downloads/data/';
dirn = '/Users/tinoryj/Downloads/data0/';
while n > 0:
    str1 = str(n);
    dir2 = dir1 + str1;
    dir3 = dirn + str1;
    f = open(dir2)
    tmp_line = f.read()
    f.close()
    tmp_line_decode = tmp_line.decode('utf-8')
    jieba_cut = jieba.cut(tmp_line_decode)
    ans = '/'.join(jieba_cut)
    ans = ans.encode('utf-8')
    f2 = open(dir3, 'w')
    f2.write(ans)
    f2.close()
    n = n-1;
