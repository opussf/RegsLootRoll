# TODO:

- [x] Determine when in a raid.  -- GetNumGroupMembers() and IsInRaid() should do this.
- [x] Determine who is loot master (watch for change) -- GROUP_ROSTER_UPDATE event and GetRaidRosterInfo() does this.

- [ ] Watch for people joining raid

- [ ] Send message to loot master (on change)  -- Needed?
- [ ] Allow editing of loot rules message.
- [ ] Send Loot rules to new people

- [ ] Watch for Loot Master sending message: [item] roll
- [ ] Watch for players doing a /roll
- [ ] Watch for players doing a :NEED: /roll
- [ ] Watch for players doing a /roll :NEED:
- [ ] Track :NEED: usage