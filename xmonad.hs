{- Copied shamelessly from: http://www.haskell.org/haskellwiki/Xmonad/Config_archive/John_Goerzen's_Configuration#Installing_xmobar
-}

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks

import XMonad.Hooks.EwmhDesktops -- to get Chrome to work

-- allow use of e.g. volume control keys
import Graphics.X11.ExtraTypes.XF86

import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP)

import System.IO

main :: IO ()
main = do xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmobarrc"
          xmonad $ ewmh defaultConfig 
            { manageHook = manageDocks <+> manageHook defaultConfig
            , layoutHook = avoidStruts $ layoutHook defaultConfig
            , handleEventHook = fullscreenEventHook
            , logHook = dynamicLogWithPP xmobarPP
              { ppOutput = hPutStrLn xmproc
              , ppTitle = xmobarColor "green" "" . shorten 50
              }
            , modMask = mod3Mask  -- use capslock as mod key
            , terminal = "lxterminal" } 
            `additionalKeysP` myKeys

myKeys = [ ( "<XF86AudioLowerVolume>", spawn "amixer -q sset Master 5%- unmute")
         , ( "<XF86AudioRaiseVolume>", spawn "amixer -q sset Master 5%+ unmute")
         , ( "<XF86AudioMute>", spawn "amixer -q sset Master toggle")
--       , ( "<XF86XK_MonBrightnessUp>", spawn "xbacklight +20")
--       , ( "<XF86XK_MonBrightnessDown>", spawn "xbacklight -20")
	 ]
