{ ... }: {
  imports = [

  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  
  services.qemuGuest.enable = true;
}