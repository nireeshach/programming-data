from alchemy import db, DataCatalog

db.create_all()

cfirstname = DataCatalog(
    main_data_source_key="netsuite",
    entity="customers",
    field="first_name",
    normalize_type="varchar",
)
clastorderamount = DataCatalog(
    main_data_source_key="netsuite",
    entity="customers",
    field="lastorderamount",
    normalize_type="varchar",
)

print(cfirstname.id)
print(clastorderamount.id)

db.session.add(cfirstname)
db.session.add(clastorderamount)

print(cfirstname.id)
print(clastorderamount.id)

db.session.commit()
dd = DataCatalog.query.get(1)
import pdb

pdb.set_trace()
