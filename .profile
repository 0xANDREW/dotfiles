PATH="$HOME/bin:$PATH"  
PATH="$HOME/.rbenv/bin:$PATH"
PATH="/usr/local/heroku/bin:$PATH"

if [[ -e ~/.env-private ]]; then
  source ~/.env-private
fi

eval "$(rbenv init -)"

