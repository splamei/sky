## Heads up!

This is a modified version of Misskey! All the modifications, new additions and periodic upstream change syncs are listed within the `SKY.CHANGES.md` file

## What is this repo?

This repo is a fork of Misskey for easy updating with my own Misskey server and for some minor adjustments. The extra changes are not designed with support for third-party servers in-mind (though I try too anyway). This repo exists for transparency and to comply with Misskey's licence.

If you want to try Misskey, use their [official website and repo](https://github.com/misskey-dev/misskey) for the best support and latest features.

This fork does maintain upstream changes which we sync every so often.

## How can I run this?

### Using the image

> The image is automatically built using a GitHub workflow instead of using commands. You can view the workflow used in `.github/workflows/deploy.yml`

1. Make the location for the container and change directory into it
2. Setup docker for your usage
3. Run `mkdir -p ~/misskey/.config ~/misskey/files ~/misskey/db ~/misskey/redis` to create the needed directories
4. Sometimes, to allow media uploads, you may need to run this command so everything works correctly - `sudo chown -R 991:991 /home/misskeyUser/misskey/files`
5. Create `.config/default.yml` and have the contents the same as the `.config/docker_example.yml` file from this repo with some adjustments you would like
	- You should change the default username and password to secure your database and the setup password to secure the initial setup of Misskey
6. Create `docker-compose.yml` and have the contents the same as the `.config/docker_image_example.yml` file from this repo with some adjustments you would like
7. Create `.config/docker.env` and have the contents the same as the `.config/docker_example.env` file from this repo with some adjustments you would like
	- You should change the username and password to match the ones inside `.config/default.yml` to allow everything to run correctly
8. Run `docker compose run --rm web pnpm run init` to configure everything correctly
9. Run `docker compose up -d` to start up Misskey

### Using the repo

 1. Clone the repo and use the main branch
    - `git clone -b master https://github.com/misskey-dev/misskey.git`
    - `cd misskey`
    - `git checkout master`
2. Create `.config/default.yml` and have the contents the same as the `.config/docker_example.yml` file from this repo with some adjustments you would like
	- You should change the default username and password to secure your database and the setup password to secure the initial setup of Misskey
3. Create `docker-compose.yml` and have the contents the same as the `.config/docker_image_example.yml` file from this repo with some adjustments you would like
4. Create `.config/docker.env` and have the contents the same as the `.config/docker_example.env` file from this repo with some adjustments you would like
	- You should change the username and password to match the ones inside `.config/default.yml` to allow everything to run correctly
5. Use `sudo docker compose build` and `sudo docker compose run --rm web pnpm run init` to prepare the container
6. Finally, run `sudo docker compose up -d` to run it!

## Extra notes

The name, branding, logo, etc. and any related assets for SplameiPlay and SplameiPlay is property of Splamei. These assets are not licensed under the AGPL licence.

Any and all forks and derived works must use a different name and cannot imply endorsement or affiliation with Splamei, SplameiPlay or projects.

This repository is not endorsed, affiliated or associated with Misskey or any other related brands or platforms.
