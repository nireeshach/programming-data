
# coding: utf-8

# In[6]:


import pymongo
import csv
import pandas as pd
import json

def get_mongo_conn():
   """Gets mongo db connection"""
   MONGO_URI = 'mongodb://saran:Saran1!@ds113736.mlab.com:13736/ingredientmaster'
   client = pymongo.MongoClient(MONGO_URI)
   db = client.get_database('ingredientmaster')
   return db

db = get_mongo_conn()
data = [i['alternatives']db.ingredient.find()
lst=[]
for i in data:
    x = ";".join(i['alternatives'])
    i['alternatives'] = x
    lst.append(i)
    
        
df=pd.DataFrame(lst)
print df
df.to_csv('ingredient.csv', index = False, columns=['alternatives','category','value'])




        
    

    

