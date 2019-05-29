# Thanks to http://dev.enekoalonso.com/2011/08/09/uninstalling-brew-so-i-can-reinstall/

cd `brew --prefix`
rm -rf Cellar
brew prune
rm -rf Library .git .gitignore bin/brew README.md share/man/man1/brew
rm -rf ~/Library/Caches/Homebrew

ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

