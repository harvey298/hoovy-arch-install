#!/bin/sh
pacman -Syyy
cfdisk $1
mkfs.fat -F32 $11
mkfs.ext4 $12
mount $12 /mnt
mkdir /mnt/home
mkdir /mnt/etc
genfstab -U -p /mnt >> /mnt/etc/fstab
pactrap -i /mnt base linux-zen linux-zen-headers linux-firmware plasma plasma-meta networkmanager nano openssh base-devel grub firefox efibootmgr
arch-chroot /mnt systemctl enable NetworkManager;systemctl enable sshd;mkinitcpio -p linux-zen
arch-chroot /mnt passwd
arch-chroot /mnt useradd -m -g users -G wheel $2
arch-chroot /mnt passwd $2
arch-chroot /mnt EDITOR=nano visudo
arch-chroot /mnt mkdir /boot/EFI;mount $11 /boot/EFI;grub-install --target=x86_64-efi --bootloader-id=grub_efi --recheck;grub-mkconfig -o /boot/grub/grub.cfg;mkswap $13
umount -a
echo Done!