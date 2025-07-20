
# set a custom git bash window terminal title
echo -n "Enter window title for TITLEPREFIX (or press Enter to skip): "
read title_input
if [ -n "$title_input" ]; then
    export TITLEPREFIX="$title_input"
    echo "TITLEPREFIX set to: $TITLEPREFIX"
else
    echo "No TITLEPREFIX set"
fi


