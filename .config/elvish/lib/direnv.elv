## hook for direnv
set @edit:before-readline = $@edit:before-readline {
	try {
		var m = [("/nix/store/m4cm100c4rs9ymwg3a982xkp6s9vknh0-direnv-2.29.0/bin/direnv" export elvish | from-json)]
		if (> (count $m) 0) {
			set m = (all $m)
			keys $m | each {|k|
				if $m[$k] {
					set-env $k $m[$k]
				} else {
					unset-env $k
				}
			}
		}
	} except e {
		echo $e
	}
}
