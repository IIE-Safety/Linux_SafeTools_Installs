yum update -y #更新yum
yum install  lrzsz -y #安装sz、rz
yum install vim -y #安装vim
yum install screen -y #安装screen
yum install git -y # 安装git
yum install nmap -y #安装nmp
yum install masscan -y #安装masscan
yum install unzip -y #安装unzip

#安装go环境
yum install go -y
exportGO111MODULE=on$exportGOPROXY=https://goproxy.cn #设置go的国内源

#安装MSF
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
chmod +x msfinstall
./msfinstall
msfconsole --version
msfdb init
msfconsole

#安装nps
cd /usl/local/
mkdir nps-server
cd nps-server
wget https://github.com/ehang-io/nps/releases/download/v0.26.10/linux_amd64_server.tar.gz
tar -zxvf linux_amd64_server.tar.gz
rm -rf linux_amd64_server.tar.gz
chmod +x ./nps
#**注意** 需要修改端口就在nps.conf处修改，我使用180、1443、8081
./nps install #默认8080 80 443 端口
cd /usl/local/
rm -rf /usl/local/nps-server
nps start

#安装docker环境
yum install -y yum-utils
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

yum install docker-ce docker-ce-cli containerd.io -y
mkdir -p /etc/docker #创建目录
#配置镜像加速器地址
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://rrnv06ig.mirror.aliyuncs.com"]
}
EOF

systemctl enable docker

#安装docker-compose
curl -L "https://github.com/docker/compose/releases/download/v2.10.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version

#安装frp
cd /usr/local
wget https://github.com/fatedier/frp/releases/download/v0.44.0/frp_0.44.0_linux_amd64.tar.gz
tar -zxvf frp_0.44.0_linux_amd64.tar.gz
cd frp_0.44.0_linux_amd64
chmod +x ./frps
sudo tee /usr/local/frp_0.44.0_linux_amd64/frps.ini <<-'EOF'
[common]
bind_port = 7000  #与客户端绑定的进行通信的端口

dashboard_port = 8090 #开启服务器WEB面板
dashboard_user = admin
dashboard_pwd = admin
EOF
#运行此程序即可开启 ./frps -c ./frps.ini 访问https://VPS-IP:8090

#安装钓鱼平台gophish x86_64
cd /usr/local
wget https://github.com/gophish/gophish/releases/download/v0.12.0/gophish-v0.12.0-linux-64bit.zip
mkdir gophish
unzip gophish-v0.12.0-linux-64bit.zip -d ./gophish
rm -rf gophish-v0.12.0-linux-64bit.zip
cd /usr/local/gophish
#**注意**，若需要修改端口就在config.json处修改。默认3333和80，我是8091和80
chmod +x ./gophish
#若出现"remote error: tls: unknown certificate"，则可能是防火墙或者iptables拦截(我自己是防火墙)，systemctl stop firewalld（我是开了又关，才成功）
systemctl start firewalld
systemctl stop firewalld

#安装Allin_go
git clone https://github.com/P1-Team/AlliN.git

#安装java环境
wget https://repo.huaweicloud.com/java/jdk/8u201-b09/jdk-8u201-linux-x64.tar.gz
tar -zxvf jdk-8u201-linux-x64.tar.gz
mkdir /usr/local/jdk1.8
mv jdk1.8.0_201 /usr/local/jdk1.8/jdk1.8.0_201
#配置java的环境变量
cat>>/etc/profile<<EOF
export JAVA_HOME=/usr/local/jdk1.8/jdk1.8.0_201
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export PATH=$JAVA_HOME/bin:$PATH
export JER_HOME=$JAVA_HOME/jre
EOF
#更新配置
source /etc/profile
java -version

#安装Ehole v3.0
cd /usr/local/
wget https://github.com/EdgeSecurityTeam/EHole/releases/download/3.0/Ehole3.0-linux.zip
mkdir Ehole3.0
unzip Ehole3.0-linux.zip -d ./Ehole3.0
cd Ehole3.0
chmod +x Ehole3.0-linux
./Ehole3.0-linux

#安装dnsx
go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest
cp /root/go/bin/dnsx /usr/local/bin
dnsx -h

#安装subfinder
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
cp /root/go/bin/subfinder /usr/local/bin
subfinder -h

#安装Allin
cd /usr/local/
mkdir Py-script
cd Py-script
mkdir py3
cd py3
git clone https://github.com/P1-Team/AlliN.git
mv AlliN/AlliN.py cd /usr/local/Py-script/py3
python3 Py-script

#安装Oneforall
cd /usr/local/
git clone https://github.com/shmilylty/OneForAll.git
cd OneForALL
python3 -m pip install -U pip setuptools wheel -i https://mirrors.aliyun.com/pypi/simple/
pip3 install -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple/
python3 oneforall.py --help

#安裝Masscan-to-CSV
cd /usr/local/Py-script/py3
git clone https://github.com/laconicwolf/Masscan-to-CSV.git
mv Masscan-to-CSV/masscan_xml_parser.py  /usr/local/Py-script/py3
rm -rf Masscan-to-CSV

#安裝
cd /usr/local/Py-script/py3
git clone https://github.com/laconicwolf/Nmap-Scan-to-CSV.git
rm -rf Nmap-Scan-to-CSV
mv Nmap-Scan-to-CSV/nmap_xml_parser.py  /usr/local/Py-script/py3