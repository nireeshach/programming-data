
# coding: utf-8

# In[ ]:


import pymongo
def get_ing_mongo_conn():
    """Gets mongo db connection to ingredientmaster"""
    MONGO_URI = 'mongodb://saran:Saran1!@ds113736.mlab.com:13736/ingredientmaster'
    client = pymongo.MongoClient(MONGO_URI)
    db = client.get_database('ingredientmaster')
    return db
def getcollection_values():
    # Declaring empty dictionries, which will be used later in the code
    ingredient_dict = {}
    alcoholic_beverages = {}
    nonfood_goods = {}
    ingredient_patterns ={}
    ingmaster_values = {}
    prep_dict={}
    db=get_ing_mongo_conn()
    collection_names=db.collection_names()
    ignore_collections = ['system.indexes', 'objectlabs-system', 'length']
    for collection_name in collection_names:
        if collection_name in ignore_collections:
            continue
        data=db[collection_name].find()
        for i in data:
            a=i['value']
            if collection_name=='ingredient':
                ingredient_dict[a]=collection_name
            elif collection_name=='alocoholic_beverages':
                alocoholic_beverages[a]=collection_name
            elif collection_name=='nonfood_goods':
                nonfood_goods[a]=collection_name
            elif collection_name==' ingredient_patterns':
                ingredient_patterns[a] = collection_name
            else:
                ingmaster_values[a] = collection_name
    form_values=[]
    prep_values=[]
    
    for k,v in ingmaster_values.iteritems():
        if v == 'form':
            form_values.append(k)
        if v == 'preparation':
            if 'form' in k:
                prep_values.append(k)
                
    print  form_values
    print  prep_values
    import pdb;pdb.set_trace()
    for i in form_values:
        
        for j in prep_values:
            
            j=j.replace('<form>',i)
            
            prep_dict[j]='preparation'
    print prep_dict
    for i in prep_values:
        del ingmaster_values[i]
    return(alcoholic_beverages,ingredient_dict,nonfood_goods,ingredient_patterns,ingmaster_values)


output=getcollection_values()
print output
        
            
    
            
        
            
            

