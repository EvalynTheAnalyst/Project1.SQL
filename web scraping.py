#!/usr/bin/env python
# coding: utf-8

# In[1]:


from bs4 import BeautifulSoup
import requests


# In[3]:


url ='https://en.wikipedia.org/wiki/List_of_largest_companies_by_revenue'


# In[4]:


page = requests.get(url)


# In[5]:


soup = BeautifulSoup(page.text,'html')


# In[14]:


table = soup.find_all('table')[0]
table


# In[13]:


#soup.find('table',class_="wikitable sortable sticky-header-multi sort-under")


# In[72]:


world_titles =table.find_all('th')
world_titles


# In[73]:


world_table_titles= [title.text.strip() for title in world_titles]
world_table_titles


# In[74]:


import pandas as pd


# In[85]:


df =pd.DataFrame(columns = world_table_titles[1:10])
df


# In[50]:


column_data =table.find_all("tr")
column_data


# In[86]:


for row in column_data[2:]:
    row_data = row.find_all('td')
    individual_data = [data.text.strip() for data in row_data]
    #print(individual_data)
    
    length = len(df)
    df.loc[length]= individual_data


# In[87]:


df


# In[89]:


df.to_csv(r'C:\Users\pavilion14\Documents\World_largest_companies.csv')


# In[ ]:





# In[ ]:




