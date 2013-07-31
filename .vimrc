" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/vundle/
call vundle#rc()
let g:vundle_default_git_proto = 'git'

Bundle 'Align'
Bundle 'mileszs/ack.vim'
Bundle 'eregex.vim'
Bundle 'YankRing.vim'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'mru.vim'
Bundle 'minibufexpl.vim'
Bundle 'banyan/Nonopaste.vim'
Bundle 'Puppet-Syntax-Highlighting'
Bundle 'sudo.vim'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'
Bundle 'glidenote/memolist.vim'
Bundle 'fuenor/qfixgrep'
Bundle 'tpope/vim-markdown'
Bundle 'Lokaltog/vim-powerline'
"Bundle 'bling/vim-airline'
"Bundle 'tangledhelix/vim-octopress'

syntax on
filetype plugin on
filetype indent on

set t_Co=256
colorscheme default

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" show the cursor position all the time
set ruler

" always set autoindenting on
set autoindent

" keep 150 lines of command line history
set history=150

" dictionary
set dict=/usr/share/dict/words

" encode
set encoding=utf-8
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=utf-8,euc-jp,iso-2022-jp,latin1
endif

" :も単語の一部とみなす(module名補完用)
set iskeyword+=:

" タブ幅の設定
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" psgiもperlとして
au BufRead,BufNewFile *.psgi  set filetype=perl
" testふぁいるもperlとして
au BufRead,BufNewFile *.t  set filetype=perl

" rubyはtab幅2
au FileType ruby set ts=2 sts=2 sw=2

" puppetはtab幅2
au FileType puppet set ts=2 sts=2 sw=2

" markdownでoctpressのsysntaxプラグインのハイライトを利用
" 何故かうまく動かない。
"au BufRead,BufNewFile *.md  set filetype=octpress

" モードライン無効
set modelines=0

"インデントはスマートインデント
set smartindent

"検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase

"検索文字列に大文字が含まれている場合は区別して検索する
set smartcase

"検索時に最後まで行ったら最初に戻る
set wrapscan

"検索文字列入力時に順次対象文字列にヒットさせない
set noincsearch

"タブの左側にカーソル表示
"set listchars=tab:\\ 

"タブや改行を表示しない
set nolist

"入力中のコマンドをステータスに表示する
set showcmd

"カーソル上の括弧をハイライトしない。
let loaded_matchparen = 1

"括弧入力時の対応する括弧を表示
"set showmatch

"検索結果文字列のハイライトを有効
set hlsearch

"ステータスラインを常に表示
set laststatus=2

" コマンドライン補間をシェルっぽく
set wildmode=list:longest

" バッファが編集中でもその他のファイルを開けるように
set hidden

" 外部のエディタで編集中のファイルが変更されたら自動で読み直す
set autoread

"表示行単位で行移動する
nmap j gj
nmap k gk
vmap j gj
vmap k gk

" tabでsetnumをトグル
nmap <C-i> :<C-u>set number!<CR>
",w でそのコマンドを保存
nmap ,w :w<CR>
" nmap ,ww :w<CR>
",e でそのコマンドを保存実行
nmap ,e :w<CR>:execute '!' &ft '%'<CR>
",r でperl実行。
nmap ,r :w<CR>:!perl -Ilib -Mlib=local/lib/perl5 -Mlib=extlib/lib/perl5 %<CR>
",t でprove実行。
nmap ,t :w<CR>:!prove -lv %<CR>
",c でperlのシンタックスチェック
nmap ,c :w<CR>:!perl -Ilib -Mlib=local/lib/perl5 -Mlib=extlib/lib/perl5 -c %<CR>
",g でcをコンパイル、実行
nmap ,g :w<CR>:!gcc -o ./%.out %<CR>:! ./%.out<CR>
",d で日付挿入
nmap ,d :r !LANG=C date '+\%Y-\%m-\%d \%T\n'<CR>

",p でベロッと貼り付けモード
nmap ,p :set paste<CR>i
"インサートモードから抜ける時に自動的に nopaste に戻す
autocmd InsertLeave * set nopaste

" 一発リネーム
"09/06/08 http://vim-users.jp/2009/05/hack17/
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

" mru open履歴
"10/09/05 http://nanasi.jp/articles/vim/mru_vim.html
let MRU_Max_Entries=30
let MRU_Window_Height=20

" 全削除
nnoremap da :<C-u>%d<CR>

"Escの2回押しでハイライト消去
nmap <ESC><ESC> :<C-u>noh<CR>

" Ctrl-J/K で上下左右のWindowへ移動
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-H> <C-W>h
nmap <C-K> <C-W>k

