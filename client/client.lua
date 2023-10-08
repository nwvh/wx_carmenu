
function CarMenu()
    local ped = PlayerPedId()
    if not IsPedInAnyVehicle(ped,false) then
        Notify(wx.Locale['notinveh'])
        return
    else
        function ToggleEngine(veh)
            local engineRunning = GetIsVehicleEngineRunning(veh)
            if engineRunning then
                SetVehicleEngineOn(veh,false,false,true)
            else
                SetVehicleEngineOn(veh,true,false,true)
            end
        end
        
        local extras = {{
            title = wx.Locale['back'],
            menu = 'carmenu',
            icon = 'arrow-left'
          }}
        for i=0,20 do
            if DoesExtraExist(GetVehiclePedIsIn(PlayerPedId(),false),i) then
                table.insert(extras, {
                    title = wx.Locale['extra'].." "..i,
                    icon = 'plus',
                    onSelect = function ()
                        lib.showContext('extras')
                        if not IsVehicleExtraTurnedOn(GetVehiclePedIsIn(PlayerPedId(),false),i) then
                            SetVehicleExtra(GetVehiclePedIsIn(PlayerPedId(),false),i,0)
                        else
                            SetVehicleExtra(GetVehiclePedIsIn(PlayerPedId(),false),i,1)
                        end
                    end
                })
            end
        end

        
        lib.registerContext({
            id = 'extras',
            title = 'Extra Menu',
            options = extras
          })
        
        local liveries = {{
            title = wx.Locale['back'],
            
            menu = 'carmenu',
            icon = 'arrow-left'
          }}
        for i=0,GetVehicleLiveryCount(GetVehiclePedIsIn(PlayerPedId(),false)) do
            table.insert(liveries, {
                title = wx.Locale['livery'].." "..i,
                icon = 'palette',
                onSelect = function ()
                    lib.showContext('liveries')
                    SetVehicleLivery(GetVehiclePedIsIn(PlayerPedId(),false),i)
                end
            })
        end
        
        lib.registerContext({
            id = 'liveries',
            title = wx.Locale['liveries'],
            options = liveries
          })

        lib.registerContext({
            id = 'seats',
            title = wx.Locale['seats'],
            options = {
                {
                    title = wx.Locale['back'],
                    
                    menu = 'carmenu',
                    icon = 'arrow-left'
                  },
                
                {
                    title = 'Shuffle',
                    icon = 'rotate',
                    onSelect = function()
                      lib.showContext('seats')
                      local veh = GetVehiclePedIsIn(PlayerPedId(),false)
                      TaskShuffleToNextVehicleSeat(PlayerPedId(),veh)
                    end,
                },
                {
                    title = 'Driver Seat',
                    icon = 'chair',
                    onSelect = function()
                        lib.showContext('seats')
                        SetPedConfigFlag(PlayerPedId(), 184, false)
                      local veh = GetVehiclePedIsIn(PlayerPedId(),false)
                      SetPedIntoVehicle(PlayerPedId(), veh, -1)
                    end,
                },
                {
                    title = 'Passenger Seat',
                    icon = 'chair',
                    onSelect = function()
                        lib.showContext('seats')
                        SetPedConfigFlag(PlayerPedId(), 184, true)
                      local veh = GetVehiclePedIsIn(PlayerPedId(),false)
                      SetPedIntoVehicle(PlayerPedId(), veh, 0)
                    end,
                },
                {
                    title = 'Rear Left Seat',
                    icon = 'chair',
                    onSelect = function()
                        lib.showContext('seats')
                        SetPedConfigFlag(PlayerPedId(), 184, false)
                      local veh = GetVehiclePedIsIn(PlayerPedId(),false)
                      SetPedIntoVehicle(PlayerPedId(), veh, 1)
                    end,
                },
                {
                    title = 'Rear Right Seat',
                    icon = 'chair',
                    onSelect = function()
                        lib.showContext('seats')
                        SetPedConfigFlag(PlayerPedId(), 184, false)
                      local veh = GetVehiclePedIsIn(PlayerPedId(),false)
                      SetPedIntoVehicle(PlayerPedId(), veh, 2)
                    end,
                },
            }
          })
        local driver = false
        local pass = false
        local rearleft = false
        local rearright = false
        local trunk = false
        local hood = false
        lib.registerContext({
            id = 'doors',
            title = wx.Locale['doors'],
            options = {
                {
                    title = wx.Locale['back'],
                    
                    menu = 'carmenu',
                    icon = 'arrow-left'
                  },
                
                {
                    title = "Driver's Door",
                    icon = 'door-open',
                    onSelect = function()
                      lib.showContext('doors')
                      local veh = GetVehiclePedIsIn(PlayerPedId(),false)
                      if not driver then
                        driver = true
                        SetVehicleDoorOpen(veh, 0, false, false)
                      else
                        driver = false
                        SetVehicleDoorShut(veh, 0, false)
                      end
                    end,
                },
                {
                    title = "Passenger's Door",
                    icon = 'door-open',
                    onSelect = function()
                      lib.showContext('doors')
                      local veh = GetVehiclePedIsIn(PlayerPedId(),false)
                      if not pass then
                        pass = true
                        SetVehicleDoorOpen(veh, 1, false, false)
                      else
                        pass = false
                        SetVehicleDoorShut(veh, 1, false)
                      end
                    end,
                },
                {
                    title = "Rear Left Door",
                    icon = 'door-open',
                    onSelect = function()
                      lib.showContext('doors')
                      local veh = GetVehiclePedIsIn(PlayerPedId(),false)
                      if not rearleft then
                        rearleft = true
                        SetVehicleDoorOpen(veh, 2, false, false)
                      else
                        rearleft = false
                        SetVehicleDoorShut(veh, 2, false)
                      end
                    end,
                },
                {
                    title = "Rear Right Door",
                    icon = 'door-open',
                    onSelect = function()
                      lib.showContext('doors')
                      local veh = GetVehiclePedIsIn(PlayerPedId(),false)
                      if not rearright then
                        rearright = true
                        SetVehicleDoorOpen(veh, 3, false, false)
                      else
                        rearright = false
                        SetVehicleDoorShut(veh, 3, false)
                      end
                    end,
                },
                {
                    title = "Hood",
                    icon = 'door-open',
                    onSelect = function()
                      lib.showContext('doors')
                      local veh = GetVehiclePedIsIn(PlayerPedId(),false)
                      if not hood then
                        hood = true
                        SetVehicleDoorOpen(veh, 4, false, false)
                      else
                        hood = false
                        SetVehicleDoorShut(veh, 4, false)
                      end
                    end,
                },
                {
                    title = "Trunk",
                    icon = 'door-open',
                    onSelect = function()
                      lib.showContext('doors')
                      local veh = GetVehiclePedIsIn(PlayerPedId(),false)
                      if not trunk then
                        trunk = true
                        SetVehicleDoorOpen(veh, 5, false, false)
                      else
                        trunk = false
                        SetVehicleDoorShut(veh, 5, false)
                      end
                    end,
                },
                
            }
          })
        
        lib.registerContext({
            id = 'carmenu',
            title = wx.Locale['carmenu'],
            options = {
              {
                title = wx.Locale['engine'],
                description = wx.Locale['enginedesc'],
                icon = 'gears',
                onSelect = function()
                  local veh = GetVehiclePedIsIn(PlayerPedId(),false)
                  ToggleEngine(veh)
                end,
              },
              {
                title = wx.Locale['doors'],
                description = 'Open/Close vehicle doors',
                menu = 'doors',
                icon = 'door-open'
              },
              {
                title = 'Windows',
                description = 'Open/Close each window',
                menu = 'window_menu',
                icon = 'cloud-sun'
              },
              {
                title = 'Seats',
                description = 'Change your seat in your current vehicle',
                menu = 'seats',
                icon = 'chair'
              },
              {
                title = 'Liveries',
                description = 'Toggle available vehicle liveries',
                menu = 'liveries',
                icon = 'palette'
              },
              {
                title = 'Extras',
                description = 'Toggle available vehicle extras',
                menu = 'extras',
                disabled = not wx.allowExtras,
                icon = 'cloud-sun'
              },
            }
          })
        
        local lf = true
        local rf = true
        local lr = true
        local br = true
        
        lib.registerContext({
            id = 'window_menu',
            title = 'Car Menu - Windows',
            options = {
              {
                title = wx.Locale['back'],
                
                menu = 'carmenu',
                icon = 'arrow-left'
              },
              {
                title = "Front right",
                description = 'Turns on/off your engine',
                icon = 'gears',
                onSelect = function()
                  lib.showContext('window_menu')
                  local veh = GetVehiclePedIsIn(PlayerPedId(),false)
                  if lf then
                    lf = false
                    RollDownWindow(veh,0)
                  else
                    lf = true
                    RollUpWindow(veh,0)
                  end
                end,
              },
              {
                title = "Rear left",
                description = 'Turns on/off your engine',
                icon = 'gears',
                onSelect = function()
                  lib.showContext('window_menu')
                  local veh = GetVehiclePedIsIn(PlayerPedId(),false)
                  if rf then
                    rf = false
                    RollDownWindow(veh,1)
                  else
                    rf = true
                    RollUpWindow(veh,1)
                  end
                end,
              },
              {
                title = "Rear right",
                description = 'Turns on/off your engine',
                icon = 'gears',
                onSelect = function()
                  lib.showContext('window_menu')
                  local veh = GetVehiclePedIsIn(PlayerPedId(),false)
                  if lr then
                    lr = false
                    RollDownWindow(veh,2)
                  else
                    lr = true
                    RollUpWindow(veh,2)
                  end
                end,
              },
              {
                title = "Front left",
                description = 'Turns on/off your engine',
                icon = 'gears',
                onSelect = function()
                  lib.showContext('window_menu')
                  local veh = GetVehiclePedIsIn(PlayerPedId(),false)
                  if br then
                    br = false
                    RollDownWindow(veh,3)
                  else
                    br = true
                    RollUpWindow(veh,3)
                  end
                end,
              },
            }
        })
        lib.showContext('carmenu')
    end
end

RegisterCommand(wx.Command,function ()
    CarMenu()
end,false)
RegisterKeyMapping(wx.Command,"Opens car menu","keyboard",wx.OpenKey)