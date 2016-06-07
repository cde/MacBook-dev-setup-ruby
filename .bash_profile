# Add Homebrew `/usr/local/bin` and User `~/bin` to the `$PATH`
PATH=/usr/local/bin:$PATH
PATH=$HOME/bin:$PATH
export PATH

# Rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt, bash_aliases, exports,functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file
