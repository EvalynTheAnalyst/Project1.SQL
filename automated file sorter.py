#!/usr/bin/env python
# coding: utf-8

# In[55]:


import os,shutil


# In[42]:


path =r'C:/Users/pavilion14/Pictures/'


# In[49]:


file_name= os.listdir(path)


# In[54]:


folder_names= ['csv file','image file','text file']
for loop in range(0,3):
    if not os.path.exists(path + folder_names[loop]):
        #print(path + folder_names[loop])
        os.makedirs(path + folder_names[loop])
        
for file in file_name:
    elif ".csv" in file and not os.path.exists(path + "csv file/" + file):
        #shutil.move(path + file, path + "csv file/" + file)
    elif ".png" in file and not os.path.exists(path + "image file/" + file):
        #shutil.move(path + file, path + "image file/" + file)
    elif".txt" in file and not os.path.exists(path + "text file/" + file):
        shutil.move(path + file, path + " text file/" + file)
    #else:
        #print("There are file in this path that were moved")


# In[ ]:





# In[ ]:





# In[ ]:




