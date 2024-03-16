#!/bin/bash
DIR_VAGRANT=$HOME/src/vagrant


title () {
    echo "   _____                 ____                __   ____      "
    echo "  / ___/____  ___  ___  / / /_  ____  ____  / /__( __ )_____"
    echo "  \__ \/ __ \/ _ \/ _ \/ / __ \/ __ \/ __ \/ //_/ __  / ___/"
    echo " ___/ / /_/ /  __/  __/ / /_/ / /_/ / /_/ / ,< / /_/ (__  ) "
    echo "/____/ .___/\___/\___/_/_.___/\____/\____/_/|_|\____/____/  "
    echo "    /_/                                                     "

    echo "" 
    #echo -e "\n \e[1;31m  $mensaje  \e[0m \n"
    echo -e "\e[0;32m $mensaje \e[0m"
}

menu () { 
    
    echo "1. Menu K8S"
    echo "2. Admin APPs"
    echo "99. Salir"
    echo ""
    echo "Indica la opcion que deseas realizar: "
    read n

    case $n in

        1)  
            clear
            title
            menuK8S
            ;;
        2) 
            clear
            title
            menuApp
            ;;
        99) exit ;;

        *)
            clear
            title
            mensaje="\n \e[1;31m  Selecciona la opcion correcta  \e[0m \n"
            menu
            ;;
    esac
}


menuK8S(){
    echo ""
    echo "Status Clusters"
    echo "-------------------"
    statusCluster
    echo "-------------------"
    echo ""
    echo "1. Crear cluster k8s"
    echo "2. Arrancar cluster k8s"
    echo "3. Parar cluster k8s"
    echo "4. Eliminar cluster k8s"
    echo "99. Atras"
    echo ""
    echo "Indica la opcion que deseas realizar: "
    read n

    case $n in
        
        1)  
            clear
            title
            createCluster
            ;;
        2)  
            clear
            title
            upCluster
            ;;
        3)  
            clear
            title    
            haltCluster
            ;;
        4)  
            clear
            title
            deleteCluster
            ;;
        99) 
            clear
            title
            menu 
            ;;
        *)
            clear
            title
            mensaje="\n \e[1;31m  Selecciona la opcion correcta  \e[0m \n"
            menuK8S
            ;;
    esac

}

statusCluster(){
    
    if [[ -d $DIR_VAGRANT ]]
    then 
        for cluster in `ls $DIR_VAGRANT | cut -d "-" -f 4`
        do 
            status=`vboxmanage list runningvms | cut -d "-" -f4 | cut -d "_" -f1 | sort -u`
            if [[ $status != $cluster ]]; 
            then
                echo -e "Cluster $cluster \e[1;31m Down \e[0m"
            else 
                echo -e "Cluster $cluster \e[1;32m Up \e[0m "
            fi
        done
    else
        echo -e "\e[1;31m No existe el fichero o el directorio definido en DIR_VAGRANT\e[0m"
    fi
   

}

listCluster (){
    i=0
    for cluster in `ls $DIR_VAGRANT | cut -d "-" -f 4`
    do 
        let "i=i+1"
        echo "$i) $cluster"
        nombreCluster[$i]=$cluster
    done 

}
createCluster (){
    echo "Indica el nombre del Cluster para crear"
    read nombre
    echo "Indica la ip por la que empieza el cluster"
    read ip
    cd $DIR_VAGRANT
    git clone https://github.com/b14nc0/vagrant-kubeadm-kubernetes-template.git
    mv $DIR_VAGRANT/vagrant-kubeadm-kubernetes-template $DIR_VAGRANT/vagrant-kubeadm-kubernetes-$nombre 
    cd $DIR_VAGRANT/vagrant-kubeadm-kubernetes-$nombre
    oldIP=`cat settings.yaml  | grep control_ip`    
    echo `sed -i -e 's/'"$oldIP"'/  control_ip: '"$ip"'/g' settings.yaml`
    net=`echo $ip | awk -F '.' '{ print $1"."$2"."$3;}'` #coger los 3 primeros octetos de la ip
    interface=`ip a | grep $net | awk '{print $9}'`
    echo `sed -i -e 's/enp2s0/'"$interface"'/g' Vagrantfile`
    vagrant up
    vagrant ssh node01 -c "cat .kube/config" >> ~/.kube/$nombre
    main
}

haltCluster (){
    echo "Listado de cluster"
    listCluster
    echo "Indica el del Cluster que quieres parar"
    read id
    cd $DIR_VAGRANT/vagrant-kubeadm-kubernetes-${nombreCluster[$id]}
    vagrant halt
    main
}

upCluster (){
    echo "Listado de cluster"
    listCluster
    echo "Indica el nombre del Cluster que quieres arrancar"
    read id
    cd $DIR_VAGRANT/vagrant-kubeadm-kubernetes-${nombreCluster[$id]}
    vagrant up
    mensaje="Se ha levantado el cluster ${nombreCluster[$id]}"
    main
}

deleteCluster (){
    echo "Listado de cluster"
    listCluster
    echo "Indica el nombre del Cluster que quieres eliminar"
    read id
    cd $DIR_VAGRANT/vagrant-kubeadm-kubernetes-${nombreCluster[$id]}
    vagrant destroy -f
    cd ..
    rm -rf $DIR_VAGRANT/vagrant-kubeadm-kubernetes-${nombreCluster[$id]}
    clear
    title
    echo -e "\n"
    menuK8S
}

menuApp (){
    echo -e "\n \e[1;31m  Menu apps en construccion  \e[0m \n"
    menu
}

main() {

    clear
    title
    echo -e "\n"
    menu

}

########################## Main
main