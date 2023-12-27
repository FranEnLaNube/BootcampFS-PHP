# Resumen de las tablas creadas:

**addresses:** Almacena información sobre direcciones(dirección, código postal, ciudad y provincia.)

**branches:** Representa las sucursales, con una relación de uno a uno con la tabla addresses mediante la columna AddressId.

**persons:** Utilizada para almacenar información de personas, como el NIF, nombre, apellido y teléfono. Esta tabla es utilizada tanto para clientes como empleados.

**clients:** Almacena información específica de los clientes, como el NIF y la relación con la tabla addresses a través de la columna AddressId.

**employees:** Almacena información de los empleados, con una relación de uno a uno con la tabla persons mediante la columna NIF. También se vincula a la tabla branches mediante la columna BranchId.

**orders:** Representa las órdenes realizadas, con información como la fecha y hora de la orden, si es para entrega a domicilio, el cliente y la sucursal.

**orderDetails:** orderDetails: Contiene los detalles de los productos incluidos en cada orden, como la cantidad. Se vincula a las tablas products y orders mediante las columnas ProductsId y OrderId respectivamente.

**deliveries:** Para el seguimiento de las entregas a domicilio. Se vincula con la tabla orders mediante la columna OrderId para identificar a qué orden corresponde cada entrega. También se vincula a la tabla employees mediante la columna EmployeeId para registrar al empleado encargado de la entrega.

**products:** Almacena información sobre los productos, como el nombre, descripción, imagen, precio y tipo (pizza, burger, drink).

**productsCategories:** Esta tabla establece la relación entre los productos y las categorías, en este caso, entre los productos y las categorías de pizzas.

**categories:** Utilizada para categorizar los productos, en este ejercicio particularmente para las categorías de pizzas. Cada pizza puede pertenecer a una categoría y una categoría puede tener varias pizzas.