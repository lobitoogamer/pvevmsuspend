# Proxmox Suspend System (BASH)
- This Script is designed for Proxmox 8.1 with Debian 12
- This Script was created for little hosting
- This guide have a [Spanish (🇪🇸)](https://github.com/lobitoogamer/pvevmsuspend?tab=readme-ov-file#preparaci%C3%B3n-e-instalaci%C3%B3n-) part and [English (🇺🇸)](https://github.com/lobitoogamer/pvevmsuspend?tab=readme-ov-file#preparation-and-installation-) Part

## Preparation and Installation (🇺🇸)

- Have a VM with ID "`999999`", which will be the one the user sees when their VM is suspended.
- Create a ".txt" file specified in the script, where the format will be: "`(vm id to suspend):(day of suspension):(month):(year):(hour):(minute):(second):(owner (this will be specified later))`"
- Have a user assigned as the "Owner" of the VM.

**Git:**
```bash
git clone https://github.com/lobitoogamer/pvevmsuspend
```

## Commands (🇺🇸)
- The script has two commands

now:
- This command is used to suspend a VM instantly.
```bash
now (vm id) (owner)
```

restore:
- This command is used to restore a VM.
```bash
restore (vm id) (owner)
```

## Owner (🇺🇸)
- This is a concept used in several parts of the guide; it refers to adding a user in the "Permissions" section of Proxmox. ↓![](https://i.imgur.com/ni0Kjju.png)↓
  ![](https://i.imgur.com/1smLNVe.png)
## Examples (🇺🇸)
If I want to suspend VM 106 on the 19th of April 2024 with owner "Jhon@pve", the suspension file should contain:
```
106:19:04:2024:00:00:00:Jhon
```

## Preparación e Instalación (🇪🇸)

- Tener una VM con ID "`999999`", la cuál va a ser la que el usuario visualice cuando se suspenda su VM
- Crear un archivo ".txt" que se especificará en el script, en el cuál el formato será: "`(id vm a suspender):(día de la suspensión):(mes):(año):(hora):(minuto):(segundo):(dueño (más adelante se especificará esto))`"
- Tener a un usuario asignado como "Propietario" de la VM

**Git:**
```bash
git clone https://github.com/lobitoogamer/pvevmsuspend
```

## Comandos (🇪🇸)
- El script cuenta con dos comandos

now:
- Este comando sirve para suspender una VM en el momento
```bash
now (id vm) (dueño)
```

restore:
- Este comando sirve para restaurar una VM
```bash
restore (id vm) (dueño)
```
## Dueño (🇪🇸)
- Este es un concepto que uso en varias partes de la guía, con esto me refiero a añadir a un usuario en la sección "Permisos" de Proxmox. ↓![](https://i.imgur.com/ni0Kjju.png)↓
  ![](https://i.imgur.com/1smLNVe.png)
## Ejemplos (🇪🇸)
Si quiero suspender la VM 106 el día 19/04/2024 con propietario "Jhon@pve", en el archivo de suspensión deberá de poner:
```
106:19:04:2024:00:00:00:Jhon
```
