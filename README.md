# polybar-mullvad-status

A script that shows if Mullvad is connected, connecting or disconnected.
Notifications are builtin, unlike the version I submitted to [polybar-scripts](https://github.com/polybar/polybar-scripts).

![vpn-mullvad-status](screenshots/1.png)
![vpn-mullvad-status](screenshots/2.png)

## Module

```ini
[module/polybar-mullvad-status]
type = custom/script
exec = $PATH_TO_SCRIPT
interval = 5
```
