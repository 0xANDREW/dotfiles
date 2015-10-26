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
 
    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)
 
    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
 
    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
 
    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    , ((modm .|. shiftMask, xK_x     ), spawn "xscreensaver-command -lock")

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

wksp = [ "www/1", "dev/2", "dev2/3", "vbox/4", "pidgin/5", "music/6", "m1/7", "m2/8", "m3/9" ]

layout_hook = avoidStruts
        $ onWorkspaces [ "www/1", "dev2/3", "vbox/4", "music/6", "m1/7", "m2/8", "m3/9" ] Full
        $ onWorkspace "dev/2" (Tall 1 (3/100) (2/3))
        $ onWorkspace "pidgin/5" (Tall 1 (3/100) (4/5))
        $ Tall 1 (3/100) (1/2)

manage_hook = composeAll [
  className =? "Google-chrome" --> doShift "www/1",
  className =? "Google-chrome-unstable" --> doShift "www/1",
  className =? "Chromium" --> doShift "www/1",
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
      logHook           = dynamicLogWithPP xmobarPP {
        ppOutput = hPutStrLn xmproc,
        ppTitle = xmobarColor "green" "" . shorten 50,
        ppUrgent = xmobarColor "#FF0000" ""
        }
      }
    `additionalKeysP`
    [
      ("<XF86AudioNext>", spawn "playerctl --player=spotify next"),
      ("<XF86AudioPrev>", spawn "playerctl --player=spotify previous"),
      ("<XF86AudioPlay>", spawn "playerctl --player=spotify play-pause")
    ]
