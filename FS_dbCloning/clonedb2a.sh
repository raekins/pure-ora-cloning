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
echo " 1. Shutdown Target database"
eco " "
echo " 2. Gather user inputs for validation "
echo " "
echo " 3. Unmount the filesystem on target server (if mounted)"
echo " "
echo " 4. Take snapshot of the source volumes on Pure"
echo " "
echo " 5. Mount the cloned volumes on target server"
echo " "
echo " 6. Bring up the database on target server in mount mode"
echo " "
echo " 7. Change the database name using nid"
echo " "
echo " 8. Rename the directories on cloned database "
echo " "
echo " 9. Bring up the database & change filenames"
echo " "
echo "10. Validate the records on cloned database "
echo " "
echo " "
echo " "
echo -e "Press Enter to continue \c"
read key
clear
echo " "
echo "Setp 1: Shutdown Target database"
echo " "
./1_shutdown.sh
echo "Step 2:  Gather User inputs for validation"
echo " "
echo "         Enter user data into Source DB   "
echo "        "
./2_insrec.sh
echo " "
echo -e "Press Enter to continue \c"
read key
clear
date '+%m/%d/%Y %H:%M:%S'
sdate=$(date +"%s")
echo "Unmounting filesystems...."
echo " "
./3_unmountfs.sh
echo " "
date "+%m/%d/%Y %H:%M:%S"
echo "Taking snapshot of Source volumes"
./4_puresnap.sh
echo " "
date "+%m/%d/%Y %H:%M:%S"
echo "Mounting filesystems ..."
./5_mountfs.sh
echo " "
date "+%m/%d/%Y %H:%M:%S"
echo "Open the database on Target server and set it to mount mode"
echo " "
./6_startup.sh
echo " "
date "+%m/%d/%Y %H:%M:%S"
echo "Invoking nid to change the database name"
./7_dbnewid.sh
echo " "
date "+%m/%d/%Y %H:%M:%S"
echo "Rename the database directories"
./8_renfs.sh
echo " " 
date "+%m/%d/%Y %H:%M:%S"
echo "Bring up the target database and change filenames"
echo " "
./9_rendbfiles.sh
echo " "
edate=$(date +"%s")
echo -e "Press Enter to continue \c"
read key
clear
echo "Validate the records"
./10_showrec.sh
echo " "
date "+%m/%d/%Y %H:%M:%S"
echo " "
echo " "
ddiff=$(($edate-$sdate))
echo "Total Time: $(($ddiff / 60)) minutes and $(( $ddiff % 60 )) seconds"
echo " "
