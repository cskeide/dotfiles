function fish_greeting
end

if status is-interactive
	# Commands to run in interactive sessions can go here
	if test -d $HOME/bin
		fish_add_path $HOME/bin
	end

	set EDITOR /usr/bin/vim
	set GIT_EDITOR /usr/bin/vim
	set fish_prompt_pwd_dir_length 0
	
	# ls aliases
	alias la='ls -A'
	alias ll='ls -lAh'

	# use vim not vi
	alias vi 'vim'

	# Privileged access
	if not fish_is_root_user;
	    alias sudo='sudo '
	    alias scat='sudo cat'
	    alias svim='sudoedit'
	    alias root='sudo -i'
	    alias reboot='sudo systemctl reboot'
	    alias poweroff='sudo systemctl poweroff'
	end
	
	# misc
	alias df='df -H'
	alias du='du -ch'
	alias free='free -h'
	alias diff='colordiff'
	if [ (echo $TERM) = 'xterm-kitty' ];
		alias diff='kitten diff'
	end
	alias grep='grep --color=auto'
	alias more='less'
	alias ip='ip -c'

	# Safety features
	alias cp='cp -i'
	alias mv='mv -i'
	alias rm='rm -I'                    # 'rm -i' prompts for every file
	alias ln='ln -i'
	alias chown='chown --preserve-root'
	alias chmod='chmod --preserve-root'
	alias chgrp='chgrp --preserve-root'
end


