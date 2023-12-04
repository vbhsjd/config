# maven
set -x MAVEN_HOME /Users/wsy/apache-maven-3.9.5
set -x PATH $MAVEN_HOME/bin $PATH

# alias cls=clear
abbr cls 'clear'

abbr vimrc 'vim ~/.vimrc'
abbr config.fish 'vim ~/.config/fish/config.fish'
abbr hosts 'sudo vim /etc/hosts'

# 禁用homebrew自动更新
set -gx HOMEBREW_NO_AUTO_UPDATE 1

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


# 用于替代grep
#function f
#    # 如果提供了文件名作为参数
#    if test (count $argv) -gt 0
#        set filename $argv[1]
#        cat $filename | fzf --tac --multi
#    else
#        set selected_file (fzf --preview 'bat {}')
#        if test -n "$selected_file"
#            cat $selected_file | fzf --tac --multi
#        end
#    end
#end

# 每次打开终端先执行neofetch
neofetch
