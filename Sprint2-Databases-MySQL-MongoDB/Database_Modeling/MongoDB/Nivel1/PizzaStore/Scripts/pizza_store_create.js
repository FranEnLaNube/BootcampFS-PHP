// Create data base "pizza_store"
USE pizza_store;

// Create collection "stores"
db.createCollection("stores");

// Load documents in "stores"
db.stores.insertOne(
    [{
        "_id": {
            "$oid": "64db9d66b65156bd1cacf272"
        },
        "address": "address_store_1",
        "city": "city_store_1",
        "province": "province_store_1",
        "zip": "zip_store_1"
    }]);

// Create collection "orders"
db.createCollection("orders");
// Load documents in "orders"
db.orders.insertMany(
    [{
        "_id": {
            "$oid": "64db962db65156bd1cacf26d"
        },
        "client": {
            "name": "client_1",
            "last_name": "last_name1",
            "address": "address_client_1",
            "zip": "zip_client_1",
            "city": "city_client_1",
            "province": "province_client_1",
            "phone": 555555550
        },
        "products": [
            {
                "quantity": 1,
                "product_id": "64db93cab65156bd1cacf267"
            },
            {
                "quantity": 2,
                "product_id": "64db9543b65156bd1cacf269"
            },
            {
                "quantity": 3,
                "product_id": "64db9e12b65156bd1cacf276"
            }
        ],
        "delivery_details": {
            "caddy_id": "64dba0a6b65156bd1cacf280",
            "delivery_time": "2023-08-15T12:00:00Z"
        },
        "store_id": "64db9d66b65156bd1cacf272",
        "order_date": "2023-08-15T10:00:00Z"
    },
    {
        "_id": {
            "$oid": "64dba05db65156bd1cacf27e"
        },
        "client": {
            "name": "client_1",
            "last_name": "last_name1",
            "address": "address_client_1",
            "zip": "zip_client_1",
            "city": "city_client_1",
            "province": "province_client_1",
            "phone": 555555550
        },
        "products": {
            "quantity": 3,
            "product_id": "64db9e12b65156bd1cacf276"
        },
        "store_id": "64db9d66b65156bd1cacf272",
        "order_date": "2023-08-15T08:00:00Z"
    }]);

// Create collection "products"
db.createCollection("products");

// Load documents in "products"
db.products.insertMany(
    [{
        "_id": {
            "$oid": "64db9543b65156bd1cacf269"
        },
        "name": "product_2",
        "type": "burger",
        "description": "Description_2",
        "image": "URL_2",
        "price": 2.5
    },
    {
        "_id": {
            "$oid": "64db93cab65156bd1cacf267"
        },
        "name": "product_1",
        "type": "pizza",
        "description": "description_1",
        "image": "URL_1",
        "price": 1.5,
        "pizza_category": {
            "category_id": "pizza_category_id",
            "name": "pizza_category_name"
        }
    },
    {
        "_id": {
            "$oid": "64db9e12b65156bd1cacf276"
        },
        "name": "product_3",
        "type": "drink",
        "description": "Description_3",
        "image": "URL_3",
        "price": 3.5
    }]);

// Create collection "employees"
db.createCollection("employees");

// Load documents in "employees"
db.employees.insertMany(
    [{
        "_id": {
            "$oid": "64db9ca2b65156bd1cacf270"
        },
        "store_id": "64db9d66b65156bd1cacf272",
        "position": "cook",
        "name": "name_emp_1",
        "last_name": "last_name_emp_1",
        "NIF": "nif_emp_1",
        "phone": "phone_emp_1"
    },
    {
        "_id": {
            "$oid": "64dba0a6b65156bd1cacf280"
        },
        "store_id": "64db9d66b65156bd1cacf272",
        "position": "caddy",
        "name": "name_emp_2",
        "last_name": "last_name_emp_2",
        "NIF": "nif_emp_2",
        "phone": "phone_emp_2"
    }]);