import System.IO
import XMonad
import Data.Monoid
import System.Exit
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Layout.PerWorkspace
import XMonad.Hooks.UrgencyHook
import XMonad.Util.EZConfig
import XMonad.Actions.OnScreen
import XMonad.Hooks.SetWMName  

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
 
    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
 
    -- launch dmenu
    , ((modm,               xK_0     ), spawn "dmenu_run")
 
    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)
 
     -- Rotate through the available layout algorithms
    , ((modm,               xK_l ), sendMessage NextLayout)
 
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
 
    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)
 
    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)
 
    -- -- Move focus to the next window
    -- , ((modm,               xK_j     ), windows W.focusDown)
 
    -- -- Move focus to the previous window
    -- , ((modm,               xK_k     ), windows W.focusUp  )
 
    -- -- Move focus to the master window
    -- , ((modm,               xK_m     ), windows W.focusMaster  )
 
    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)
 
    -- -- Swap the focused window with the next window
    -- , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
 
    -- -- Swap the focused window with the previous window
    -- , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
 
    -- -- Shrink the master area
    -- , ((modm,               xK_h     ), sendMessage Shrink)
 
    -- -- Expand the master area
    -- , ((modm,               xK_l     ), sendMessage Expand)
 
    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
 
    -- -- Increment the number of windows in the master area
    -- , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
 
    -- -- Deincrement the number of windows in the master area
    -- , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
 
    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)
 
    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
 
    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    , ((modm .|. shiftMask, xK_x     ), spawn "xscreensaver-command -lock")

    , ((modm, xK_Left), spawn "spotify-control.py prev")
    , ((modm, xK_Right), spawn "spotify-control.py next")
    , ((modm, xK_Up), spawn "spotify-control.py play_pause")
    , ((modm, xK_Down), spawn "spotify-control.py stop")
    , ((modm, xK_o), spawn "spotify-control.py full_info")
    , ((modm .|. shiftMask, xK_d), spawn "set-display.py")

    , ((modm, xK_1), windows (viewOnScreen 1 "www/1"))
    , ((modm, xK_2), windows (viewOnScreen 0 "dev/2"))
    , ((modm, xK_3), windows (viewOnScreen 0 "dev2/3"))
    , ((modm, xK_4), windows (viewOnScreen 1 "vbox/4"))
    , ((modm, xK_5), windows (viewOnScreen 1 "pidgin/5"))
    , ((modm, xK_6), windows (viewOnScreen 1 "music/6"))
    , ((modm, xK_7), windows (viewOnScreen 0 "m1/7"))
    , ((modm, xK_8), windows (viewOnScreen 0 "m2/8"))
    , ((modm, xK_9), windows (viewOnScreen 0 "m3/9"))
    ]
    -- ++
 
    -- --
    -- -- mod-[1..9], Switch to workspace N
    -- --
    -- -- mod-[1..9], Switch to workspace N
    -- -- mod-shift-[1..9], Move client to workspace N
    -- --
    -- [((m .|. modm, k), windows $ f i)
    --     | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    --     , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    -- ++

    
    -- -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    
    -- [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
    --     | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    --     , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

wksp = [ "www/1", "dev/2", "dev2/3", "vbox/4", "pidgin/5", "music/6", "m1/7", "m2/8", "m3/9" ]

layout_hook = avoidStruts
        $ onWorkspaces [ "www/1", "dev2/3", "vbox/4", "music/6", "m1/7", "m2/8", "m3/9" ] Full
        $ onWorkspace "dev/2" (Tall 1 (3/100) (2/3))
        $ onWorkspace "pidgin/5" (Tall 1 (3/100) (4/5))
        $ Tall 1 (3/100) (1/2)

manage_hook = composeAll [
  className =? "Google-chrome-stable" --> doShift "www/1",
  className =? "Google-chrome-unstable" --> doShift "www/1",
  className =? "Chromium" --> doShift "www/1",
  className =? "Nw" --> doShift "www/1",
  className =? "Nw-0.8.6" --> doShift "www/1",
  className =? "QupZilla" --> doShift "www/1",

  className =? "Emacs" --> doShift "dev/2",
  className =? "URxvt" --> doShift "dev/2",

  className =? "Sqliteman" --> doShift "dev2/3",
  className =? "processing-app-Base" --> doShift "dev2/3",
  className =? "Pgadmin3" --> doShift "dev2/3",
  className =? "com-edgytech-umongo-UMongo" --> doShift "dev2/3",

  className =? "VirtualBox" --> doShift "vbox/4",

  className =? "Pidgin" --> doShift "pidgin/5",
  
  className =? "Spotify" --> doShift "music/6",
  className =? "Deadbeef" --> doShift "music/6",
  className =? "Amarok" --> doShift "music/6",
  className =? "Clementine" --> doShift "music/6",

  className =? "Thunar" --> doShift "m1/7",
  className =? "Deluge" --> doShift "m1/7",
  className =? "Gnucash" --> doShift "m1/7",

  className =? "Gimp" --> doShift "m2/8",

  className =? "Xmessage" --> doFloat,
  className =? "Vmpk" --> doFloat,
  className =? "Arandr" --> doFloat,
  className =? "tt-gui" --> doFloat,
  className =? "Tt-gui" --> doFloat,
  className =? "Zim" --> doFloat,
  className =? "Skype" --> doFloat

  ] <+> manageDocks


-- startup_hook = do
--   spawn "/home/andrew/bin/trayer.sh"
  -- setWMName "LG3D"
  
main = do
  xmproc <- spawnPipe "xmobar"
  
  xmonad
    $ withUrgencyHook NoUrgencyHook
    $ defaultConfig {
      terminal          = "urxvt",
      modMask           = mod4Mask,
      focusFollowsMouse = True,
      workspaces        = wksp,
      keys              = myKeys,
      manageHook        = manage_hook,
      layoutHook        = layout_hook,
      -- startupHook       = startup_hook,
      logHook           = dynamicLogWithPP xmobarPP {
        ppOutput = hPutStrLn xmproc,
        ppTitle = xmobarColor "green" "" . shorten 50,
        ppUrgent = xmobarColor "#FF0000" ""
        }
      }
    `additionalKeysP`
    [
      ("<XF86AudioNext>", spawn "spotify-control.py next"),
      ("<XF86AudioPrev>", spawn "spotify-control.py prev"),
      ("<XF86AudioStop>", spawn "spotify-control.py stop"),
      ("<XF86AudioPlay>", spawn "spotify-control.py play_pause")
    ]
