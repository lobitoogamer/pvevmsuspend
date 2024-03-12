#!/bin/bash

# Ruta del archivo
archivo="/root/vpsexpire.txt"

# Función para suspender la VM y actualizar los permisos
suspender_vm() {
    id_vm="$1"
    usuario="$2@pve"  # Agregar sufijo "@pve" al nombre de usuario
    
    echo "Suspender la VM $id_vm para el usuario $usuario"
    # Deshabilitar arranque automático
    qm set "$id_vm" --onboot 0

    # Hibernar VM
    qm suspend "$id_vm" --todisk 1

    # Eliminar los permisos del usuario en la máquina virtual
    pveum acldel "/vms/$id_vm" -user "$usuario" -role user
    
    # Modificar el rol del usuario a "suspended"
    pveum acl modify "/vms/999999" -user "$usuario" -role suspended
}

# Función para restaurar los permisos de la VM y iniciarla
restaurar_vm() {
    id_vm="$1"
    usuario="$2@pve"  # Agregar sufijo "@pve" al nombre de usuario
    
    echo "Restaurar y iniciar la VM $id_vm para el usuario $usuario"
    # Restaurar los permisos del usuario en la máquina virtual
    pveum acldel "/vms/999999" -user "$usuario" -role suspended
    pveum acl modify "/vms/$id_vm" -user "$usuario" -role user
    
    # Habilitar el arranque automático
    qm set "$id_vm" --onboot 1
    
    # Iniciar la máquina virtual
    qm start "$id_vm"
}

while true; do
    # Leer el archivo línea por línea
    while IFS= read -r linea || [[ -n "$linea" ]]; do
        # Si la línea ya ha sido procesada, ignorarla
        if [[ $linea == "#"* ]]; then
            continue
        fi
        
        # Dividir la línea en campos utilizando ":" como delimitador
        IFS=':' read -r -a campos <<< "$linea"

        # Obtener la fecha y hora del archivo en el formato día, mes, año, hora, minuto y segundo
        fecha_archivo="${campos[1]}:${campos[2]}:${campos[3]} ${campos[4]}:${campos[5]}:${campos[6]}"

        # Verificar si la fecha y hora del archivo coinciden con la fecha y hora actuales
        if [ "$(date +'%d:%m:%Y %H:%M:%S')" = "$fecha_archivo" ]; then
            # Ejecutar los comandos correspondientes
            id_vm="${campos[0]}"
            usuario="${campos[7]}"
            
            # Suspender la VM
            suspender_vm "$id_vm" "$usuario"
            
            # Marcar la línea como procesada
            sed -i "s/^$linea/#$linea/" "$archivo"
        fi
    done < "$archivo"
    
    # Leer la entrada de la consola
    read -r -t 1 comando restante
    if [ "$comando" = "restore" ]; then
        read -r -t 1 id_vm usuarios
        restaurar_vm "$id_vm" "$usuarios"
    elif [ "$comando" = "now" ]; then
        read -r -t 1 id_vm usuarios
        suspender_vm "$id_vm" "$usuarios"
    fi
done
