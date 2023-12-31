# alias cls=clear
abbr cls 'clear'

abbr vimrc 'vim ~/.vimrc'
abbr config.fish 'vim ~/.config/fish/config.fish'
abbr hosts 'sudo view /etc/hosts'
abbr ls 'ls -F'
# time human filetype
abbr ll 'ls -lthF'
abbr testCode 'cd /Users/wsy/testCode'

if status is-interactive
    #run a command every login
    neofetch
end

# 禁用homebrew自动更新
set -gx HOMEBREW_NO_AUTO_UPDATE 1

set -Ux EDITOR vim

function c
    # 如果提供了目录就先到这个目录
    if set -q argv[1]
        cd $argv[1]
    else
    # 默认的话就去desktop找
        cd ~/Desktop
    end

    cd (dirname (fzf --preview 'bat {}'))
end

# fd -t file argument | fzf | xargs vim --not-a-term
function v
    cd ~/Desktop

    #file 是fzf选择的文件
    set file (fzf --preview 'bat {}')

    if test -n "$file"
        vim "$file"
    end
end

function bd
    # 检查输入的参数数量
    if test (count $argv) -eq 0
        # 如果没有提供任何参数，就默认返回上一级目录
        cd ..
    else
        # 获取输入的目录名并转换为小写
        set target_dir (echo $argv[1] | tr '[:upper:]' '[:lower:]')

        # 获取当前目录路径
        set current_dir (pwd)

        # 从当前目录开始向上追溯到根目录
        while test "$current_dir" != "/"
            # 获取当前目录的目录名（最后一级目录）并转换为小写
            set base_name (basename $current_dir)
            set base_name (echo $base_name | tr '[:upper:]' '[:lower:]')

            # 检查是否存在匹配的目录名（忽略大小写的模糊匹配）
            if string match -q -- "*$target_dir*" $base_name
                # 如果匹配成功，就移动到该目录
                cd $current_dir
                return
            end

            # 向上进入父目录
            set current_dir (dirname $current_dir)
        end

        # 如果在搜索过程中未找到匹配的目录，则给出相应提示信息
        echo "Directory not found."
    end
end
