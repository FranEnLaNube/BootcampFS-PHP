// Creando Base de datos "CuloEBotella"
USE CuloEBotella;
// Creando colección "gafas"
db.createCollection("gafas");
// Cargando documentos en "gafas"
db.gafas.insertMany(
  [{
    "_id": {
      "$oid": "64898d27a0b94a334e1249b2"
    },
    "graduaciónIzquierda": "+1.5",
    "graduaciónDerecha": "-2.0",
    "tipoMontura": "flotante",
    "colorMontura": "Negro",
    "colorVidrioIzquierdo": "Gris",
    "colorVidrioDerecho": "Gris",
    "precio": 99.99,
    "marca": "Marca 1",
    "_idProveedor": {
      "$oid": "64898f5ca0b94a334e1249b5"
    }
  },
  {
    "_id": {
      "$oid": "648a125180f687c89a36ffe2"
    },
    "graduaciónIzquierda": "+2.5",
    "graduaciónDerecha": "-2.5",
    "tipoMontura": "Metalica",
    "colorMontura": "Azul",
    "colorVidrioIzquierdo": "Marron",
    "colorVidrioDerecho": "Marron",
    "precio": 9.99,
    "marca": "Marca 2",
    "_idProveedor": {
      "$oid": "648a11c29ac934ade78891f3"
    }
  }]);

// Crear coleccion "clientes"
db.createCollection("clientes");

//Cargar documentos en "clientes"
db.clientes.insertMany([{
  "_id": {
    "$oid": "648991eda0b94a334e1249bc"
  },
  "nombre": "Nombre1",
  "direccion": {
    "calle": "Calle A",
    "número": 321,
    "piso": "Principal",
    "puerta": 4,
    "ciudad": "String",
    "codigo postal": "08045",
    "país": "País Super"
  },
  "telefono": "632323232",
  "e-mail": "hola@correo.com",
  "fechaRegistro": "2000-12-10",
  "_idClienteReferido": {
    "$oid": "648991eda0b94a334e1249bc"
  }
},
{
  "_id": {
    "$oid": "648a0c599ac934ade78891f1"
  },
  "nombre": "Nombre2",
  "direccion": {
    "calle": "Calle B",
    "número": 322,
    "piso": "1",
    "puerta": 3,
    "ciudad": "Barcelona",
    "codigo postal": "08025",
    "país": "País Mejor"
  },
  "telefono": "632323233",
  "e-mail": "chau@correo.com",
  "fechaRegistro": {
    "$date": "2000-12-10T00:00:00.000Z"
  },
  "_idClienteReferido": {
    "$oid": "648991eda0b94a334e1249bc"
  }
}]);

//Crear colección "ventas"
db.createCollection("ventas");

//Cargar datos en "ventas"
db.ventas.insertMany([{
  "_id": {
    "$oid": "648997a7a0b94a334e1249d4"
  },
  "_idCliente": {
    "$oid": "648991eda0b94a334e1249bc"
  },
  "_idGafa": {
    "$oid": "64898d27a0b94a334e1249b2"
  },
  "_idProveedor": {
    "$oid": "64898f5ca0b94a334e1249b5"
  },
  "vendedor": "Vendedor1",
  "fechaVenta": "2000-11-10"
},
{
  "_id": {
    "$oid": "648a12da80f687c89a36ffe9"
  },
  "_idCliente": {
    "$oid": "648a0c599ac934ade78891f1"
  },
  "_idGafa": {
    "$oid": "648a125180f687c89a36ffe2"
  },
  "_idProveedor": {
    "$oid": "648a11c29ac934ade78891f3"
  },
  "vendedor": "Vendedor2",
  "fechaVenta": "2001-11-10"
}]);