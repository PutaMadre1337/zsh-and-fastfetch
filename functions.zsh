# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Fzf
function rgg() {
  rg --color=always --line-number --no-heading --smart-case "${*:-}" |
  fzf --ansi \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --delimiter : \
      --preview 'bat --color=always {1} --highlight-line {2}' \
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
      --border=rounded \
      --bind 'ctrl-o:execute(nvim {1} +{2})'
}

# Golang
function gmi {
if [ -z "$1" ]; then
    go mod init default
    go mod tidy
    return
  fi
    go mod init "$1"
    go mod tidy
}

function newgo {
if [ -z "$1" ]; then
    return 1
  fi

  mkdir "$1"
  cd "$1" || return 1

  mkdir -p cmd/"$1"
  mkdir internal
  echo -e "package main\n\nfunc main() {\n}" > cmd/"$1"/main.go

  go mod init "$1"
  go mod tidy

  git init
  git add .
  git commit -m "initial commit"
  git branch dev
  git checkout -b master
  git checkout dev
  git merge master

  echo "Go project '$1' created successfully."
}

function gbo {
    go build -o "$@" $(find . -iname main.go)
}

# cd autocmd
function chpwd {
  pwd
  eza -D -1 --show-symlinks --icons=auto
}

