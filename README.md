# Thesis Template

This is a Latex thesis template based on the [Master thesis
template](http://www.physik.uni-heidelberg.de/studium/master/vorlagen) of the
faculty for physics and astronomy of Heidelberg University.

A few features and configurations are added.

## Table of contents
  * [Requirements](#requirements)
  * [Main Latex Documents](#main-latex-documents)
  * [Folder Structure](#folder-structure)
  * [init.sh and Makefiles](#init-sh-and-makefiles)
  * [Latex Configurations and Tricks](#latex-configurations-and-tricks)
  * [Vim Plugins](#vim-plugins)

## Requirements

This template was tested and used in Debian 9.

`texlive` package is required to have a latex system.
Installing `texlive-full` package is recommended.

`latexmk` package is required for compiling the latex documents.

`qpdfview` package is required to view the document with the `vimtex` plugin.
The corresponding setting can be changed if other PDF viewer is preferred.
Check the `vimtex` plugin help file in Vim for more details.

`Inkscape` was used to drawing figures. A Makefile is provided to convert the
.svg files to .pdf files.

## Main Latex Documents

There are three main Latex documents in this repository:
1. `dissertation.tex`: the main document for the thesis.
2. `separated_pages.tex`: the main document for separating pages out of the
   thesis pdf file.  
   Run `texdoc pdfpages` in the command line for more details.
3. `standalone_test.tex`: the main document for trying out figures with the
   standalone package.  
   Run `texdoc standalone` in the command line for more details.

## Folder Structure 

The directory are organized as follow:
- The chapters of the thesis are put into their own sub-folders.
- The figures for each chapter should be put in the `figures/` folder in each
chapter sub-folder.
- The Inkscape drawings should be put in the `drawings/` folder in each chapter
sub-folder.

## init.sh and Makefiles

- `init.sh`: this bash script instruct git not to touch the `separated_pages.tex`
  and `standalone_test.tex`, which are changed from time to time.
- `Makefile`: the Makefile to compile the thesis and the separate pages.
  The document can also be compiled with the vimtex plugin with Vim. More details
  in the [Vim Plugins](#vim-plugins) section.
- `Makefile.inkscape`: the Makefile to generate .pdf files from the Inkscape
  .svg files once there is any update in the .svg files.  
  Run with the command `make -f Makefile.inkscape`.


## Latex Configurations and Tricks

The configurations of the thesis latex document are in `setup/preamble.tex`
file.

Some tricks are shown in the **Appendix** part of the [example thesis PDF file](dissertation.pdf).

## Vim Plugins

I used Vim (neovim) for editing the latex files. I recommend the following
three plugins for this task:
1. [lervag/vimtex](https://github.com/lervag/vimtex): Plugin for editing Latex
   files in Vim/neovim.
2. [Shougo/deoplete.nvim](https://github.com/Shougo/deoplete.nvim): Plugin for
   automatic completion. This plugin is for neovim/Vim8.  
   A similar plugin for Vim7 is
   [Shougo/neocomplete.vim](https://github.com/Shougo/neocomplete.vim).
3. [ujihisa/neco-look](https://github.com/ujihisa/neco-look): Plugin for
   English words completion.


The configurations for above plugins are:

- **Latex and vimtex**:

```vim
" latex {{{
" Vim will generally autodetect filetypes automatically.  In most cases this
" works as expected, however, in some cases it will detect a file with the `tex`
" suffix as a |plaintex|.  To prevent this, one may set the option
" g:tex_flavor| in ones `vimrc` file, that is:
let g:tex_flavor = 'latex'

" truncate the length of the line
autocmd Filetype tex setlocal textwidth=79
autocmd Filetype tex setlocal spell
autocmd Filetype tex setlocal softtabstop=2 tabstop=2 sw=2
autocmd Filetype tex setlocal breakindent

" to format the tex such that vim insert a line break afte each sentence
function! AddSentenceMaps()
  imap .<Space> .<CR>
  imap !<Space> !<CR>
  imap ?<Space> ?<CR>
endfunction
autocmd Filetype tex call AddSentenceMaps()


" for vimtex
let g:vimtex_view_general_viewer = 'qpdfview'
let g:vimtex_view_general_options = '--unique @pdf\#src:@tex:@line:@col'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_compiler_latexmk = {
        \ 'backend' : 'nvim',
        \ 'background' : 1,
        \ 'build_dir' : '',
        \ 'callback' : 1,
        \ 'continuous' : 1,
        \ 'executable' : 'latexmk',
        \ 'options' : [
        \   '-pdf',
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}
"" about folding with vimtex
let g:vimtex_fold_enabled = 1
"" close the brace after completion
let g:vimtex_complete_close_braces = 1
"" set the width of the index window
let g:vimtex_index_split_width = 50
"" not open quickfix windwow when there is only warning
let g:vimtex_quickfix_open_on_warning = 0
"" disable recursive searching for main file
let g:vimtex_disable_recursive_main_file_detection = 1

if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
" }}}
```

- **deoplete**:

```vim
if has('nvim')
	"  deoplete{{{
	let g:deoplete#enable_at_startup = 1
	let g:deoplete#auto_complete_delay = 0
	" Use smartcase.
	let g:deoplete#enable_smart_case = 1
	" use head matching but not fuzzy matching
	call deoplete#custom#source('_', 'matchers', ['matcher_head'])

	"use tab for auto completion
	let g:deoplete#disable_auto_complete = 0
	inoremap <silent><expr> <TAB>
				\ pumvisible() ? "\<C-n>" :
				\ <SID>check_back_space() ? "\<TAB>" :
				\ deoplete#mappings#manual_complete()
	function! s:check_back_space() abort "{{{
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~ '\s'
	endfunction "}}}
	" }}}
endif
```
