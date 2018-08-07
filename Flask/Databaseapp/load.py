from main import db, DataCatalog, DataSource

db.create_all()

key1 = DataSource(key="netsuite", name="NetSuite", remarks="Our main source of data")
key2 = DataSource(key="postgres", name="PostgreSQL", remarks="null")


firstname = DataCatalog(
    key="customers.firstname",
    main_data_source_key="netsuit",
    entity="customers",
    field="first_name",
    normalize_type="varchar",
)
lastorderamount = DataCatalog(
    key="customers.lastorderamount",
    main_data_source_key="netsuit",
    entity="customers",
    field="lastorderamount",
    normalize_type="varchar",
)

db.session.add(key1)
db.session.add(key2)
db.session.add(firstname)
db.session.add(lastorderamount)

db.session.commit()

