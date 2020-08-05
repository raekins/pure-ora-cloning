Hostname=`hostname`

clear

if [ $Hostname != "z-oracle2" ]
then
	echo -e "\n\n\nScript needs to be run on hostname z-oracle2, exiting...\n\n\n"
	exit
fi

echo "Checking......"
ct=$(ps -ef|grep smon|grep slob|grep -v grep)
if [ "${#ct}" -gt 0 ]; then
  ./0_shutdown.sh
fi
clear
echo "                        /------------------------\                       "
echo "                       /++++++++++++++++++++++++++\                      "
echo "                      /++++++++++++++++++++++++++++\                     "
echo "                     /++++++++++++++++++++++++++++++\                    "
echo "                    /++++++++++++++++++++++++++++++++\                   "
echo "                   /++++++++++++/---------\+++++++++++\                  "
echo "                  /++++++++++++/           \+++++++++++\                 "
echo "                 /++++++++++++/             \+++++++++++\                "
echo "                /++++++++++++/               \+++++++++++\               "
echo "               /++++++++++++/                 \+++++++++++\              "
echo "               \++++++++++++\                 /+++++++++++/              "
echo "                \++++++++++++\               /+++++++++++/               "
echo "                 \++++++++++++\             /+++++++++++/                "
echo "                  \++++++++++++\           /+++++++++++/                 "
echo "                   \++++++++++++\         /-----------/                  "
echo "                    \++++++++++++\                                       "
echo "                     \++++++++++++\                                      "
echo "                      \++++++++++++\                                     "
echo "                       \++++++++++++\                                    "
echo "                        \------------\                                   "
echo " "
echo " "
echo "           Oracle Database Cloning Demo using Pure Snapshot              "
echo " "
echo "            Rapid Clone - Clone and change Database name on Target server  "
echo "  "
echo "    +---------------------------------+        +---------------------------------+   "
echo "    |           Source DB             |        |           Target DB             |  "
echo "    |                                 |        |                                 |  "
echo "    |       Hostname: z-oracle1       |  ===>  |        Hostname: z-oracle2      |  "
echo "    |       Database: oraslob         |  ===>  |        Database: devslob        |  "
echo "    |                                 |        |                                 |  "
echo "    | DB files: /u02/oradata/oraslob  |        | DB files: /u02/oradata/devslob  |"
echo "    | Logfiles: /u03/redologs/oraslob |        | Logfiles: /u03/redologs/devslob |"
echo "    +---------------------------------+        +---------------------------------+  "
echo " "
echo " "
echo "                      +-----------------------------------+ "
echo "                      |              Storage              | "
echo "                      |        Pure Storage - //m20       | "
echo "                      |          se-emea-ebc-fam20        | "
echo "                      +-----------------------------------+ "
echo " "
echo -e "Press Enter to continue \c"
read key
clear
echo " "
echo " High level Steps "
echo " "
echo " 1. Gather user inputs for validation "
echo " "
echo " 2. Unmount the filesystem on target server (if mounted)"
echo " "
echo " 3. Take snapshot of the source volumes on Pure"
echo " "
echo " 4. Mount the cloned volumes on target server"
echo " "
echo " 5. Bring up the database on target server in mount mode"
echo " "
echo " 6. Change the database name using nid"
echo " "
echo " 7. Rename the directories on cloned database "
echo " "
echo " 8. Bring up the database & change filenames"
echo " "
echo " 9. Validate the records on cloned database "
echo " "
echo " "
echo " "
echo -e "Press Enter to continue \c"
read key
clear
echo " "
echo "Step 1:  Gather User inputs for validation"
echo " "
echo "         Enter user data into Source DB   "
echo "        "
./1_insrec.sh
echo " "
echo -e "Press Enter to continue \c"
read key
clear
date '+%m/%d/%Y %H:%M:%S'
sdate=$(date +"%s")
echo "Unmounting filesystems...."
echo " "
./2_unmountfs.sh
echo " "
date "+%m/%d/%Y %H:%M:%S"
echo "Taking snapshot of oraslob volumes"
./3_puresnap.sh
echo " "
date "+%m/%d/%Y %H:%M:%S"
echo "Mounting filesystems ..."
./4_mountfs.sh
echo " "
date "+%m/%d/%Y %H:%M:%S"
echo "Open the database in z-oracle2 and set it to mount mode"
echo " "
./5_startup.sh
echo " "
date "+%m/%d/%Y %H:%M:%S"
echo "Invoking nid to change the database name"
./6_dbnewid.sh
echo " "
date "+%m/%d/%Y %H:%M:%S"
echo "Rename the directories to devslob"
./7_renfs.sh
echo " " 
date "+%m/%d/%Y %H:%M:%S"
echo "Bring up the devslob database and change filenames"
echo " "
./8_rendbfiles.sh
echo " "
edate=$(date +"%s")
echo -e "Press Enter to continue \c"
read key
clear
echo "Validate the records"
./9_showrec.sh
echo " "
date "+%m/%d/%Y %H:%M:%S"
echo " "
echo " "
ddiff=$(($edate-$sdate))
echo "Total Time: $(($ddiff / 60)) minutes and $(( $ddiff % 60 )) seconds"
echo " "
echo -e "Press Enter to continue \c"
read key
./0_shutdown.sh &
