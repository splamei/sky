This file is meant to store and record all the changes made in the fork. So that's changes we make specifically for this fork (unreleated to Misskey) and the syncs we make with the upstream repo (Misskey's repo)

The order used is the most recent change at the top and oldest change at the end. We won't store releases to this repo here as that's done through `SKY.CHANGELOG.md` and GitHub releases.

We'll seperate the changes into 'Changes' (changes we make specifically for this fork that are unreleated to Misskey), 'Releases' (when we make a release specific to this repo and unreleated to Misskey) and 'Syncs' (changes made to Misskey that we've synced with here)

DD-MM-YYYY is used here

# 02-09-2026

## Changes

- Added `compose_image_example.yml` for using the GHCR image with Docker Compose and updated `README.md` for the new file
- Updated the package name in `deploy.yml` to splamei-sky

# 01-09-2026

## Changes

- Updated the donation message for English
  - The message remains and still directs to Misskey's donation page, but is reworded to prevent user confusion
- Fixed `deploy.yml`

# 31-08-2026

## Changes

- Updated `package.json` for branding and naming chanages for this repo
- Updated `en-US.yml` (English locale) for the project's name and branding (keeping a lot of Misskey's original)
- Changed the boot greet message strings slightly for Splamei Sky branding
- Updated the webpage comment and default description for Splamei Sky branding
- Updated the repository URL to 'https://github.com/misskey-dev/misskey' instead of Misskey's original
  - The original repo is still linked within various areas such as the About page and Modified instance notification
- Changed the name on the about page from 'Misskey' to 'Splamei Sky'
- Improved URL validations inside of `packages/backend/src/core/DownloadService.ts`
- Improved how random values are calculated and determained
- Improved how strings are handled and maniplulated for security

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
- Added `privacy.ts` to mask user's IP addresses (for privacy)
- Made it so sign in requests will mask IP addresses for privacy
- Made it so request headers for sign in requests are no longer stored
- Made it so old signin records will be deleted after 27 days days of the inital attempt
- Changed the 'Login history' text to 'Recent login history' (EN only)
- Added checks to verify URLs in `DownloadService.ts`
- Added better path checks in `InternalStorageService.ts`