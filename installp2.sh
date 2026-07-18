#!/bin/sh
ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime #i ,, dont know
hwclock --systohc

echo ""
echo "ok now i need you again. uncomment the langs you need at minimum en_US.UTF-8. press enter when ready"
read nothing
nano /etc/locale.gen
locale-gen
touch /etc/locale.conf
echo "LANG=en_US.UTF-8" > /etc/locale.conf
touch /etc/hostname
echo "OK now time for your epic hostname. this is what the network manager will see. impress them."
read hostname
echo $hostname > /etc/hostname
touch /etc/hosts
echo -e "127.0.0.1 localhost\n
::1 localhost\n
127.0.1.1 $hostname" > /etc/hosts
echo "ok root password time!"
passwd
echo "what do you want your username to be?"
read user
useradd -mG wheel $user
echo "ok $user password time!"
passwd $
echo ""
echo -e "I know its been fun and games up until here but this part is important. \n find the line \n uncomment to let members of group wheel execute any command \n This is required for sudo to work."
read nothing
EDITOR=nano visudo
wget https://raw.githubusercontent.com/AbomiNathan96/Larplinux-RELARPED-/refs/heads/main/grub
mv ./grub /etc/default
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB  
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager
timedatectl set-ntp true
wget https://github.com/AbomiNathan96/Larplinux-RELARPED-/raw/refs/heads/main/mkinitcpio.conf
mv ./mkinitcpio.conf /etc
mkinitcpio -p linux

#exit#exit the chroot
#umount -R /mnt
