# Yonatan's Dotfiles

This is a small set of configurations I like to keep backed up, this is what I use, you are welcome to take inspiration from it to your configs.

## Installation

Clone the repo _into your home directory_ (might be able to put it somewhere else, check the `stow` manual if you'd like to do that)

```fish
rm -rf ~/.config/fish ~/.config/helix && stow fish helix
```

The `rm` command is specifically written on the same line as `stow`, otherwise Fish will rewrite the config files before you can stow the new ones.

## Notes

The `fish` config uses new fish features, it might error out on older versions than 4.

Most of the files here aren't acutally in use, I only really stow `fish` and `helix`.

