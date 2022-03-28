# GNOME-Adaptive-shortcuts-and-icon-size
Whenever I plugged my old laptop from the external display which has a higher resolution, I would have to remove some dock shortcuts. And conversely, plugging the said monitor would lead to too small number of rows and too large icons in the app grid.

The script should be capable of daemonizing itself under systemd. Upon the first launch you'll be asked to provide the names of the apps you want to hide.
If you want to change which apps you want to hide simply re-run the script. Unfortunately support for removing/adding single apps is not yet implemented, the app is still WIP.

In order to set the icon size, run with --ico [size] flag and in order to change the number of App Grid rows, --rows [number]
