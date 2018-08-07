
# coding: utf-8

# In[30]:


import pymongo
import pandas as pd
from pandas import ExcelFile
import numpy as np

" importing data from excel to mongo db"

def get_mongo_conn():
    """Gets mongo db connection"""
    MONGO_URI = 'mongodb://saran:Saran1!@ds113736.mlab.com:13736/ingredientmaster'
    client = pymongo.MongoClient(MONGO_URI)
    db = client.get_database('ingredientmaster')
    return db

collection_name = 'ingredent_conversion'
db = get_mongo_conn()

xls = pd.ExcelFile('Ingredient Conversions Modified.xlsx')

data = []
for sheet_name in xls.sheet_names:
    
    df = xls.parse(sheet_name) 
    
    df = df.replace(np.NaN, '', regex=True) 
    df['cup per unit'] = df['cup per unit'].astype("str")
    df['cup per unit'] = df['cup per unit'].apply(lambda x: round(float(x), 3) if x else 0)
    df[['ingredient','prep', 'size', 'form']] = df[['ingredient','prep', 'size', 'form']].apply(lambda x: x.str.lower())
    
    l = {}
    for i,row in df.iterrows():        
        #d1 = row.to_dict()
        d = l.setdefault(row['ingredient'],{})
        p = d.setdefault(row['prep'],{})
        p.setdefault(row['size'],[]).append(row['cup per unit'])
        p['form'] = row['form']
        p['category'] = sheet_name
    
    for ingredient, ing_dict in l.items():
        for prep, prep_dict in ing_dict.items():
            category = prep_dict.pop('category')
            form = prep_dict.pop('form')
            for size, counts in prep_dict.items():
                cup_per_unit = round(np.mean(counts),3)
                record = {
                        'ingredient': ingredient,
                        'category': category,
                        'form': form,
                        'preparation': prep,
                        'size': size,
                        'cup_per_unit': cup_per_unit
                    }
                data.append(record)
print data[:10]
df = pd.DataFrame(data, columns=['ingredient','preparation','size','form','category','cup_per_unit'])
print(len(df))
df.to_csv('ingredient_conversion.csv', index = False, encoding='utf-8')

# del_many_count = db['ingredent_conversion'].delete_many({}).deleted_count
# ins_many_count = len(db['ingredent_conversion'].insert_many(data).inserted_ids)
# msg = "Collection: {}, Deleted Records: {}, Uploaded Records: {}\n"
# print msg.format(collection_name, del_many_count, ins_many_count)

        

    
        




# In[ ]:


l = {}
d = l.setdefault('asparagus', {})
p = d.setdefault('chopped', {})
p.setdefault('medium', []).append(0.1111)


# In[ ]:


d = l.setdefault('asparagus', {})
p = d.setdefault('chopped', {})
p.setdefault('medium', []).append(0.1250)


# In[ ]:


d = l.setdefault('asparagus', {})
p = d.setdefault('trimmed', {})
p.setdefault('medium', []).append(0.1579)


# In[ ]:


d = l.setdefault('asparagus', {})
p = d.setdefault('sliced', {})
p.setdefault('small', []).append(0.1579)


# In[ ]:


l

