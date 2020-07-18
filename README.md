# vim-reverso
Apply Reverso's [french] and [english] correction

[french]:https://www.reverso.net/orthographe/correcteur-francais/
[english]:https://www.reverso.net/orthographe/correcteur-anglais/

## Installation
This plugin follows the standard runtime path structure. Below are some
helper lines for popular package managers (you can use `git submodules`
instead of `git clone`):

* [Vim 8 packages](http://vimhelp.appspot.com/repeat.txt.html#packages)
  * `git clone https://github.com/tommoulard/vim-reverso.git ~/.vim/pack/plugins/start/vim-reverso`
* [Pathogen](https://github.com/tpope/vim-pathogen)
  * `git clone https://github.com/tommoulard/vim-reverso.git ~/.vim/bundle/vim-reverso`
* [vim-plug](https://github.com/junegunn/vim-plug)
  * `Plug 'tommoulard/vim-reverso'`
* [Vundle](https://github.com/VundleVim/Vundle.vim)
  * `Plugin 'tommoulard/vim-reverso'`

You must have `curl` and `jq` installed locally

## Usage
With your cursor on a line of text, or a selection of text in visual mode,
`:ReversoSpell` will send the line of text or selection to the Reverso API and
correct the lines with the answer.

You can also use `<leader>t` to correct the selection or line

Do not forget to unselect visually selected text when correction(i.e.
`V5j<Esc><Esc>,t`).

:warning: Reverso API is limited to 2000 char at a time.

## Thanks
I'd like to acknowledge [@jessfraz] and her [openai.vim] for the inspiration.

[@jessfraz]:https://github.com/jessfraz
[openai.vim]:https://github.com/jessfraz/openai.vim
