## Install homebrew 
## Check if exists
command -v brew >/dev/null 2>&1 || { echo "Installing Homebrew.."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  } >&2;
echo "Homebrew successfully installed"

## install git
echo "Installing git.."
brew install git
echo "git successfully installed"

## install dbt
echo "Installing dbt.."
brew update
brew tap dbt-labs/dbt
brew install dbt-bigquery
echo "dbt successfully installed"

## Get oh my zsh (plugins, themes for zsh).
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
## Set zsh theme
sed -i '' 's/ZSH_THEME=".*"/ZSH_THEME="bira"/g' ~/.zshrc
sed -i '' 's/plugins=(git)/plugins=(git zsh-autosuggestions jump)/g' ~/.zshrc

## Fix zsh permissions
chmod 755 /usr/local/share/zsh
chmod 755 /usr/local/share/zsh/site-functions

## source file to get jump working
source ~/.zshrc

## install the project
echo "Installing the datateam project.."
mkdir ~/sidekick/
cd ~/sidekick/
git clone git@bitbucket.org:goodlifeme/datateam.git
cd datateam
mark datateam
echo "Analytics repo successfully installed"

echo "Setting up dbt profile.."
mkdir ~/.dbt
touch ~/.dbt/profiles.yml
curl https://raw.githubusercontent.com/callum-sidekick/sidekick-admin/main/sample_profiles.yml >> ~/.dbt/profiles.yml
echo "export DBT_PROFILES_DIR=~/.dbt" >> ~/.zshrc
echo "dbt profile created.. You will need to edit this file later."

## you will need to edit this file
## install visual studio code
echo "Installing VS Code.."
brew install --cask visual-studio-code
## this might ask you for your password
code --version
echo "VS Code successfully installed"

## install miniforge
echo "Installing miniforge.."
brew install miniforge
echo "export PATH=/usr/local/mambaforge/bin:"$PATH"" >> ~/.bash_profile
echo "export PATH=/usr/local/mambaforge/bin:"$PATH"" >> ~/.zprofile
echo "miniforge installed succesfully"

## install iterm2
echo "Installing iTerm2.."
cd ~/Downloads
curl https://iterm2.com/downloads/stable/iTerm2-3_4_16.zip > iTerm2.zip
unzip iTerm2.zip - A &> /dev/null
mv iTerm.app/ /Applications/iTerm.app
spctl --add /Applications/iTerm.app
rm -rf iTerm2.zip
echo "iTerm2 successfully installed.. Adding colors.."

## install the dbt completion script
curl https://raw.githubusercontent.com/fishtown-analytics/dbt-completion.bash/master/dbt-completion.bash > ~/.dbt-completion.bash
echo 'autoload -U +X compinit && compinit' >> ~/.zshrc
echo 'autoload -U +X bashcompinit && bashcompinit' >> ~/.zshrc
echo 'source ~/.dbt-completion.bash' >> ~/.zshrc

## create global gitignore
echo "Creating a global gitignore.."
git config --global core.excludesfile ~/.gitignore
touch ~/.gitignore
echo '.DS_Store' >> ~/.gitignore
echo '.idea' >> ~/.gitignore
echo "Global gitignore created"

## Add in helper script
echo "Copying make life easier script.."
curl https://raw.githubusercontent.com/callum-sidekick/sidekick-admin/main/make_life_easier.zsh > ~/.make_life_easier.zsh
echo 'source ~/.make_life_easier.zsh' >> ~/.zshrc
echo "Copied successfully"