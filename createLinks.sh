#!/bin/bash

DOTFILE_DIR=$2
CONFIG_DIR=${XDG_CONFIG_HOME}

function testing () {
	local args=($@)
	local func=${args[1]}
	printf "testing func %s\n" "$func"
	funcArgs="${args[@]:2}"
	"${func}" "${funcArgs[*]}"
}

function mkdir_if_not_exist() {
	dir=$1
	printf "dir=%s\n" ${dir}
	if test "${dir}" ;then
		echo "Directory ${dir} already exists"
		return
	fi
	mkdir ${dir}
	echo "Directory ${dir} created"

}


function run() {
	printf "DOTFILE_DIR=%s\n" $DOTFILE_DIR
	if [ -z ${DOTFILE_DIR} ]; then 
		echo "Please provide the path to the dotfile directory"
		exit 0
	elif [ -z ${CONFIG_DIR} ]; then
		echo "Please provide XDG_CONFIG_HOME environment variable"
	fi
	
	cd ${DOTFILE_DIR}
	
	for f in ??*; do
  	[[ ${f} = ".git" ]] && continue
 	[[ ${f} = ".gitignore" ]] && continue
  	[[ ${f} = "init.vim" ]] && mkdir_if_not_exist ${CONFIG_DIR}/nvim && ln -snfv ${DOTFILE_DIR}/${f} ${CONFIG_DIR}/nvim/${f}
	done
	
	echo "Done setting links"
}


[[ -z $1 ]] && cat <<EOF
Please provide one of the subcommands below.
	run <dotfile_dir>: run the script. dotfile_dir should be an absolute path.
	test <func_name> <...args>: unit test a function.
EOF

[[ $1 = "test" ]] && testing $@
[[ $1 = "run" ]] && run
