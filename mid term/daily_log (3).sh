#Daily Log and Archive Script
 -------------------------------

 # Step 1: Identify user
 USER_NAME=$(whoami)
 echo "Script run by: $USER_NAME"

 # Step 2: Create log directory and save daily log
 LOG_DIR="/mnt/c/Users/LENOVO/OneDrive/Documents/linux lab/dailylogs"
 ARCHIVE_DIR="$LOG_DIR/archive"

 mkdir -p "$LOG_DIR" "$ARCHIVE_DIR"

 LOGFILE="$LOG_DIR/log_$(date +%Y-%m-%d).txt"

 {
   echo "----------------------------------------"
     echo "User: $USER_NAME"
       echo "Date: $(date)"
         echo "----------------------------------------"
           echo
             echo "Uptime:"
               uptime
                 echo
                   echo "Top 5 CPU processes:"
                     ps -eo pid,comm,%mem,%cpu --sort=-%cpu | head -n 6
                       echo
                         echo "Disk usage:"
                           df -h
                             echo "----------------------------------------"
                             } > "$LOGFILE"

                             echo " Daily log saved: $LOGFILE"

                             # Step 3: Weekly archive (on Monday)
                             DAY_OF_WEEK=$(date +%u)  # 1 = Monday
                             ARCHIVE_FILE="$ARCHIVE_DIR/weeklylogs_$(date +%Y-%m-%d).tar.gz"

                             if [ "$DAY_OF_WEEK" -eq 1 ]; then
                               if [ ! -f "$ARCHIVE_FILE" ]; then
                                   tar -czf "$ARCHIVE_FILE" -C "$LOG_DIR" --exclude='archive' .
                                       echo " Weekly archive created: $ARCHIVE_FILE"
                                         else
                                             echo " Archive for today already exists: $ARCHIVE_FILE"
                                               fi
                                               fi

                                               # Step 4: Move logs older than 7 days
                                               echo "Checking for old logs to move..."
                                               find "$LOG_DIR" -type f -name "log_*.txt" -mtime +7 -exec mv {} "$ARCHIVE_DIR/" \; -exec echo "Moved {} to archive" \;

                                               # -------------------------------
                                               # Manual Menu for Operations
                                               # -------------------------------
                                               echo ""
                                               echo "Select an option:"
                                               echo "1) Archive all logs manually"
                                               echo "2) Move logs older than 7 days manually"
                                               echo "3) View latest log"
                                               echo "4) Exit"
                                               read -p "Enter your choice (1-4): " choice

                                               case $choice in
                                                 1)
                                                     echo "Archiving all logs..."
                                                         MANUAL_ARCHIVE="$ARCHIVE_DIR/manual_archive_$(date +%Y-%m-%d_%H-%M-%S).tar.gz"
                                                             tar -czf "$MANUAL_ARCHIVE" -C "$LOG_DIR" --exclude='archive' .
                                                                 echo " Manual archive created: $MANUAL_ARCHIVE"
                                                                     ;;
                                                                       2)
	                                                                           echo "Moving logs older than 7 days to archive..."
	                                                                               find "$LOG_DIR" -type f -name "log_*.txt" -mtime +7 -exec mv {} "$ARCHIVE_DIR/" \; -exec echo "Moved {} to archive" \;
	                                                                                   ;;
                                                                                     3)
	                                                                                         echo ""
	                                                                                             echo "----------------------------------------"
	                                                                                                 echo " Latest log content:"
	                                                                                                     echo "----------------------------------------"
	                                                                                                         cat "$LOGFILE"
	                                                                                                             echo "----------------------------------------"
	                                                                                                                 ;;
                                                                                                                   4)
	                                                                                                                       echo " Exiting..."
	                                                                                                                           exit 0
	                                                                                                                                                                                                                                                   ;;                                                                                                                                                                                                               *)
	                                                                                                                                     echo " Invalid choice!"
	                                                                                                                                         ;;
	                                                                                                                                         esac
	
