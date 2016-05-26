# ELIMINAR SESIONES TSM

* [Historia](#historia)
* [A considerar](#A considerar)
* [Como usar](#Como Usar)

### Historia
 Hace tiempo con [@Mausarde](https://twitter.com/Mausarde) estuvimos viendo que era demasiado molesto andar eliminando una a una las sesiones que automaticamente un bot de un usuario generaba en TSM manager.  
 Por lo que [@Mausarde](https://twitter.com/Mausarde) diseñó una consulta en la base de datos del servidor para listar las sesiones, a la vez que se pasaba a un excel que formateaba la salida y asi con el uso de ````copy & paste ```` eliminar una a una las molestas sesiones.  
 Asi que un dia decidí automatizar el proceso e instalamos el cliente TSM en un servidor linux que tenemos de pruebas y mediante el administrador de line de comando del cliente se eliminan las sesiones

### A considerar
se debe tener en cuenta una serie de condiciones para ejecutar el bash solicitado
* Tener un servidor TSM y un servidor Linux (yo uso un centos 6.7)
* Tener una cuenta en el servidor de TSM
* Este script utiliza el comando sendmail para enviar las notificiaciones a los usuarios
* revisar parametros que sean coherentes


### Como Usar

Primero se tiene que editar el archivo con los parametros necesarios, modificar los permisos para su ejecucion y ejecutar 
```
chmod +x listar.sh
sh listar.sh
``` 

para facilitar tambien recomiendo crear el cron con la siguiete programacion, solo para ejecutarlo cada dos horas, 

```
0 0,2,4,6,8,10,12,14,16,18,20,22 * * * sh /ruta-del-script/listar.sh 
```

consultas a las siguientes cuentas

+ Salvador Maureira B [@Mausarde](https://twitter.com/Mausarde) Query, sesiones y TSM manager
+ Nicolas Martinez V [@_nmartinezv](https://twitter.com/_nmartinezv) Script, aplicaciones y automatizacion


