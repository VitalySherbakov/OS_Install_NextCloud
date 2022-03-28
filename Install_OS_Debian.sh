#!/bin/bash
echo "--------------------Установка NextCloud для Debian v11--------------------"
echo "------------Версия Системы------------"
lsb_release -a
echo "-------------------------------------------"
echo "-------------Сетевое Название--------------"
ls /sys/class/net/
echo "-------------IP Автоматические-------------"
ip addr show
echo "-------------------------------------------"
echo "-------------IP Роутера-------------"
ip route
echo "-------------------------------------------"
#echo "-------------Измените IP Машыны------------"
#echo "Измените allow-hotplug enp0s3 => auto enp0s3"
#echo "Измените iface enp0s3 inet dhcp => iface enp0s3 inet static"
#echo "Следущей Строке Tab отступ"
#echo "Добавляем (IP Машыны) => address 192.168.0.125/24"
#echo "Добавляем Роутер => gateway 192.168.0.1"
#cat /etc/network/interfaces
#nano /etc/network/interfaces
#nano /etc/network/interfaces.d/*
systemctl restart networking.service
echo "-----------Перезагрузка IP Адресов-----------"
echo "-------------------------------------------"

echo "-------------Установка Обновлений------------"
apt update && apt upgrade -y
echo "-------------Конец Установки Обновлений----------------"
echo "-------------------------------------------"

echo "-------------Установка Snapd------------"
apt install snapd
source /etc/profile.d/apps-bin-path.sh
echo "-------------Конец Установки Snapd----------------"
echo "-------------------------------------------"

echo "-------------Установка NextCloud------------"
snap install nextcloud
echo "-------------Конец Установки NextCloud----------------"
echo "-------------------------------------------"

echo "-------------Проверка NextCloud------------"
snap changes nextcloud
echo "-------------------------------------------"

echo "-------------Указать Администратора NextCloud------------"
read -p "Логин Администратора: " ADMINLOGIN;
read -p "Пароль Администратора: " ADMINPASS;
nextcloud.manual-install $ADMINLOGIN $ADMINPASS
echo "-------------Конец Администрирования NextCloud----------------"
echo "-------------------------------------------"

echo "-------------Проверка Доменов NextCloud------------"
nextcloud.occ config:system:get trusted_domains
echo "-------------------------------------------"

echo "-------------Установить Домен NextCloud------------"
read -p "Введите Домен NextCloud: " DOMANMASH;
nextcloud.occ config:system:set trusted_domains 1 --value=$DOMANMASH
nextcloud.occ config:system:get trusted_domains
echo "-------------Домен Установлен NextCloud----------------"
echo "-------------------------------------------"

echo "-------------Установить HTTPS NextCloud------------"
read -p "Установить (self-signed/lets-encrypt): " SELFSELECT;
nextcloud.enable-https $SELFSELECT
echo "-------------HTTPS Установлен NextCloud----------------"
echo "-------------------------------------------"