" 初期状態を自動生成
autocmd BufNewFile *.pl 0r ~/.vim/skel/pl
autocmd BufNewFile *.pm 0r ~/.vim/skel/pm
autocmd BufNewFile *.sh 0r ~/.vim/skel/sh
autocmd BufNewFile *.pp 0r ~/.vim/skel/pp

"全角スペースを表示
highlight ZenkakuSpace ctermbg=white
match ZenkakuSpace /　/

"Tab、行末の半角スペースを明示的に表示する。
set list
set listchars=tab:^\ ,trail:~

" vim-powerline {{{
" スペシャルシンボルを使わない
let g:Powerline_symbols = 'compatible'
" シンボルを上書きする
let g:Powerline_symbols_override = {
\ 'LINE': 'Caret'
\ }
" モード名を上書きする
let g:Powerline_mode_n = 'Normal'
let g:Powerline_mode_i = 'Insert'
let g:Powerline_mode_R = 'Replace'
let g:Powerline_mode_v = 'Visual'
let g:Powerline_mode_V = 'Visual-Line'
let g:Powerline_mode_cv = 'Visual-Block'
let g:Powerline_mode_s = 'Select'
let g:Powerline_mode_S = 'Select-Line'
let g:Powerline_mode_cs = 'Select-Block'
" ファイルへの相対パスを表示する
let g:Powerline_stl_path_style = 'relative'
" }}}

" for Fugitive {{{
""nnoremap ,gd    : <C-u>Gdiff<Enter>
nnoremap ,gd    :<C-u>w<CR>:Git diff<Enter>
nnoremap ,gdc   :<C-u>w<CR>:Git diff --cached<Enter>
nnoremap ,gs    :<C-u>Gstatus<Enter>
nnoremap ,gst   :<C-u>Gstatus<Enter>
nnoremap ,gl    :<C-u>Glog<Enter>
nnoremap ,ga    :<C-u>Gwrite<Enter>
nnoremap ,gci   :<C-u>Gcommit -a<Enter>
nnoremap ,gc    :<C-u>Gcommit<Enter>
nnoremap ,gC    :<C-u>Git commit --amend<Enter>
nnoremap ,gb    :<C-u>Gblame<Enter>
" }}}

" hasekoのやつ。http://d.hatena.ne.jp/bannyan/20111024/1319420124
let g:nonopaste_url = "http://192.168.25.37/nonopaste/"


"minibufexpl
let g:miniBufExplMapWindowNavVim=1 "hjklで移動
let g:miniBufExplSplitBelow=0  " Put new window above
let g:miniBufExplMapWindowNavArrows=1
let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplModSelTarget=1 
let g:miniBufExplSplitToEdge=1
nnoremap <C-d>    : bd<CR>
nmap <Space>      : MBEbn<CR>
nmap <C-n>        : MBEbn<CR>
nmap <C-p>        : MBEbp<CR>
" yankringとかぶるので、yankringの方を変更
let g:yankring_replace_n_nkey = '<S-n>'
let g:yankring_replace_n_pkey = '<S-p>'
" http://blog.glidenote.com/blog/2012/03/21/yankring.vim-error/
let g:yankring_manual_clipboard_check = 0

" fuf *set pasteと共存不可
let g:fuf_modesDisable = ['mrucmd']
let g:fuf_file_exclude = '\v\~$|\.(o|exe|bak|swp|gif|jpg|png)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
let g:fuf_dir_exclude = '\v\~$|(blib|extlib)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
let g:fuf_mrufile_exclude = '\v\~$|\.bak$|\.swp|\.howm$|\.(gif|jpg|png)$'
let g:fuf_mrufile_maxItem = 10000
let g:fuf_enumeratingLimit = 30
let g:fuf_keyPreview = '<C-]>'
let g:fuf_previewHeight = 0
nmap fb :FufBuffer<CR>
nmap fc :FufFileWithCurrentBuffer<CR>
nmap ff :FufFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
nmap fF :FufFile **/<CR>
nmap fL :FufFile ./lib/**/<CR>
nmap fm :FufMruFile<CR>
nmap fq :FufQuickfix<CR>
nmap fl :FufLine<CR>
nnoremap <silent> <C-]> :FufTag! <C-r>=expand('<cword>')<CR><CR>

" syntastic
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'passive_filetypes': ['perl'] }

" http://blog.glidenote.com/blog/2012/03/26/memolist.vim/
let g:memolist_path = $HOME . "/memolist"
let g:memolist_memo_suffix = "md"
let g:memolist_qfixgrep = "true"
nmap mn  :MemoNew<CR>
nmap ml  :MemoList<CR>
nmap mg  :MemoGrep<CR>
nmap mf  :FufFile <C-r>=expand(g:memolist_path."/")<CR><CR>

