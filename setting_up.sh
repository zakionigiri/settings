#!/bin/bash

SETTINGS_DIR=$(pwd)
CONFIG_DIR=${XDG_CONFIG_HOME}

function func_start() {
  echo "**********Func Start(${FUNCNAME[1]})************"
}

function func_end() {
  echo "***********Func End(${FUNCNAME[1]})*************"
}

function testing () {
	local args=($@)
	local func=${args[1]}
	local funcArgs="${args[@]:2}"

	printf "testing func %s\n" "$func"
	"${func}" "${funcArgs[*]}"
}

function mkdir_if_not_exist() {
  func_start 
	dir=$1
	printf "dir=%s\n" ${dir}
	if test "${dir}" ;then
    func_end
		return
	fi
	mkdir ${dir}
	echo "Directory ${dir} created"
	fund_end 
}

function install_zsh_template() {
  func_start

  curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

  THEME_PATH=${HOME}/.oh-my-zsh/custom/themes/powerlevel10k
  if [ ! -e ${THEME_PATH} ]; then
    echo "Installing the theme (powelevel10k)"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  else
    echo "powerlevel10k already installed. skipping"
  fi

  func_end
}

function link_dotfiles() {
  func_start
	cd ${SETTINGS_DIR}
  	mkdir_if_not_exist ${CONFIG_DIR} && ln -snfv ${SETTINGS_DIR}/nvim ${CONFIG_DIR}/nvim
	
	pushd dots
	for f in .??*; do
    [[ ${f} = ".git" ]] && continue
    [[ ${f} = ".gitignore" ]] && continue
    ln -snfv ${SETTINGS_DIR}/dots/${f} ${HOME}/${f}
    source ${f} 2>/dev/null
	done

  popd
	func_end
}

function link_cmds() {
  func_start
	pushd cmds
	for f in *.sh; do
    local cmdname=$(echo ${f} | sed 's/\.sh//')
    ln -snfv ${SETTINGS_DIR}/cmds/${f} /usr/local/bin/${cmdname}
    source ${f} 2>/dev/null
	done
  popd
	func_end
}

function run() {
	echo "===============Start Running======================="

	printf "SETTINGS_DIR=%s\n" ${SETTINGS_DIR}
	if [ -z ${SETTINGS_DIR} ]; then 
		echo "Please provide the path to the settings directory"
		return 
	elif [ -z ${CONFIG_DIR} ]; then
		echo "Please provide XDG_CONFIG_HOME environment variable"
	 	return 	
	fi

  case ${SHELL} in
    *zsh) echo "Your default shell is zsh. setting up..." && install_zsh_template ;;
    *) echo "Your default shell is not zsh. skipping. (as this script only contains configurations for zsh)" ;;
  esac

  link_dotfiles
  link_cmds
	
	echo "Done setting links"
	echo "===============Stop Running======================="
}

[[ -z $1 ]] && cat <<EOF
Please provide one of the subcommands below.
	run : run the script. 
	test <func_name> <...args>: unit test a function.
EOF

[[ $1 = "test" ]] && testing $@
[[ $1 = "run" ]] && run
