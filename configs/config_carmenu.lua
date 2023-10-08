wx = {}

wx.Command = "carmenu"
wx.OpenKey = "F6"
wx.allowExtras = true -- Allow extras menu?

wx.Locale = {
    ['notinveh'] = "You must be in a vehicle to use this menu!",
    ['carmenu'] = "Car Menu",
    ['back'] = "Go back",
    ['engine'] = "Engine",
    ['enginedesc'] = "Turn engine ON/OFF",
    ['extra'] = "Extras",
    ['seats'] = "Seats",
    ['livery'] = "Liveries",
    ['doors'] = "Door Menu",
}


Notify = function(message)
    lib.notify({
        title = 'Car Menu',
        description = message,
        position = 'top',
        style = {
            backgroundColor = '#1E1E2E',
            color = '#C1C2C5',
            ['.description'] = {
              color = '#909296'
            }
        },
        icon = 'car-side',
        iconColor = '#cba6f7'
    })
end