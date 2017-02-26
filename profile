PATH="$HOME/bin:$PATH"  
PATH="$HOME/.rbenv/bin:$PATH"
PATH="/usr/local/heroku/bin:$PATH"

[ "$XDG_CURRENT_DESKTOP" = "KDE" ] || [ "$XDG_CURRENT_DESKTOP" = "GNOME" ] \
  || export QT_QPA_PLATFORMTHEME="qt5ct"


if [[ -e ~/.env-private ]]; then
  source ~/.env-private
fi

eval "$(rbenv init -)"

