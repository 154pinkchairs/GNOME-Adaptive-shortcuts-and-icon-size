#  GNOME Adaptive shortcuts and icon size
#  
#  Copyright 2022 Marcelina H. <ovehis@riseup.net>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  


#! /bin/zsh
# check if gnome-overview-conf, which is needed to change icon size and layout, is present
if ! command -v gnome-overview-conf &> /dev/null
then
    echo "gnome-oveview-conf could not be found"
    exit
fi

echo Please provide the name of the app or apps, separated by spaces, you want to show when external display is connected:
read -ra '' apps
for i in $apps
do
declare -a applist
applist=($i)
$(grep -Fi $i ~/.local/share/applications) > $applist # need to make it pass full .desktop files names 
done 
for j in $applist 
do
mkdir -p ~./local/share/applications/additional
mv $j ~./local/share/applications/additional # move the shortucuts that'd be displayed only with higher res to a temp. dir
done
echo "Please provide icon size for laptop:"
read licon
echo "Please provide icon size for when external display is connected:"
read hdicon

hdmi_active=$(xrandr |grep ' connected' |grep 'HDMI' |awk '{print $1}')
if [ ! -z "$hdmi_active" ] || ! $find ~/.local/share/applications/disabled/*;
then
mv ~/.local/share/applications/additional/* ~/.local/share/aplications/disabed/ 
gnome-overview-conf icon_size "$licon"
killall -3 gnome-shell # hide the extra shortcuts and restart the DE
elif $find ~/.local/share/applications/additional/*; # this condition check probably isn't necessary as any potential duplicate shortcuts won't be allowed to be created
then
mv ~/.local/share/applications/disabled/* ~/.local/share/applications/
gnome-overview-conf icon_size "$hdicon" 
killall -3 gnome-shell
fi
