export MYSQL=/usr/local/mysql
export MYSQLCOM=/Library/StartupItems/MySQLCOM/MySQLCOM
export PATH=$PATH:$MYSQL/bin:/usr/local/bin
test -r /sw/bin/init.sh && . /sw/bin/init.sh

# adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

export GITHUB_NAME=yourname
export JEWELER_OPTS="--rspec"
export AUTOFEATURE=true

source bash_scripts/include_helpers.sh
