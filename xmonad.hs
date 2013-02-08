import XMonad
import XMonad.Util.EZConfig

main = xmonad $ defaultConfig { terminal = "lxterminal" } 
		`additionalKeysP` myKeys

myKeys = [ 
	 ]
