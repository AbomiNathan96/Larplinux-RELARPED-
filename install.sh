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

pacstrap -K /mnt base ntfs-3g base-devel linux linux-firmware git grub intel-ucode efibootmgr inotify-tools nano vim vi networkmanager reflector wget
# in classic linux, sound was bad. we are larping old linux sound

genfstab -U /mnt >> /mnt/etc/fstab
cd /mnt
wget https://raw.githubusercontent.com/AbomiNathan96/Larplinux-RELARPED-/refs/heads/main/installp2.sh
chmod +x installp2.sh
arch-chroot /mnt sh installp2.sh
