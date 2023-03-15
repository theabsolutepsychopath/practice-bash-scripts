#!/bin/bash

# THIS VERSION REQUIRES YOU TO INPUT THE PACKAGE NAME OF THE GAME YOU WANT TO INSTALL. THE FINAL VERSION "obbcheck.sh" 
# WILL HAVE AUTOMATIC PACKAGE DETECTION AND WILL ALLOW YOU TO SELECT FROM THERE.


run=0
confirmationffa()
{
select confirmitbitch in "Yes" "No"
do
    case $confirmitbitch in
        Yes)
            echo "Alright! Lets get started."; break;;
        No)
            ffatextcheck1
    esac
done
}

returntotextcheck()
{
    ffatextcheck1
}

#CHANGE CHECKOBBSQUEST TO ADB SHELL LS WHEN POSSIBLE

checkobbsquest()
{
obbtransfered="$(ls "/root/fakedroid/obbs/$packagename/")"
touch verifyobbnames.txt
ls -q "/root/fakedroid/obbs/$packagename/" | cat > verifyobbnames.txt
checkobbspc
}

checkobbspc()
{
obborigin="$(ls "/mnt/c/Program Files (x86)/NIFE/QLoader/downloads/$ffaresultz/$packagename/")"
touch verifyobbnames.txt
ls -q "/mnt/c/Program Files (x86)/NIFE/QLoader/downloads/$ffaresultz/$packagename/" | cat > obbnames.txt
verify
}

verify()
{
if [[ "$obborigin" = "$obbtransfered" ]];
then echo "Your OBBS are complete and everything should be running as intended. If you are having an issue, please ask in chat and list what you are missing so we can fix the issue."
else echo "Your OBBS did not transfer properly from your computer to your Quest. Please replace your cable and retry installation."; missing;
fi
}

missing()
{
MISSINGOBBNAMES="$(diff verifyobbnames.txt obbnames.txt)"
echo "$MISSINGOBBNAMES" | cat > missingobbnames.txt
echo "MISSING OBBS:"
cat missingobbnames.txt | grep "> "
}

echo "PLEASE MAKE SURE YOU HAVE ADB DEBUGGING ENABLED ON YOUR QUEST AND THE GAME YOU ARE TRYING TO VERIFY BOTH INSTALLED ON THE HEADSET AND CASHED IN YOUR QLOADER DIRECTORY."
read -n 1 -r -s -p $'Press any key to acknoledge this.'

ffatextcheck1()
{
clear
run=1
echo "Please type the package name of the game you would like to verify. (e.x com.beatgames.beatsaber)"
read -r packagename
if grep -q "$packagename" "/mnt/c/Program Files (x86)/NIFE/Loader/FFA.txt"
then
    ffatextcheck2
else
    echo "There are no games with this package name on Loader. (Maybe you typed it wrong?)"
    sleep 3
    returntotextcheck
fi
}

ffatextcheck2()
{
ffaresults="$(cat "/mnt/c/Program Files (x86)/NIFE/Loader/FFA.txt" | grep "$packagename")"
touch ffaresults.txt
echo "$ffaresults" > ffaresults.txt
sed -i 's/;[^;]*//2g' ffaresults.txt
sed -i 's/^[^;]*;//' ffaresults.txt
mapfile -t results < ffaresults.txt
results+=( "None" )
echo "Please select the version of the game from Loader you have installed. (Some games have addons like BMBF. If you installed that version, pick that version and not the regular version.)"
select ffaresultz in "${results[@]}"
do
    if [[ $ffaresultz == "None" ]]
        then
            echo "Sending you back to the packagename screen."
            sleep 2
            returntotextcheck
            break
        else
            echo "You have selected $ffaresultz. Is this right?"
            confirmationffa
            break
        fi
done
sleep 2
checkobbsquest
}

if [[ "$run" == "0" ]]; then
ffatextcheck1
fi

rm ffaresults.txt
rm obbnames.txt
rm verifyobbnames.txt