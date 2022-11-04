#show network devices
ip link show
#get a network device from user
read -p "Enter a network device: " device
#check if the device is up or down
if [ $(ip link show $device | grep -c "state UP") -eq 1 ]
then
    echo "The device is up"
else
    echo "The device is down"
fi
#show available wifi networks and show ssid 
# nmcli dev wifi | grep SSID
iw dev $device scan | grep SSID
# get a ssid from user and connect to that network
read -p "Enter a ssid: " ssid
read -p "Enter a password: " password
nmcli dev wifi connect $ssid password $password
#check connection with ping
ping -c 3 google.com

<<com
or we can use these commands => 
ip a
sudo ifconfig wlan0 up
nmcli radio wifi on
nmcli dev status
echo "blacklist hp_wmi" | sudo tee /etc/modprobe.d/hp.conf
sudo rfkill unblock all
sudo iw wlan0 scan | grep SSID
sudo nmcli --ask dev wifi connect <ssid>
com
