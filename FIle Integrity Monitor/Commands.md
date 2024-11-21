# PowerShell Script Commands and Their Functions

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

11. **`return`**  
    Exits a function and optionally provides a value to the caller.

12. **`-Path`**  
    Specifies the file or directory path for a command.

13. **`-Algorithm`**  
    Specifies the hashing algorithm to be used (e.g., SHA512 in `Get-FileHash`).
