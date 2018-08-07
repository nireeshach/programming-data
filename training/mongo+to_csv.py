
# coding: utf-8

# In[13]:


import csv
import json
import pymongo
import json
import pandas as pd

def get_mongo_conn():
   """Gets mongo db connection"""
   MONGO_URI = 'mongodb://saran:Saran1!@ds113736.mlab.com:13736/ingredientmaster'
   client = pymongo.MongoClient(MONGO_URI)
   db = client.get_database('ingredientmaster')
   return db

db = get_mongo_conn()
data = db.ingredient.find()
df=pd.DataFrame(list(data))
df.head()
df.to_csv('Ingredient.csv', index = False,encoding='utf-8')

