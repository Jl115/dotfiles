#!/usr/bin/env osascript

on run argv
    # --- Validate Input ---
    if (count of argv) is not 2 then
        return "Error: Incorrect number of arguments." & return & "Usage: osascript click_menu_by_path.applescript \"Application Name\" \"Menu/Path/Indices\""
    end if

    set appName to item 1 of argv
    set menuPath to item 2 of argv

    # --- Execute and Handle Errors ---
    try
        my clickMenuPath(appName, menuPath)
    on error errMsg number errNum
        return "Execution failed. Error: " & errMsg & " (Code: " & errNum & ")"
    end try
end run

# --- Main Handler ---
on clickMenuPath(appName as string, pathString as string)
    # --- Pre-flight Checks ---
    tell application "System Events"
        if not (process appName exists) then
            error "Application '" & appName & "' is not running."
        end if
    end tell

    # --- Parse Path ---
    set oldDelimiters to AppleScript's text item delimiters
    set AppleScript's text item delimiters to "/"
    set pathIndices to every text item of pathString as list
    set AppleScript's text item delimiters to oldDelimiters

    if (count of pathIndices) < 1 then
        error "Invalid or empty path provided."
    end if

    # --- UI Scripting ---
    tell application "System Events"
        tell process appName
            set frontmost to true
            delay 0.2 -- Wait for the app to become active and menus to be ready

            # --- Traverse the Menu Path ---
            # Start with the main menu bar
            set parentObject to menu bar 1

            # Loop through each index to navigate deeper into the menus
            repeat with i from 1 to (count of pathIndices)
                set currentIndex to item i of pathIndices as integer

                if i is 1 then
                    # The first item is a menu bar item
                    set currentItem to menu bar item currentIndex of parentObject
                else
                    # Subsequent items are standard menu items
                    set currentItem to menu item currentIndex of menu 1 of parentObject
                end if

                # If this isn't the last item, it becomes the parent for the next loop
                if i < (count of pathIndices) then
                    if not (exists menu 1 of currentItem) then
                        error "Menu item '" & (get name of currentItem) & "' does not have a submenu."
                    end if
                    set parentObject to currentItem
                end if
            end repeat

            # --- Click the Final Item ---
            set finalItemName to name of currentItem
            click currentItem

            return "Success: Clicked '" & finalItemName & "' in " & appName & "."
        end tell
    end tell
end clickMenuPath
