
# config/boards/avaota-a1.csc  (mainline U-Boot variant)
# Allwinner Cortex-A55 octa core 2/4GB RAM SoC USB3 USB-C 2x GbE LCD
BOARD_NAME="Avaota A1"
BOARD_VENDOR="allwinner"
BOARDFAMILY="sun55iw3"                 # was sun55iw3-syterkit
BOARD_MAINTAINER=""
INTRODUCED="2024"
BOOTCONFIG="avaota-a1_defconfig"       # upstream U-Boot, needs v2025.10+
OVERLAY_PREFIX="sun55i-t527"
KERNEL_TARGET="edge"                   # mainline kernel, was legacy
BOOT_FDT_FILE="allwinner/sun55i-t527-avaota-a1.dtb"
IMAGE_PARTITION_TABLE="gpt"
BOOTFS_TYPE="fat"
BOOTSTART="1"
BOOTSIZE="256"
ROOTSTART="513"
SRC_CMDLINE="console=ttyAS0,115200 loglevel=8 cma=64M"
BOOT_FDT_FILE="allwinner/sun55i-t527-avaota-a1.dtb"
SRC_EXTLINUX="yes"
SRC_CMDLINE="earlycon=uart8250,mmio32,0x02500000 clk_ignore_unused initcall_debug=0 console=ttyAS0,115200 loglevel=8 cma=64M init=/sbin/init"
BOOTFS_TYPE="fat"
BOOTSIZE="256"
SERIALCON="ttyAS0"
declare -g SYTERKIT_BOARD_ID="avaota-a1" # This _only_ used for syterkit-allwinner extension

function post_family_tweaks__avaota-a1() {
	display_alert "Applying boot blobs"
	cp -v "$SRC/packages/blobs/sunxi/sun55iw3/bl31.bin" "$SDCARD/boot/bl31.bin"
	cp -v "$SRC/packages/blobs/sunxi/sun55iw3/scp.bin" "$SDCARD/boot/scp.bin"
	cp -v "$SRC/packages/blobs/sunxi/sun55iw3/splash.bin" "$SDCARD/boot/splash.bin"

	display_alert "Applying wifi firmware"
	pushd "$SDCARD/lib/firmware"
	ln -s "aic8800/SDIO/aic8800D80" "aic8800d80" # use armbian-firmware
	popd
}
