#!/bin/bash
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
# DIY扩展二合一了，在此处可以增加插件
# 自行拉取插件之前请SSH连接进入固件配置里面确认过没有你要的插件再单独拉取你需要的插件
# 不要一下就拉取别人一个插件包N多插件的，多了没用，增加编译错误，自己需要的才好

# 后台IP设置
export Ipv4_ipaddr="192.168.2.1"            # 修改openwrt后台地址(填0为关闭)
export Netmask_netm="255.255.255.0"         # IPv4 子网掩码（默认：255.255.255.0）(填0为不作修改)
export Op_name="0"                # 修改主机名称为OpenWrt-123(填0为不作修改)

# 默认主题设置
export Mandatory_theme="argon"              # 将bootstrap替换您需要的主题为必选主题(可自行更改您要的,源码要带此主题就行,填写名称也要写对) (填写主题名称,填0为不作修改)
export Default_theme="argon"                # 多主题时,选择某主题为默认第一主题 (填写主题名称,填0为不作修改)

# 旁路由选项
export Gateway_Settings="0"                 # 旁路由设置 IPv4 网关(填入您的网关IP为启用)(填0为不作修改)
export DNS_Settings="0"                     # 旁路由设置 DNS(填入DNS，多个DNS要用空格分开)(填0为不作修改)
export Broadcast_Ipv4="0"                   # 设置 IPv4 广播(填入您的IP为启用)(填0为不作修改)
export Disable_DHCP="0"                     # 旁路由关闭DHCP功能(1为启用命令,填0为不作修改)
export Disable_Bridge="0"                   # 旁路由去掉桥接模式(1为启用命令,填0为不作修改)
export Create_Ipv6_Lan="0"                  # 爱快+OP双系统时,爱快接管IPV6,在OP创建IPV6的lan口接收IPV6信息(1为启用命令,填0为不作修改)(如果跟Enable_IPV6_function一起开启的话,Create_Ipv6_Lan选项选项会自动关闭关闭)

# IPV6、IPV4 选择
export Enable_IPV6_function="0"             # 编译IPV6固件(1为启用命令,填0为不作修改)
export Enable_IPV4_function="0"             # 编译IPV4固件(1为启用命令,填0为不作修改)(如果跟Enable_IPV6_function一起开启的话,Enable_IPV4_function选项会自动关闭)

# OpenClash
export OpenClash_branch="0"            # OpenClash代码选择分支（master 或 dev）(填0为不需要此插件)
export OpenClash_Core="0"                   # 编译固件增加OpenClash时,把核心下载好,核心为3MB左右大小(1为启用命令,填0为不需要核心)

# 个性签名,默认增加年月日[$(TZ=UTC-8 date "+%Y.%m.%d")]
export Customized_Information="$(TZ=UTC-8 date "+%Y.%m.%d")"  # 个性签名,你想写啥就写啥，(填0为不作修改)

# 更换固件内核
export Replace_Kernel="5.4"                    # 更换内核版本,在对应源码的[target/linux/架构]查看patches-x.x,看看x.x有啥就有啥内核了(填入内核版本号,填0为不作修改)

# K3专用，编译K3的时候只会出K3固件（去掉sed前面的#生效）
sed -i 's|^TARGET_|# TARGET_|g; s|# TARGET_DEVICES += phicomm_k3|TARGET_DEVICES += phicomm_k3|' target/linux/bcm53xx/image/Makefile

# K3屏幕
git clone https://github.com/lwz322/luci-app-k3screenctrl.git package/k3/luci-app-k3screenctrl
rm -rf ./package/lean/k3screenctrl && git clone https://github.com/lwz322/k3screenctrl.git package/k3/k3screenctrl
git clone https://github.com/lwz322/k3screenctrl_build.git package/k3/k3screenctrl_build



# 设置打包固件的机型和内核组合（可用内核是时时变化的,过老的内核就删除的，所以要选择什么内核请看说明）
# 内核，机型，固件rootfs大小填入示例
# export amlogic_model="此内填入可用芯片，或多芯片组合。比如：s905d 或 s905d_s905x2"
# export amlogic_kernel="此内填入内核，或者多内核组合。比如：5.4.233 或 5.4.233_6.1.14"
# export auto_kernel="true" 是否自动检测最新内核来打包（true为是，false为不是，如果不是的话，要填写当前有的准确内核版本）
# 自动检测最新内核,比如您写的是 5.15.25 当前最高版本为 5.15.78 的话就自动打包5.15.78的,不自动检测的话,就打包 5.15.25
# export rootfs_size="填入不低于500的数值，数值越大空间越大，一般960够了"
# 可用芯片：a311d, s922x, s905x3, s905x2, s905l3a, s912, s905d, s905x, s905w, s905
# 对应支持什么机型，请看说明
# 可选内核 （5.4.xx） （5.10.xx） （5.15.xx） （6.1.xx）

#export amlogic_model="s905d"
#export amlogic_kernel="5.10.01_6.1.01"
#export auto_kernel="true"
#export rootfs_size="960"



# 修改插件名字
#sed -i 's/"aMule设置"/"电驴下载"/g' `egrep "aMule设置" -rl ./`
#sed -i 's/"网络存储"/"NAS"/g' `egrep "网络存储" -rl ./`
#sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' `egrep "Turbo ACC 网络加速" -rl ./`
#sed -i 's/"实时流量监测"/"流量"/g' `egrep "实时流量监测" -rl ./`
#sed -i 's/"KMS 服务器"/"KMS激活"/g' `egrep "KMS 服务器" -rl ./`
#sed -i 's/"TTYD 终端"/"TTYD"/g' `egrep "TTYD 终端" -rl ./`
#sed -i 's/"USB 打印服务器"/"打印服务"/g' `egrep "USB 打印服务器" -rl ./`
#sed -i 's/"Web 管理"/"Web管理"/g' `egrep "Web 管理" -rl ./`
#sed -i 's/"管理权"/"改密码"/g' `egrep "管理权" -rl ./`
#sed -i 's/"带宽监控"/"监控"/g' `egrep "带宽监控" -rl ./`


# 整理固件包时候,删除您不想要的固件或者文件,让它不需要上传到Actions空间
cat >${GITHUB_WORKSPACE}/Clear <<-EOF
rm -rf config.buildinfo
rm -rf feeds.buildinfo
rm -rf openwrt-x86-64-generic-kernel.bin
rm -rf openwrt-x86-64-generic.manifest
rm -rf openwrt-x86-64-generic-squashfs-rootfs.img.gz
rm -rf sha256sums
rm -rf version.buildinfo
EOF

# 在线更新时，删除不想保留固件的某个文件，在EOF跟EOF之间加入删除代码，记住这里对应的是固件的文件路径，比如： rm -rf /etc/config/luci
cat >>$DELETE <<-EOF
EOF
