
# coding: utf-8

# In[62]:


import csv
import pandas as pd
import numpy as np


s = {}
state_new = []
category_new = []


df = pd.read_csv('ingredientsMaster_state_new.csv', usecols=['Ingredient','category','state'])
df = df.replace(np.nan, '', regex=True) 

for i,row in df.iterrows():
    d = s.setdefault(row['Ingredient'],{})
    d.setdefault('category',[]).append(row['category'])
    d.setdefault('state',[]).append(row['state'])
    

solid_df = pd.read_csv('ingredientsMaster - ingredient.csv')
for i,row in solid_df.iterrows():
    if s.has_key(row['Ingredient']):
        for k,v in s[row['Ingredient']].items():
            
            if k == 'category':
                category_new.append(';'.join(v))
            else:
                state_new.append(';'.join(v))
    else:
        state_new.append('') 
        category_new.append('')
        
solid_df['state_new'] = state_new
solid_df['category_new'] = category_new

solid_df.to_csv('ingredient_state_new.csv',index = False,encoding='utf-8')
                                    


# In[ ]:


l = {'a': 1, 'b': 2}



# In[ ]:


#if l.has_key(row['Ingredient'])
#saa.append(";".join())
#else:
#sas.append('')


# In[53]:


df = pd.read_csv('ingredientsMaster_state.csv', usecols=['Ingredient','category','state'])
df = df.replace(np.nan, '', regex=True)
s={}
for i,row in df.iterrows():
    d = s.setdefault(row['Ingredient'],{})
    d.setdefault('category',[]).append(row['category'])
    d.setdefault('state',[]).append(row['state'])
        

