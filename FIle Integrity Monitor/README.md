# What is a FIM?

  A File Integrity Monitor (FIM) is a security tool or system designed to detect and report changes to files, configurations, and other critical system components. It works by creating a baseline of file attributes (e.g., size, hash values, permissions, timestamps) and continuously monitoring for deviations from this baseline.





# File Integrity Monitor Script

This repository contains a custom PowerShell script designed to implement a **File Integrity Monitor (FIM)**. The script monitors designated files and directories for unauthorized changes, helping to ensure the integrity and security of your system.

## Features

- **Baseline Creation**: Captures the initial state of monitored files and directories.
- **Change Detection**: Compares current file states to the baseline to identify modifications, deletions, or additions.
- **Alerts**: Provides notifications when changes are detected.
- **Logging**: Records all detected changes in a log file for auditing purposes.

## How It Works

1. **Setup**: Define the files or directories to monitor.
2. **Baseline Generation**: The script generates a baseline of file attributes (e.g., hashes, permissions, timestamps).
3. **Monitoring**: It periodically checks the current state of the files and compares it to the baseline.
4. **Reporting**: Any discrepancies are logged and optionally displayed to the user.

## Requirements

- **PowerShell**: The script is compatible with PowerShell 5.1 and higher.
- **Permissions**: Ensure the script has appropriate access rights to monitor the specified files and directories.

## Usage

1. Clone this repository:
   ```bash
   git clone https://github.com/bchoi13/File-Integrity-Monitoring/FIMFinal.ps1


2. Navigate to the folder containing the script
   ```bash
   cd file-integrity-monitor


3. Run the script with PowerShell:
   ```powershell
   .\FileIntegrityMonitor.ps1


* You may need to adjust the execution policy to allow running scripts:
   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass


4.  Follow the prompts to configure the monitoring settings.


## Customization

The script is designed to be modular and easily customizable:

- File/Directory List: Modify the section defining paths to monitor.
- Hashing Algorithm: Update the script to use a preferred hashing algorithm, such as SHA256 or MD5.
- Alert Mechanism: Configure email notifications or integrate with your preferred alerting system.

## Limitations

- This script is intended for small- to medium-scale monitoring. For enterprise environments, consider using dedicated FIM solutions.
- Ensure backups are maintained in case critical files are modified.

## Contributions

Contributions and feedback are welcome! If you encounter issues or have suggestions for improvement, feel free to open an issue or submit a pull request.



   

