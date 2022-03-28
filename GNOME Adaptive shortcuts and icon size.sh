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


echo Please provide the name of the app or apps, separated by spaces, you want to show when external display is connected:
read -a '' apps
for i in $apps
do
applist=''
$(grep -Fi $i ~/.local/share/applications) > $applist 

hdmi_active=$(xrandr |grep ' connected' |grep 'HDMI' |awk '{print $1}')

if [[ -z "$hdmi_active" ]] || [[ ! -f ~/.local/share/applications/123*]];
then
mv ~/.local/share/applications/123* ~/.local/share/aplications/disabed/
gsettings (set icon size etc.)
killall -3 gnome-shell
elif [-f  ~/.local/share/applications/123*]; # this condition check probably isn't necessary as any potential duplicate shortcuts won't be allowed to be created
then
mv ~/.local/share/applications/disabled/* ~/.local/share/applications/
fi
