#!/usr/bin/env osascript -l JavaScript

// ==============================================================================
//  Fast Menu Structure Extractor for macOS Applications
//
//  Retrieves the complete menu bar structure of an application and outputs it
//  as JSON. Optimized for speed by fetching UI element properties in batches,
//  which dramatically reduces expensive inter-process communication calls.
//
//  USAGE:
//    osascript this_script.js "AppName"
//    (If "AppName" is omitted, it targets the current frontmost application)
// ==============================================================================

ObjC.import("stdlib");

function run(argv) {
  // 1. Determine the target application
  const appName = argv[0] || getFrontmostAppName();
  if (!appName) {
    return JSON.stringify({
      error: "Could not determine the frontmost application.",
    });
  }

  try {
    const se = Application("System Events");
    const appProcess = se.processes.byName(appName);

    if (!appProcess.exists()) {
      throw new Error(`Application process "${appName}" was not found.`);
    }

    // 2. Start the recursive extraction from the main menu bar
    const menuBar = appProcess.menuBars[0];
    const menuData = extractMenuItems(menuBar, "");

    // 3. Return the final result as a JSON string
    return JSON.stringify(menuData, null, 2);
  } catch (e) {
    return JSON.stringify({
      error: `An error occurred while processing "${appName}"`,
      message: e.message,
      line: e.line,
    });
  }
}

/**
 * Recursively extracts menu items from a UI element (menu bar or menu).
 * This function is the core of the script and contains the key performance optimization.
 *
 * @param {object} parentElement - The System Events UI element (e.g., menu bar or menu).
 * @param {string} parentPath - The index-based path of the parent element.
 * @returns {Array} An array of objects representing the menu structure.
 */
function extractMenuItems(parentElement, parentPath) {
  // Determine if the parent is a menu bar or a regular menu to get the correct items
  const isMenuBar = parentElement.class() === "menuBar";
  const items = isMenuBar
    ? parentElement.menuBarItems
    : parentElement.menuItems;

  // *** KEY PERFORMANCE OPTIMIZATION ***
  // Instead of querying each property (name, enabled, etc.) one by one in a loop,
  // .properties() fetches ALL properties for ALL items in the collection in a
  // single, efficient call. This is the secret to making the script fast.
  const allItemProperties = items.properties();

  const results = [];
  for (let i = 0; i < allItemProperties.length; i++) {
    const props = allItemProperties[i];
    const name = props.name;

    // Skip the main Apple menu for a cleaner output
    if (isMenuBar && name === "Apple") continue;

    // Handle separators, which are menu items with no name
    const isSeparator = !name;
    if (isSeparator) {
      results.push({
        name: "---",
        separator: true,
        path: `${parentPath ? parentPath + "/" : ""}${i}`,
      });
      continue;
    }

    // The path is 0-indexed, matching the internal structure.
    const currentPath = `${parentPath ? parentPath + "/" : ""}${i}`;

    const menuItem = {
      name: name,
      path: currentPath,
      enabled: props.enabled,
    };

    // Add shortcut if it exists
    if (props.AXMenuItemCmdChar) {
      menuItem.shortcut = buildShortcutString(
        props.AXMenuItemCmdModifiers,
        props.AXMenuItemCmdChar,
      );
    }

    // Add checked state if the item is marked (e.g., with '✓')
    if (props.AXMenuItemMarkChar) {
      menuItem.checked = true;
    }

    // --- RECURSIVE STEP FOR SUBMENUS ---
    // To navigate deeper, we must use the original UI element reference from 'items', not the 'props' object.
    const originalItem = items[i];
    try {
      // Accessing .menus[0] is the most direct way to check for a submenu.
      // It will throw an error if one doesn't exist, which we catch.
      const subMenu = originalItem.menus[0];
      menuItem.items = extractMenuItems(subMenu, currentPath);
    } catch (e) {
      // No submenu exists, so we do nothing.
    }

    results.push(menuItem);
  }
  return results;
}

/**
 * Gets the name of the application currently in the foreground.
 * @returns {string | null}
 */
function getFrontmostAppName() {
  const sysEvents = Application("System Events");
  const frontProcess = sysEvents.applicationProcesses.whose({
    frontmost: true,
  });
  return frontProcess.length > 0 ? frontProcess[0].name() : null;
}

/**
 * Builds a human-readable shortcut string (e.g., "⌘⇧T").
 * @param {number} modifiers - The modifier key code from the accessibility API.
 * @param {string} key - The character key.
 * @returns {string}
 */
function buildShortcutString(modifiers, key) {
  let modString = "";
  // These values are standard bitmasks for modifier keys
  if (modifiers & 4) modString += "⌃"; // Control
  if (modifiers & 2) modString += "⌥"; // Option
  if (modifiers & 1) modString += "⇧"; // Shift
  if (modifiers & 8) modString += "⌘"; // Command
  return modString + (key ? key.toUpperCase() : "");
}
