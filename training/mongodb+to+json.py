
# coding: utf-8

# In[1]:


import pymongo
import json

def get_mongo_conn():
   """Gets mongo db connection"""
   MONGO_URI = 'mongodb://saran:Saran1!@ds113736.mlab.com:13736/ingredientmaster'
   client = pymongo.MongoClient(MONGO_URI)
   db = client.get_database('ingredientmaster')
   return db

db = get_mongo_conn()
data = db.ingredient.find()
lst=[]
for i in data:
        lst.append(i)
with open('ingredient2.json','w') as f:
    json.dump(lst, f)   

