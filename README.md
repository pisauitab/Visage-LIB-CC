## functions
- ``visage.detectMonitors()``: A handy function to detect all monitors, and return them as a list (includes an attribute "n", usable like ``monitors.n``, to see how many monitors were detected);
- ``visage.displayIndexes(mons)``: Displays the blue debug screen with its index number on each monitor on a list;
- ``visage.orderMonitors(mons, userOrder)``: orders monitors according to a custom code. Simply put, it's a list - separated by spaces - of where each monitor has to move (e.g. 3:1 1:12 moves monitor 3 to index 1 and monitor 1 to index 12);
- ``visage.runOnAll(mons, fun)``: Sets a certain function to display on all monitors. Expects a function like ``func(monitor, index)``
- ``visage.setOnAll(mons, fun)``: Sets a certain function to display on all monitors. Expects a function like ``func(monitor, index)``
- ``visage.displayIndex(mon, index)``: Displays the index of the monitor on the monitor's screen.
