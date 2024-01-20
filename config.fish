# 1. Environment variables
set -gx HOMEBREW_NO_AUTO_UPDATE 1
set -Ux EDITOR vim

# 2. Alias
alias a alias
alias cls 'clear'
alias ls 'ls -F --color'
# time human filetype
alias ll 'ls -lthF --color'

alias vimrc 'vim ~/.vimrc'
alias config.fish 'vim ~/.config/fish/config.fish'
# visudo
alias hosts 'sudo view /etc/hosts'
alias testCode 'cd /Users/wsy/testCode'

if status is-interactive
    #run a command every login
    neofetch
end

#function goodbye --on-event exit
#   echo "情绪低落可是 NoNo!"
#end

# 3. Functions
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

function del
    # 获取最近的 ls 命令
    set -l last_ls (history | grep '^ls' | head -n 1)

    # 检查是否找到 ls 命令
    if test -z "$last_ls"
        echo "没有找到最近的 ls 命令。"
        return 1
    end

    # 替换 ls 为 rm
    set -l cmd_rm (string replace 'ls' 'rm' -- $last_ls)

    # 显示即将执行的 rm 命令
    echo "执行: $cmd_rm"
    eval $cmd_rm
    echo "文件已删除。"

    # 确认是否执行
    #read -p "continue? (y/N): " confirm
    #switch $confirm
    #case Y y
    #eval $cmd_rm
    #echo "文件已删除。"
    #case '*'
    #echo "操作已取消。"
    #end
end
