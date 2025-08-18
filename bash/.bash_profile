# ~/.bash_profile
# Some distros (like RHEL) prefer this over .profile
if [ -r "$HOME/.profile" ]; then
	. "$HOME/.profile"
fi
