
# coding: utf-8

# In[9]:


import pymongo
import re
import json

def get_mongo_conn():
    """Gets mongo db connection"""
    MONGO_URI = 'mongodb://saran:Saran1!@ds113736.mlab.com:13736/ingredientmaster'
    client = pymongo.MongoClient(MONGO_URI)
    db = client.get_database('ingredientmaster')
    return db


db = get_mongo_conn()

data_ingredient = [" %s " % i['value'] for i in db.ingredient.find({}, {"value": 1, "_id": 0})]
data_form = [i['value'] for i in db.form.find({},{"value":1,"_id":0})]

ingredient_list = {}

match_re = "|".join(data_form)

search_re = re.compile(r'\s({})\s'.format(match_re))

for data in data_ingredient:
    
    d = search_re.findall(data)
        
    if len(d) > 0:
        ingredient_list[data]=d
print ingredient_list
print len(ingredient_list)

with open('forms_check.json','w') as f:
    json.dump(ingredient_list, f)   


    
    
    
        
    
                       
                    
                       
 
    

