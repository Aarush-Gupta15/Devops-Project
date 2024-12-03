# Backup Script Guide

---

## Introduction  
This shell script streamlines the task of backing up essential files and directories. It offers features like compression, logging, and automatic cleanup. The script can be run manually or set up as a cron job for scheduled execution.  

---

## Key Features  
1. **Input Parameters:**  
   - **Source Directory:** Location of the files/directories to be backed up.  
   - **Destination Directory:** Where the backup will be stored.  
   - **Compression Option:** Allows creating a `.tar.gz` compressed archive.  

2. **Error Management:**  
   - Ensures the source directory exists.  
   - Automatically creates the destination directory if absent.  

3. **Backup Operations:**  
   - Files are either copied or compressed based on the `--compress` flag.  

4. **Logging:**  
   - Logs all activities and errors in `/var/log/backup_script.log`.  

5. **Automated Cleanup:**  
   - Removes backups older than 7 days from the destination directory.  

---

## How to Use  
### Syntax  
```bash
./backup_script.sh <source_directory> <destination_directory> [--compress]
```  
- **<source_directory>**: Path to files to be backed up.  
- **<destination_directory>**: Path for storing the backup.  
- **--compress**: Optional flag for creating a `.tar.gz` archive.  

### Examples  
- **Without Compression:**  
  ```bash
  ./backup_script.sh /home/user/documents /backups  
  ```  
- **With Compression:**  
  ```bash
  ./backup_script.sh /home/user/documents /backups --compress  
  ```  

---

## Setting Up a Cron Job  
1. Open the cron editor:  
   ```bash
   crontab -e  
   ```  
2. Schedule the script to run daily at 2:00 AM:  
   ```bash
   0 2 * * * /path/to/backup_script.sh /source /destination --compress  
   ```  

---

## Log File Location  
- All actions and errors are saved in:  
  ```plaintext
  /var/log/backup_script.log  
  ```  

---

## Script Details  
1. **Backup File Naming:**  
   - `backup_<YYYY-MM-DD_HH-MM-SS>` for regular backups.  
   - `backup_<YYYY-MM-DD_HH-MM-SS>.tar.gz` for compressed backups.  

2. **Old Backup Removal:**  
   - Automatically deletes files older than 7 days.  

---

## Requirements  
- Linux/Unix system.  
- Read/write permissions for source and destination directories.  
- Cron service enabled for scheduling.  

---

## Customization Options  
- Change the log file location if needed (`/var/log/backup_script.log`).  
- Modify the retention period (currently 7 days) by adjusting the `find` command:  
  ```bash
  find "$DEST_DIR" -type f -mtime +7 -exec rm -f {} \;  
  ```  

---

## Error Management  
- **Source Directory Missing:** Logs an error and stops execution.  
- **Failed to Create Destination Directory:** Logs an error and exits.  
- **Backup Errors:** Logs copying or compression failures.  

---

This script makes backing up data simple and efficient, reducing manual effort while safeguarding your important files.
