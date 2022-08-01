# Arch Deployment Scripts

## Wifi

Start iwctl

```sh
#> iwctl
```


List devices

```sh
[iwd]# device list
```


Put device in scanning mode

```sh
[iwd]# station wlan0 scan
```


In scanning mode get networks

```sh
[iwd]# station wlan0 get-networks
```


Connect to network

```sh
[iwd]# station wlan0 connect networkname
```


## Create and format Partitions


```sh
cfdisk /dev/nvme0n1
```



```sh
cryptsetup -y -v luksFormat /dev/nvme0n1p2
```



```sh
cryptsetup open /dev/nvme0n1p2 root
```



```sh
mkfs.fat -F32 /dev/nvme0n1p1
```



```sh
mkfs.ext4 /dev/mapper/root
```


Mount partitions


```sh
mount /dev/mapper/root /mnt
```



```sh
mkdir /mnt/boot
```



```sh
mount /dev/nvme0n1p1 /mnt/boot
```


## Install Arch

Refresh pacman keyring (optional)


```sh
pacman -Sy
```



```sh
pacman -S archlinux-keyring
```



```sh
pacstrap /mnt base base-devel linux linux-firmware vim sudo git networkmanager grub efibootmgr
```


Generate fstab

```sh
genfstab -U /mnt >> /mnt/etc/fstab
```


## Configure Arch

Switch to Arch installation

```sh
arch-chroot /mnt
```


Set  time / locale


```sh
ln -sf /usr/share/zoneinfo/America/Phoenix /etc/localtime
```



```sh
hwclock --systohc
```


uncomment "en_US.UTF-8 UTF-8"


```sh
vim /etc/locale.gen
```



```sh
locale-gen
```



```sh
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
```


Set hostname

```sh
echo 'arch' > /etc/hostname
```


Add to /etc/hosts


```sh
127.0.0.1     localhost
::1           localhost
127.0.1.1     arch.localdomain        arch
```


Set root password


```sh
passwd
```


Create user


```sh
useradd matthew
```



```sh
passwd matthew
```



```sh
mkdir /home/matthew && chown -R matthew:matthew /home/matthew
```


Grant root to user (optional)


```sh
visudo
```



```sh
vim /etc/group
```


Locate “HOOKS” and add “encrypt” between “block” and “filesystems”


```sh
vim /etc/mkinitcpio.conf
```



```sh
mkinitcpio -P
```


## GRUB

Install boot os-prober (optional)


```sh
pacman -S os-prober
```



```sh
vim /etc/default/grub
```


Set GRUB_CMDLINE_LINUX variable (e.g.)


```sh
GRUB_CMDLINE_LINUX=”cryptdevice=/dev/nvme0n1p2:root”
```


For NVIDIA/Intel add “ibt=off" before quiet to disable Indirect Branch Tracking

```sh
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 ibt=off quiet"
```


Uncomment GRUB_DISABLE_OS_PROBER (optional)

Install GRUB

```sh
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
```


Make GRUB config

```sh
grub-mkconfig -o /boot/grub/grub.cfg
```


## Final Config


```sh
systemctl enable NetworkManager
```


Enable multiplib

```sh
vim /etc/pacman.conf
```



```sh
pacman -Sy
```


NVIDIA


```sh
sudo pacman -S nvidia nvidia-utils nvidia-settings lib32-nvidia-utils
```

