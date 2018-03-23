import numpy as np;
import xlrd;
import xlwt;

sheet = xlrd.open_workbook('data1.xls');
workbook = xlwt.Workbook(encoding = 'ascii');
worksheet = workbook.add_sheet('school')
data = sheet.sheets()[0];

row = data.nrows;
col = data.ncols;




for i in range(0,row):
    for j in range(0,col):
        worksheet.write(i, j, label = str(data.cell(i, j).value).split('.')[0] );

workbook.save('/Users/tinoryj/Desktop/ans.xls');
            

        


