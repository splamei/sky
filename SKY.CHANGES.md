This file is meant to store and record all the changes made in the fork. So that's changes we make specifically for this fork (unreleated to Misskey) and the syncs we make with the upstream repo (Misskey's repo)

The order used is the most recent change at the top and oldest change at the end. We won't store releases to this repo here as that's done through `SKY.CHANGELOG.md` and GitHub releases.

We'll seperate the changes into 'Changes' (changes we make specifically for this fork that are unreleated to Misskey) and 'Syncs' (changes made to Misskey that we've synced with here)

DD-MM-YYYY is used here

# 30-08-2026

## Changes

- Added `SKY.CHANGES.md`
- Fully updated `README.md` for the purposes of this repo
- Added `deploy.yml` for automatic deployment
- Disabled the federation warning that Misskey does
- Fully updated `CONTRIBUTING.md` for the purposes of this repo
- Added `DCO.md`
- Added our own security policy for this repo to `SECURITY.md` along side Misskey's
- Added `helpers/export.sh` for account data exporting
- Added `helpers/clearUsername.sh` for account username clearing
- Changed the default URL for RSS feeds to 'https://www.veemo.uk/feed'
- Removed some of Misskey's original GitHub workflows