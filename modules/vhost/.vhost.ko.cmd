cmd_/home/jy-os/netap/modules/vhost/vhost.ko := ld -r -m elf_x86_64  -z max-page-size=0x200000 -T ./scripts/module-common.lds  --build-id  -o /home/jy-os/netap/modules/vhost/vhost.ko /home/jy-os/netap/modules/vhost/vhost.o /home/jy-os/netap/modules/vhost/vhost.mod.o ;  true