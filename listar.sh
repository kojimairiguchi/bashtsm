#!/bin/bash

######## Listado de sesiones para eliminar ##########
##                                                     ##
##      Autor : Nicolas Martinez &  Salvador Maureira  ##
##                                                 ##
#####################################################


## DECLARACION DE VARIABLES
USUARIO="" ##Agregar Usuario
SALIDA="salida.log"
SCRIPT="select 'CANCEL SESS', session_id from SESSIONS where client_name='$USUARIO';"
CUENTA="" ##credenciales TSM
PASSWORD="" ##credenciales TSM
LIMPIO="out.log"
NEW_LIMPIO="limpio.log"



## VACIAR DOCUMENTOS
cat /dev/null > $SALIDA
cat /dev/null > $LIMPIO
cat /dev/null > $NEW_LIMPIO

## LISTAR SESIONES ACTIVAS
dsmadmc -id=$CUENTA -password=$PASSWORD -outfile=$SALIDA -quiet $SCRIPT >/dev/null

## CREA LISTADO PARA CANCELAR SESIONES

egrep -i "CANCEL SESS" $SALIDA>> $LIMPIO
sed '1d' $LIMPIO >> $NEW_LIMPIO

## CERRAR SESIONES
while read LINEA
do
  dsmadmc -id=$CUENTA -password=$PASSWORD -quiet $LINEA >/dev/null
done < $NEW_LIMPIO

## ENVIO CORREO DE AVISO
CORREO="/tmp/correotmp"
DESTINO="correos separados por coma"
SERVER="" ##nombre del equipo que ejecuta
ASUNTO="Sesiones Eliminadas en TSM"
LINEAS=$(wc -l $NEW_LIMPIO | cut -f1 -d' ')


echo "From: $SERVER" >> $CORREO
echo "To: $DESTINO" >> $CORREO
echo "Subject: $ASUNTO" >> $CORREO
echo "" >> $CORREO
echo "Se han eliminado $LINEAS registros de sesiones activas de la cuenta $USUARIO" >> $CORREO
echo "" >> $CORREO
echo "Atte:" >> $CORREO
echo "" >> $CORREO ##agregar una firma


cat $CORREO | /usr/sbin/sendmail -t
rm $CORREO

##FIN
