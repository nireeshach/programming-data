
# coding: utf-8

# In[14]:


import pymongo
import json
import pandas as pd

def get_master_mongo_conn():
    """Gets mongo db connection to chefd-ingredients-research"""
    MONGO_URI = 'mongodb://saran:Saran1!@ds141165-a0.mlab.com:41165/chefd-ingredients-research'
    client = pymongo.MongoClient(MONGO_URI)
    db = client.get_database("chefd-ingredients-research")
    return db

def get_ing_mongo_conn():
    """Gets mongo db connection to ingredientmaster"""
    MONGO_URI = 'mongodb://saran:Saran1!@ds113736.mlab.com:13736/ingredientmaster'
    client = pymongo.MongoClient(MONGO_URI)
    db = client.get_database("ingredientmaster")
    return db

master_db = get_master_mongo_conn()
ingredient_db = get_ing_mongo_conn()

uom = [i['value'] for i in ingredient_db.unit_of_measure.find()]
print uom

no_uom = []

for receipe in master_db.cleansed_ingredients.find(
    {},
    {'tokenized_ingredients.actual_ingredient': 1,
     '_id': 0, 'tokenized_ingredients.unit_of_measure': 1, 'tokenized_ingredients.tokens':1
    }):
        
    for i in receipe['tokenized_ingredients']:
        if not i['unit_of_measure'] in uom:
            l = {}            
            l['actual_ingredient'] = i['actual_ingredient']
            for j in i['tokens']:
                l.setdefault(j['type'],[]).append(j['standard_token'])
            for k,v in l.iteritems():
                if isinstance(v,list):
                    l[k] = ";".join(v)
            no_uom.append(l)        
                    

# columns = ['actual_ingredient', u'value', u'unit_of_measure', u'ingredient', u'container', u'form', u'preparation', u'size', u'as_needed', u'modified', u'optional', u'part', u'state', u'thickness', u'unit_type', u'unknown']
print len(no_uom)
# #print no_uom
# df = pd.DataFrame(no_uom, columns=columns)
# df.head()
# df.to_csv('no_uom_ingredients.csv', index = False)
with open('no_uom_ingredient.json','w') as f:
    json.dump(no_uom, f)   


  
    
    
    


