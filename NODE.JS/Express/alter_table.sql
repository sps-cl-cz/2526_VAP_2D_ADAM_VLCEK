alter table Users add image nvarchar(100)
constraint DF_Users_Image default 'default-image.png'
with values;