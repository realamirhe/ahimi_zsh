##
## @alias gp
## @description Pull the latest changes from the current branch's remote tracking branch.
## @example
##   gp
##   # Equivalent to: git pull
alias gp='git pull'

##
## @alias gc
## @description Switch branches or restore working tree files.
## Commonly used to change branches in a repository.
## @param {string} branch The branch name to checkout.
## @example
##   gc main
##   # Switches to branch 'main'
alias gc='git checkout'

##
## @alias gl
## @description Show a concise git log with decorations, branch graph, and commit messages on one line.
## @example
##   gl
##   # Output:
##   # * e8f12ab (HEAD -> main) Fix bug in auth flow
##   # * 3b7a1d2 Add tests for login
##   # | * a92d3f4 (feature/branch) Implement new feature
alias gl='git log --decorate --oneline --graph'

##
## @alias gitrm
## @description Safely remove all fully merged local branches except master, main, and dev.
## @example
##   gitrm
##   # Removes merged branches:
##   #   branch-old -> deleted
##   #   feature-x -> deleted
alias gitrm='git branch --merged | egrep -v "(^\*|master|main|dev)" | xargs git branch -d'

##
## @alias gitrmD
## @description Force delete all fully merged local branches except master, main, and dev.
## Use when branches cannot be deleted with `gitrm` due to unmerged changes.
## @example
##   gitrmD
##   # Forcefully removes:
##   #   feature-y -> deleted
alias gitrmD='git branch --merged | egrep -v "(^\*|master|main|dev)" | xargs git branch -D'

##
## @alias cdr
## @description Quickly navigate to the root directory of the current git repository.
## @example
##   cdr
##   # If you are inside /project/src/utils, it will take you to /project
alias cdr='cd $(git rev-parse --show-toplevel)'

##
## @alias no
## @description Run a command without zsh autocorrection (prevents zsh from suggesting corrections).
## @example
##   no pnpm storybook
##   Runs 'pnpm storybook' without prompting: 'zsh correct 'storybook' to '.storybook' [nyae]?'
alias no="nocorrect"

##
## @function gitclone
## @description Clone a repository as a shallow copy (only latest commit) and single branch.
## This makes the clone faster and lighter.
## @param {string} repo_url The URL of the git repository to clone.
## @example
##   gitclone https://github.com/user/project.git
##   # Clones only the latest commit of the default branch
## @example
##   gitclone https://github.com/user/project.git --branch dev
##   # Clones only the latest commit of the dev branch
function gitclone {
    git clone "$1" --single-branch --depth 1
}

##
## @function gof
## @description Fetch a specific branch from origin and create a local branch with the same name.
## Useful when tracking a new remote branch.
## @param {string} branch The name of the branch to fetch.
## @example
##   gof feature-x
##   # Creates a local branch 'feature-x' from origin/feature-x
function gof {
    git fetch origin $1:$1
}

##
## @function killport
## @description Kill any process that is running on a given port using npx kill-port.
## @param {number} port The port number to free.
## @example
##   killport 3000
##   # Kills any process bound to port 3000
function killport {
    npx kill-port $1
}

##
# @function update_ahimi_plugin_zsh
# @description Update the custom "ahimi" Oh My Zsh plugin by pulling the latest changes from its git repository.
# It automatically navigates to the plugin's directory inside Oh My Zsh custom plugins and runs `git pull`.
# @example
#   update_ahimi_plugin_zsh
#   # Updates the ahimi plugin to the latest version
# @example
#   ZSH_CUSTOM="~/.omz/custom/" && update_ahimi_plugin_zsh
#   # Updates the ahimi plugin to the latest version using a custom Oh My Zsh directory
function update_ahimi_plugin_zsh {
    (cd "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/ahimi" && git pull)
}