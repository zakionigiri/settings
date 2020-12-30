#!/bin/bash

SETTINGS_DIR=$(pwd)
CONFIG_DIR=${XDG_CONFIG_HOME}

function testing () {
	local args=($@)
	local func=${args[1]}
	printf "testing func %s\n" "$func"
	funcArgs="${args[@]:2}"
	"${func}" "${funcArgs[*]}"
}

function mkdir_if_not_exist() {
	echo "**********Func Start************"

	echo "func name=mkdir_if_not_exist"
	dir=$1
	printf "dir=%s\n" ${dir}
	if test "${dir}" ;then
		echo "**********Func End************"
		return
	fi
	mkdir ${dir}
	echo "Directory ${dir} created"
	echo "**********Func End************"
}

function run() {
	echo "===============Start Running======================="
	printf "SETTINGS_DIR=%s\n" $SETTINGS_DIR
	if [ -z ${SETTINGS_DIR} ]; then 
		echo "Please provide the path to the settings directory"
		echo "===============Stop Running======================="
		return 
	elif [ -z ${CONFIG_DIR} ]; then
		echo "Please provide XDG_CONFIG_HOME environment variable"
		echo "===============Stop Running======================="
	 	return 	
	fi
	
	cd ${SETTINGS_DIR}
  	mkdir_if_not_exist ${CONFIG_DIR} && ln -snfv ${SETTINGS_DIR}/nvim ${CONFIG_DIR}/nvim
	
	cd dots
	for f in .??*; do
 	[[ ${f} = ".git" ]] && continue
 	[[ ${f} = ".gitignore" ]] && continue
	ln -snfv ${SETTINGS_DIR}/dots/${f} ${HOME}/${f}
	done
	
	echo "Done setting links"
	echo "===============Stop Running======================="
}

[[ -z $1 ]] && cat <<EOF
Please provide one of the subcommands below.
	run <dotfile_dir>: run the script. dotfile_dir should be an absolute path.
	test <func_name> <...args>: unit test a function.
EOF

[[ $1 = "test" ]] && testing $@
[[ $1 = "run" ]] && run
