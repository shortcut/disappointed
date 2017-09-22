# Disappointed

It just dawned on me that Ruter's API provides some information that
could potentially be very useful, but no services I know of make any
sensible use of: how full in percent each departure of a bus/tram/tube
is at a given time.

So to play around with this and try to find a way to visualize this
information I started messing around with a way to harvest this
information from the API, using the closest stop to the Shortcut
Office – the Øvre Slottsgate tram stop (a.k.a. stop #3010021).

So I wrapped up a very basic Ruby script which can be run on schedule,
eg. every 5 minutes every day over a period of say a month. For each
scheduled arrival at the stop in each direction, I add an entry to a
SQLite database containing:

* The line number of the destination
* The scheduled arrival time
* The expected arrival time (based on this and the scheduled time we
  can extrac the number of minutes this tram is delayed
* A percentage indicating how full the tram is for this departure

My intention is to run this over an extended period of time and then
try to analyze trends in the data based on weekday, time of day and
potentially holidays etc.

It would be really great to use this data to provide a visual clue for
shortcutters about the probable delay for trams at a given time and
the probable percent full the tram will be.

To run the script, adding a row to the database (`data.db`) for each
departure, simply run the script in your terminal:

```shell
ruby import.rb
```

## What now?

I have no idea. If someone wants to elaborate on this, feel free to
hack away. This could be a very simple task to try out data analysis
tools or even machine learning to see what's possible.
