# My *dotfiles*

Repository containing most of my configuration files

> Since the setup uses *make*, be sure you have this package installed:

```sh
# Install required dependencies
sudo apt install make git python3-pip
# Clone the repository
git clone https://github.com/essembeh/dotfiles
cd dotfiles
# Sync the git submodules
make
# Install configuration for a headless server
make headless
# Install configuration for Gnome3 desktop
make desktop
```
