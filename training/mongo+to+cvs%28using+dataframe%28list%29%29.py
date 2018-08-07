
# coding: utf-8

# In[17]:


import pymongo
import csv
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

df['alternatives']=df['alternatives'].apply(lambda x: ';'.join(x))
print df.head(20)
df.to_csv('ingredient1.csv', index = False, columns=['alternatives','category','value'])



        
    

    

