#!/bin/sh
echo 'welcome larper, to the future of linux (larping)' #Prime the user for larping
timedatectl set-ntp true
fdisk -l | more
echo ""
echo "What drive is yours? (/dev/sdX)"
read DISK
echo "Ok you wrote $DISK but that doesnt seem right to me. your the boss though. nerd. (CTRL+C to exit)" #Put them on edge
read nothing
sfdisk --delete $DISK

DSET="label: dos\n #drive setup that only goes up to 8GB and doesnt know less
label-id: 0x6942067f\n
device: /dev/sda\n
unit: sectors\n
sector-size: 512\n
start=        2048, size=     1048576, type=ef\n
start=     1050624, size=    15724544, type=7" #type 7 lol (ntfs, thanks https://github.com/nikp123/ntfs-rootfs/wiki)

echo -e $DSET > drives #got an error if i didnt do this
sfdisk $DISK < drives
rm drives #cleaning :D

mkfs.fat -F 32 $DISK"1"
mkfs.ntfs --quick --label=betterwindows $DISK"2" #when bro says he likes windows better
mkdir /mnt # just in case
mount $DISK"2" /mnt
mkdir /mnt/home
mkdir /mnt/efi
mount $DISK"1" /mnt/efi

pacstrap -d -K /mnt base ntfs-3g base-devel linux linux-firmware git grub intel-ucode efibootmgr inotify-tools nano vim vi networkmanager reflector
# in classic linux, sound was bad. we are larping old linux sound

genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
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
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB  
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager
timedatectl set-ntp true
#exit#exit the chroot
#umount -R /mnt
