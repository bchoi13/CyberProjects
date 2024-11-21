# PowerShell Script Commands and Their Purposes

## List of Commands Used in the Script

1. **`Write-Host`**  
   Displays messages to the console. Often used for outputting information to the user.

2. **`Read-Host`**  
   Prompts the user for input and returns it as a string.

3. **`Get-FileHash`**  
   Computes the hash value of a file using a specified algorithm (e.g., SHA512).

4. **`Test-Path`**  
   Checks whether a specified path exists.

5. **`Remove-Item`**  
   Deletes the specified item (file, directory, or other object).

6. **`Get-ChildItem`**  
   Retrieves the items (files and directories) in a specified location. Commonly used to list files in a folder.

7. **`foreach`**  
   Iterates over a collection of items, executing the specified code block for each item.

8. **`$()` (Subexpression Operator)**  
   Evaluates the enclosed expression and returns its result, often used for embedding expressions in strings.

9. **`ToUpper()`**  
   Converts a string to uppercase.

10. **`if`**  
    Conditional statement to execute a block of code based on whether a condition evaluates to true.

11. **`elseif`**  
    Used within an `if` statement to specify additional conditions that are checked if the previous `if` condition evaluates to false.

12. **`return`**  
    Exits a function and optionally provides a value to the caller.

13. **`-Path`**  
    Specifies the file or directory path for a command.

14. **`-Algorithm`**  
    Specifies the hashing algorithm to be used (e.g., SHA512 in `Get-FileHash`).

15. **`Function`**  
    Declares a new function in PowerShell. It is used to define reusable blocks of code that can be executed by calling the function by its name.

16. **`ForegroundColor`**  
    Changes the color of the text displayed in the PowerShell console. This is commonly used with `Write-Host` to make certain outputs stand out in a different color.

17. **`Get-Content`**  
    Retrieves the content of a file, typically used to read the contents of a text file and display them or process them further.

18. **`Start-Sleep`**  
    Pauses the script for a specified duration, typically used to introduce delays between commands or actions in the script.

19. **`.Split`**  
    Splits a string into an array based on a specified delimiter or pattern, allowing you to break down text into parts for easier processing.

20. **`.Trim`**  
    Removes leading and trailing whitespace characters from a string. Useful for cleaning up user input or data read from files.

21. **`.Path`**  
    Retrieves the full path of an item (such as a file or directory). Commonly used in file system operations to specify or get the location of files or directories.

22. **`.Hash`**  
    Accesses the hash value of an object, often used in conjunction with file operations such as retrieving the hash of a file in commands like `Get-FileHash`.

23. **`while`**  
    Creates a loop that repeats as long as a specified condition is true. Useful for running a block of code repeatedly.

24. **`$f`**  
    Refers to a variable, commonly used to store values such as file paths, objects, or any other data within the script. It is often used for iteration or temporary storage within loops or conditional blocks.

25. **`-Prompt`**  
    Specifies the message that is shown to the user when they are prompted for input using `Read-Host`. This helps to guide the user or clarify what is expected as input.

26. **`Out-File`**  
    Sends output to a file, effectively redirecting command output into a file rather than displaying it in the console. This is useful for logging or saving data for later use.
