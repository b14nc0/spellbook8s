# spellbook8s
Creación de cluster k8s con VirtualBox+Vagrant
Proyecto para la automatización de despliegue de cluster de k8s en local

Menu 
1 Menu k8s
2 Admin Apps


-- Menuk8s
1 Creacion cluster
- Datos necesarios:
    * nombre del cluster
    * ip del rango de nuestra red para la creacion de los nodos
- Funcionamiento:
    Hace un gitclone de una plantilla de vagrant con la configuracion para la instalacion de un cluster de k8s con 3 nodos (1 master 2 workers)
    La ip que le indicamos sera la primera que asignara al nodo master siendo consecutivas la de los nodos worker.
    Una vez haya terminado de desplegar nos copiara el kubeconfig a la carpeta /home/user/.kube/ con el nombre del cluster que hayamos generado
2 Arrancar cluster
3 Para Cluster
4 Eliminar Cluster
