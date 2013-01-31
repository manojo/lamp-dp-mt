# init_users.csh (WARNING: not tested yet)
#
# Then put in your .cshrc  the following line: 
#     setenv  MMALPHA yourMMAlphaDirectory
#     source $MMALPHA/config/init_users.csh
echo "exec init_users.csh" 

if (! $?MANPATH)  setenv MANPATH
setenv PATH ${MMALPHA}/bin.${OSTYPE}:${PATH} 
setenv  MANPATH ${MANPATH}:${MMALPHA}/man 

