# init_users.bash
#
# Then put in your .bashrc or .profile the following line: 
#     export MMALPHA=yourMMAlphaDirectory
#     source $MMALPHA/config/init_users.bash

echo "exec init_users.bash" 

# should be export PATH=$MMALPHA/bin.${OSTYPE}:$PATH
# But many linux distrib set $OSTYPE to linux-gnu
export PATH=$MMALPHA/bin.linux:$PATH
export MANPATH=${MANPATH}:${MMALPHA}/man



